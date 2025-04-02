

import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/sql;
import splittrack_backend.db_scripts;

type SearchResponse record {
    json|error users?;
    json|error friends?;
    json|error groups?;
};

// Function returning `http:Service`
public function getSearchService() returns http:Service {
    return service object {
        resource function get search(http:Caller caller, http:Request req) returns error? {
            // Get query parameters
            map<string[]> queryParams = req.getQueryParams();
            string? searchValue = queryParams.hasKey("value") ? queryParams.get("value")[0] : ();
            string? userId = queryParams.hasKey("userId") ? queryParams.get("userId")[0] : (); 
            string[] searchTypes = queryParams.get("type") is string[] ? queryParams.get("type") : [];



            io:println(searchTypes.length());
            if searchValue == () || searchTypes.length() == 0 {
                http:Response res = new;
                res.statusCode = http:STATUS_BAD_REQUEST;
                res.setPayload({"error": "Missing 'value' or 'type' query parameter"});
                check caller->respond(res);
                return;
            }

            if searchTypes.indexOf("friends") != () && userId == () {
                http:Response res = new;
                res.statusCode = http:STATUS_BAD_REQUEST;
                res.setPayload({"error": "Missing 'userId' query parameter for friends search"});
                check caller->respond(res);
                return;
            }

            
            // Validate types
            // string[] validTypes = ["users", "friends", "groups"];

            SearchResponse result = searchDatabase(searchValue, searchTypes,userId);
            check caller->respond(result.toString().toJson());
        }
    };
}

// Function to query the database based on multiple search types
function searchDatabase(string value, string[] types, string? userId) returns SearchResponse {
    SearchResponse response = {};

    if types.indexOf("users") != () {
        response.users = searchUsers(value);
    }
    if types.indexOf("friends") != () {
        response.friends = searchFriends(userId,value);
    }
    if types.indexOf("groups") != () {
        response.groups = searchGroups(value);
    }

    return response;
}

// Function to search users
function searchUsers(string value) returns json|error {
    sql:ParameterizedQuery query = `SELECT user_id, name, email 
                                    FROM user 
                                    WHERE name LIKE ${"%" + value + "%"} 
                                       OR email LIKE ${"%" + value + "%"}`;
    stream<record {}, error?> resultStream = db_scripts:dbClient->query(query);
    return convertStreamToJson(resultStream);
}

// Function to search friends
// Fixed function for searching friends
function searchFriends(string? userId, string value) returns json|error {
    if userId == () {
        return {"error": "userId is required for friends search"};
    }

    string searchTerm = "%" + value + "%";
    sql:ParameterizedQuery query = `SELECT u.user_id, u.name, u.email
                                    FROM friend f
                                    JOIN user u ON u.user_id = 
                                        CASE 
                                            WHEN f.user_id_1User_Id = ${userId} THEN f.user_id_2User_Id
                                            WHEN f.user_id_2User_Id = ${userId} THEN f.user_id_1User_Id
                                        END
                                    WHERE (f.user_id_1User_Id = ${userId} OR f.user_id_2User_Id = ${userId})
                                    AND u.name LIKE ${searchTerm}`;
    
    stream<record {}, error?> resultStream = db_scripts:dbClient->query(query);
    return convertStreamToJson(resultStream);
}

// Fixed function for searching groups
function searchGroups(string value) returns json|error {
    string searchTerm = "%" + value + "%";
    sql:ParameterizedQuery query = `SELECT group_id, name FROM usergroup 
                                    WHERE name LIKE ${searchTerm}`;
    stream<record {}, error?> resultStream = db_scripts:dbClient->query(query);
    return convertStreamToJson(resultStream);
}

// Helper function to convert stream result to JSON
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

