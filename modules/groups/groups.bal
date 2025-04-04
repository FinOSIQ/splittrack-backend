import splittrack_backend.db as db;
import splittrack_backend.utils;

import ballerina/http;
import ballerina/persist;
import ballerina/uuid;

// import ballerina/io;
// import ballerina/sql;

type GroupResponse record {|
    json|error group?;
    json|error members?;
|};

final db:Client dbClient = check new ();

// HTTP Service for Group CRUD Operations
public function getGroupService() returns http:Service {

    return service object {

        // CREATE: Add a new group with optional initial members
        resource function post groups(http:Caller caller, http:Request req) returns error? {

            json payload = check req.getJsonPayload();

            json|error nameJson = payload.name;
            if nameJson is error || nameJson is () {
                return utils:sendErrorResponse(caller, http:STATUS_BAD_REQUEST, "Missing 'name' field");
            }
            string name = nameJson.toString();

            json?|error members = payload.members is json ? payload.members : ();
            if members is error || !(members is json[]) {
                return utils:sendErrorResponse(caller, http:STATUS_BAD_REQUEST, "Invalid 'members' field", "Expected an array of members");
            }

            // Insert group
            string group_Id = uuid:createType4AsString();
            db:UserGroupInsert[] group = [{group_Id: group_Id, name: name}];
            transaction {
                _ = check dbClient->/usergroups.post(group);

                // Insert members if provided
                db:UserGroupMemberInsert[] memberResults = [];

                foreach json member in members {
                    json|error userIdJson = member.userId;
                    json|error roleJson = member.role;

                    if userIdJson is error || userIdJson is () {
                        fail error("Missing or invalid 'userId' in member", statusCode = http:STATUS_BAD_REQUEST);

                    }
                    if roleJson is error || roleJson is () {
                        fail error("Missing or invalid 'role' in member", statusCode = http:STATUS_BAD_REQUEST);
                    }

                    string userId = userIdJson.toString();
                    string role = roleJson.toString();
                    string groupMemberId = uuid:createType4AsString();

                    memberResults.push({
                        group_member_Id: groupMemberId,
                        userUser_Id: userId,
                        member_role: role,
                        groupGroup_Id: group_Id
                    });
                }

                if memberResults.length() > 0 {
                    _ = check dbClient->/usergroupmembers.post(memberResults);
                }
                check commit;

            } on fail error e {
                // Transaction failed (rolled back automatically)
                int statusCode;
                map<anydata> details = <map<anydata>>e.detail();
                if details.hasKey("statusCode") {
                    statusCode = check details.get("statusCode").ensureType(int);
                } else {
                    statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                }

                return utils:sendErrorResponse(caller, statusCode, "Failed to create group", e.message());

            }

            http:Response res = new;
            res.statusCode = http:STATUS_CREATED; // 201
            res.setJsonPayload(group);
            check caller->respond(res);

        }

        // READ: Get group details and its members
        resource function get groups/[string groupId](http:Caller caller, http:Request req) returns error? {

            db:UserGroupWithRelations|error groupDetails = dbClient->/usergroups/[groupId]();
            if groupDetails is error {
                // Check if the error is a "not found" error
                if groupDetails is persist:NotFoundError {
                    return utils:sendErrorResponse(caller, http:STATUS_NOT_FOUND, "Group not found", "Group with ID " + groupId + " does not exist");
                }
                // Other database errors
                return utils:sendErrorResponse(caller, http:STATUS_INTERNAL_SERVER_ERROR, groupDetails.toString());
            }
            http:Response res = new;
            json payload = {
                "group": groupDetails
            };
            res.setJsonPayload(payload);
            res.statusCode = http:STATUS_OK;
            return caller->respond(res);

        }

        // // READ: Get all groups (optional filtering by name)
        // resource function get groups(http:Caller caller, http:Request req) returns error? {
        //     map<string[]> queryParams = req.getQueryParams();
        //     string? nameFilter = queryParams.hasKey("name") ? queryParams.get("name")[0] : ();

        //     sql:ParameterizedQuery query = nameFilter is string
        //         ? `SELECT group_Id, name FROM usergroup WHERE name LIKE ${"%" + nameFilter + "%"}`
        //         : `SELECT group_Id, name FROM usergroup`;
        //     stream<record {}, error?> resultStream = db_scripts:dbClient->query(query);
        //     json groups = check convertStreamToJson(resultStream);
        //     check caller->respond({"groups": groups});
        // }

        // // UPDATE: Modify group name and/or members
        // resource function put groups/[int groupId](http:Caller caller, http:Request req) returns error? {
        //     json payload = check req.getJsonPayload();
        //     string? name = payload.name is string ? payload.name.toString() : ();
        //     json[]? members = payload.members is json[] ? payload.members : ();

        //     // Update group name if provided
        //     if name is string {
        //         sql:ParameterizedQuery updateQuery = `UPDATE usergroup SET name = ${name} WHERE group_Id = ${groupId}`;
        //         _ = check db_scripts:dbClient->execute(updateQuery);
        //     }

        //     // Update members if provided (delete existing, insert new)
        //     if members is json[] {
        //         sql:ParameterizedQuery deleteQuery = `DELETE FROM usergroupmember WHERE group_Id = ${groupId}`;
        //         _ = check db_scripts:dbClient->execute(deleteQuery);

        //         json[] memberResults = [];
        //         foreach json member in members {
        //             string userId = check member.userId.toString();
        //             string role = check member.role.toString();
        //             sql:ParameterizedQuery insertQuery = `INSERT INTO usergroupmember (group_Id, user_Id, member_role) 
        //                                                  VALUES (${groupId}, ${userId}, ${role})`;
        //             _ = check db_scripts:dbClient->execute(insertQuery);
        //             memberResults.push({"userId": userId, "role": role});
        //         }
        //         check caller->respond({"group": {"group_Id": groupId, "name": name ?: fetchGroupName(groupId)}, "members": memberResults});
        //     } else {
        //         check caller->respond({"group": {"group_Id": groupId, "name": name ?: fetchGroupName(groupId)}});
        //     }
        // }

        // // DELETE: Remove a group and its members
        // resource function delete groups/[int groupId](http:Caller caller, http:Request req) returns error? {
        //     // Delete members first (due to foreign key constraints)
        //     sql:ParameterizedQuery deleteMembersQuery = `DELETE FROM usergroupmember WHERE group_Id = ${groupId}`;
        //     _ = check db_scripts:dbClient->execute(deleteMembersQuery);

        //     // Delete group
        //     sql:ParameterizedQuery deleteGroupQuery = `DELETE FROM usergroup WHERE group_Id = ${groupId}`;
        //     sql:ExecutionResult result = check db_scripts:dbClient->execute(deleteGroupQuery);

        //     if result.affectedRowCount == 0 {
        //         http:Response res = new;
        //         res.statusCode = http:STATUS_NOT_FOUND;
        //         res.setPayload({"error": "Group not found"});
        //         check caller->respond(res);
        //         return;
        //     }

        //     check caller->respond({"message": "Group deleted successfully"});
        // }
    };
}

