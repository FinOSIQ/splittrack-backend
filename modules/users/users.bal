import splittrack_backend.db;
import splittrack_backend.interceptor as utils;

import ballerina/http;
import ballerina/log;
import ballerina/persist;

final db:Client dbClient = check new ();

public function hello(string? name) returns string {
    if name !is () {
        return string `Hello, ${name}`;
    }
    return "Hello, World!";
}

public function getUserService() returns http:Service {
    return service object {
        resource function get sayHello(http:Caller caller, http:Request req) returns error? {

            boolean|error isValid = utils:authenticate(req);
            if isValid is error || !isValid {
                http:Response res = new;
                res.statusCode = 401;
                res.setPayload({"error": "Unauthorized", "message": "Invalid or expired token"});
                check caller->respond(res);
                return;
            }
            http:Response res = new;
            res.setPayload({"message": "Hello from authenticated endpoint"});
            check caller->respond(res);

        }

        resource function post createUser(http:Caller caller, http:Request req, @http:Header string authorization) returns http:Created & readonly|error? {

            http:Response response = new;

            boolean|error isValid = utils:authenticate(req);
            if isValid is error || !isValid {
                response.statusCode = 401;
                response.setPayload({"error": "Unauthorized", "message": "Invalid or expired token"});
                check caller->respond(response);
                return;
            }

            string? authHeader = check req.getHeader("Authorization");
            if authHeader is () || !authHeader.startsWith("Bearer ") {
                return;
            }
            string accessToken = authHeader.substring(7).trim();

            http:Client userInfoClient = check new ("https://api.asgardeo.io/t/sparkz/oauth2/userinfo");
            http:Response|error userInfoResp = userInfoClient->get("", headers = {
                "Authorization": "Bearer " + accessToken
            });
            if userInfoResp is error {
                log:printError("Failed to fetch user info: " + userInfoResp.message());
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setJsonPayload({"status": "error", "message": "Failed to fetch user info"});
                return caller->respond(response);
            }

            if userInfoResp.statusCode != http:STATUS_OK {
                log:printError("Failed to fetch user info: " + userInfoResp.statusCode.toString());
                response.statusCode = http:STATUS_UNAUTHORIZED;
                response.setJsonPayload({"status": "error", "message": "Invalid access token"});
                return caller->respond(response);
            }

            json userInfo = check userInfoResp.getJsonPayload();

            string id = check userInfo.sub.ensureType(string);
            string email = check userInfo.email.ensureType(string);
            string firstName = check userInfo.given_name.ensureType(string);
            string lastName = check userInfo.family_name.ensureType(string);
            string birthdate = check userInfo.birthdate.ensureType(string);
            string phoneNumber = check userInfo.phone_number.ensureType(string);

            db:UserWithRelations|persist:Error existingUser = dbClient->/users/[id].get(db:UserWithRelations);
            if existingUser is db:UserWithRelations {
                response.statusCode = http:STATUS_OK;
                response.setJsonPayload({"status": "success", "message": "User already exists", "userId": id});
                return caller->respond(response);
            } else if existingUser is persist:NotFoundError {
                db:User newUser = {
                    user_Id: id,
                    email: email,
                    first_name: firstName,
                    last_name: lastName,
                    birthdate: birthdate,
                    phone_number: phoneNumber,
                    currency_pref: "USD"
                };

                string[]|error result = dbClient->/users.post([newUser]);
                if result is error {
                    log:printError("Database error: " + result.message());
                    response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                    response.setJsonPayload({"status": "error", "message": "Failed to create user in database"});
                    return caller->respond(response);
                }

                response.statusCode = http:STATUS_CREATED;
                response.setJsonPayload({
                    "status": "success",
                    "message": "User created successfully",
                    "userId": id
                });
                return caller->respond(response);
            } else {
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setJsonPayload({"status": "error", "message": "Database error"});
                return caller->respond(response);
            }

        }

    };

}

