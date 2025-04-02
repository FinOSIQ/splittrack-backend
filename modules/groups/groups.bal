import splittrack_backend.db_scripts;

import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/sql;

type GroupResponse record {|
    json|error group?;
    json|error members?;
|};

// HTTP Service for Group CRUD Operations
public function getGroupService() returns http:Service {
    return service object {
        // CREATE: Add a new group with optional initial members
        resource function post groups(http:Caller caller, http:Request req) returns error? {
            
            json payload = check req.getJsonPayload();
            
            
            json|error nameJson = payload.name;
            if nameJson is error || nameJson is () {
                http:Response res = new;
                res.statusCode = http:STATUS_BAD_REQUEST;
                res.setPayload({"error": "Missing or invalid 'name' field"});
                check caller->respond(res);
                return;
            }
            string name = nameJson.toString();
            
            json?|error members = payload.members is json ? payload.members : ();
            if members is error {
                http:Response res = new;
                res.statusCode = http:STATUS_BAD_REQUEST;
                res.setPayload({"error": "Invalid 'members' field"});
                check caller->respond(res);
                return;
            }

            // Insert group
            sql:ParameterizedQuery groupQuery = `INSERT INTO usergroup (name) VALUES (${name})`;
            sql:ExecutionResult result = check db_scripts:dbClient->execute(groupQuery);
            int groupId = check result.lastInsertId.ensureType();

            // Insert members if provided
            json[] memberResults = [];
            if members is json[] {
                foreach json member in members {
                    string userId = check member.userId.toString();
                    string role = check member.role.toString();
                    sql:ParameterizedQuery memberQuery = `INSERT INTO usergroupmember (group_Id, user_Id, member_role) 
                                                         VALUES (${groupId}, ${userId}, ${role})`;
                    _ = check db_scripts:dbClient->execute(memberQuery);
                    memberResults.push({"userId": userId, "role": role});
                }
            }

            GroupResponse response = {group: {"group_Id": groupId, "name": name}, members: memberResults};
            check caller->respond(response.toJson());
        }

        // READ: Get group details and its members
        resource function get groups/[int groupId](http:Caller caller, http:Request req) returns error? {
            GroupResponse response = fetchGroupDetails(groupId);
            check caller->respond(response.toJson());
        }

        // READ: Get all groups (optional filtering by name)
        resource function get groups(http:Caller caller, http:Request req) returns error? {
            map<string[]> queryParams = req.getQueryParams();
            string? nameFilter = queryParams.hasKey("name") ? queryParams.get("name")[0] : ();

            sql:ParameterizedQuery query = nameFilter is string
                ? `SELECT group_Id, name FROM usergroup WHERE name LIKE ${"%" + nameFilter + "%"}`
                : `SELECT group_Id, name FROM usergroup`;
            stream<record {}, error?> resultStream = db_scripts:dbClient->query(query);
            json groups = check convertStreamToJson(resultStream);
            check caller->respond({"groups": groups});
        }

        // UPDATE: Modify group name and/or members
        resource function put groups/[int groupId](http:Caller caller, http:Request req) returns error? {
            json payload = check req.getJsonPayload();
            string? name = payload.name is string ? payload.name.toString() : ();
            json[]? members = payload.members is json[] ? payload.members : ();

            // Update group name if provided
            if name is string {
                sql:ParameterizedQuery updateQuery = `UPDATE usergroup SET name = ${name} WHERE group_Id = ${groupId}`;
                _ = check db_scripts:dbClient->execute(updateQuery);
            }

            // Update members if provided (delete existing, insert new)
            if members is json[] {
                sql:ParameterizedQuery deleteQuery = `DELETE FROM usergroupmember WHERE group_Id = ${groupId}`;
                _ = check db_scripts:dbClient->execute(deleteQuery);

                json[] memberResults = [];
                foreach json member in members {
                    string userId = check member.userId.toString();
                    string role = check member.role.toString();
                    sql:ParameterizedQuery insertQuery = `INSERT INTO usergroupmember (group_Id, user_Id, member_role) 
                                                         VALUES (${groupId}, ${userId}, ${role})`;
                    _ = check db_scripts:dbClient->execute(insertQuery);
                    memberResults.push({"userId": userId, "role": role});
                }
                check caller->respond({"group": {"group_Id": groupId, "name": name ?: fetchGroupName(groupId)}, "members": memberResults});
            } else {
                check caller->respond({"group": {"group_Id": groupId, "name": name ?: fetchGroupName(groupId)}});
            }
        }

        // DELETE: Remove a group and its members
        resource function delete groups/[int groupId](http:Caller caller, http:Request req) returns error? {
            // Delete members first (due to foreign key constraints)
            sql:ParameterizedQuery deleteMembersQuery = `DELETE FROM usergroupmember WHERE group_Id = ${groupId}`;
            _ = check db_scripts:dbClient->execute(deleteMembersQuery);

            // Delete group
            sql:ParameterizedQuery deleteGroupQuery = `DELETE FROM usergroup WHERE group_Id = ${groupId}`;
            sql:ExecutionResult result = check db_scripts:dbClient->execute(deleteGroupQuery);

            if result.affectedRowCount == 0 {
                http:Response res = new;
                res.statusCode = http:STATUS_NOT_FOUND;
                res.setPayload({"error": "Group not found"});
                check caller->respond(res);
                return;
            }

            check caller->respond({"message": "Group deleted successfully"});
        }
    };
}

// Helper function to fetch group details (group + members)
function fetchGroupDetails(int groupId) returns GroupResponse {
    // Fetch group
    sql:ParameterizedQuery groupQuery = `SELECT group_Id, name FROM usergroup WHERE group_Id = ${groupId}`;
    stream<record {}, error?> groupStream = db_scripts:dbClient->query(groupQuery);
    json groupData = check convertStreamToJson(groupStream);
    if groupData is json[] && groupData.length() == 0 {
        return {group: error("Group not found")};
    }

    // Fetch members
    sql:ParameterizedQuery memberQuery = `SELECT group_member_Id, user_Id, member_role 
                                         FROM usergroupmember WHERE group_Id = ${groupId}`;
    stream<record {}, error?> memberStream = db_scripts:dbClient->query(memberQuery);
    json members = check convertStreamToJson(memberStream);

    return {group: groupData[0], members: members};
}

// Helper function to fetch group name (for PUT when name isn’t updated)
function fetchGroupName(int groupId) returns string|error {
    sql:ParameterizedQuery query = `SELECT name FROM usergroup WHERE group_Id = ${groupId}`;
    record {|string name;|} result = check db_scripts:dbClient->queryRow(query);
    return result.name;
}

// Reuse your stream-to-JSON converter
function convertStreamToJson(stream<record {}, error?> scanRecords) returns json {
    json[] output = [];
    error? e = scanRecords.forEach(function(record {} scanRecord) {
        output.push(scanRecord.toJson());
    });

    if e is error {
        log:printError("Stream processing failed", 'error = e);
        return {"error": e.message()};
    }
    return output;
}
