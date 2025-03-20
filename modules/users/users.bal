import splittrack_backend.db;
import splittrack_backend.email as emailInterceptor;
import splittrack_backend.interceptor as authInterceptor;
import splittrack_backend.utils as id_store_util;

import ballerina/http;
import ballerina/log;
import ballerina/persist;
import ballerina/io;

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

            io:println("Hello from the user service");
            
            string stringResult = check id_store_util:generateUniqueExpenseId();
            io:println(`${stringResult}`);

            boolean booleanResult = id_store_util:storeId(stringResult);
            io:println(`${booleanResult.toString()}`);

            string[] listResult = id_store_util:getAllIds();
            if listResult.length() > 0 {
                foreach var id in listResult {
                    io:println("ID: " + id);
                }
            } else {
                io:println("No IDs found");
            }

            io:println("\n\n");

            string stringResult2 = check id_store_util:generateUniqueExpenseId();
            io:println(`${stringResult2}`);

            boolean booleanResult2 = id_store_util:storeId(stringResult2);
            io:println(`${booleanResult2.toString()}`);

            string[] listResult2 = id_store_util:getAllIds();
            if listResult2.length() > 0 {
                foreach var id in listResult {
                    io:println("ID: " + id);
                }
            } else {
                io:println("No IDs found");
            }

            http:Response res = new;
            res.setPayload({"message": "Hello from authenticated endpoint"});
            check caller->respond(res);

        }

        // CREATE USER
        resource function post user(http:Caller caller, http:Request req, @http:Header string authorization) returns http:Created & readonly|error? {

            http:Response response = new;

            boolean|error isValid = authInterceptor:authenticate(req);
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

            db:UserWithRelations|persist:Error existingUser = dbClient->/users/[id];
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

                // Use the imported email function
                emailInterceptor:UserRegistrationEmailParams emailParams = {
                    recipientEmail: email,
                    firstName: firstName,
                    userId: id
                };

                string message = "User created successfully";

                boolean|error emailSent = emailInterceptor:sendUserRegistrationEmail(emailParams);
                if emailSent is error {
                    message = message + ". Email failed: " + emailSent.message();
                } else {
                    message = message + ". Email sent successfully";
                }

                response.statusCode = http:STATUS_CREATED;
                response.setJsonPayload({
                    "status": "success",
                    "message": message,
                    "userId": id
                });
                return caller->respond(response);
            } else {
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setJsonPayload({"status": "error", "message": "Database error"});
                return caller->respond(response);
            }

        }

        // UPDATE USER
        resource function put user/[string id](http:Caller caller, http:Request req, @http:Header string authorization, @http:Payload UserUpdatePayload payload) returns http:Ok & readonly|error? {

            http:Response response = new;

            boolean|error isValid = authInterceptor:authenticate(req);
            if isValid is error || !isValid {
                response.statusCode = 401;
                response.setPayload({"error": "Unauthorized", "message": "Invalid or expired token"});
                check caller->respond(response);
                return;
            }

            db:UserWithRelations|persist:Error existingUser = dbClient->/users/[id](db:User);
            if existingUser is persist:NotFoundError {
                response.statusCode = http:STATUS_NOT_FOUND;
                response.setJsonPayload({"status": "error", "message": "User not found"});
                return caller->respond(response);
            } else if existingUser is persist:Error {
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setJsonPayload({"status": "error", "message": "Database error"});
                return caller->respond(response);
            }

            db:UserUpdate updateData = {
                first_name: payload.first_name,
                last_name: payload.last_name,
                phone_number: payload.phone_number,
                birthdate: payload.birthdate,
                currency_pref: payload.currency_pref
            };

            db:User|persist:Error result = dbClient->/users/[id].put(updateData);
            if result is persist:Error {
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setJsonPayload({"status": "error", "message": "Failed to update user"});
                return caller->respond(response);
            }

            response.statusCode = http:STATUS_OK;
            response.setJsonPayload({"status": "success", "message": "User updated successfully", "userId": id});
            return caller->respond(response);

        }

        // GET ALL USERS
        resource function get user(http:Caller caller, http:Request req) returns http:Ok & readonly|error? {
            http:Response response = new;

            stream<db:UserWithRelations, persist:Error?> userStream = dbClient->/users;
            db:UserWithRelations[] users = check from db:UserWithRelations user in userStream
                select user;

            response.statusCode = http:STATUS_OK;
            response.setJsonPayload({
                "status": "success",
                "message": "Users retrieved successfully",
                "data": users
            });
            return caller->respond(response);
        }

        // GET USER BY ID
        resource function get user/[string id](http:Caller caller, http:Request req, @http:Header string authorization) returns http:Ok & readonly|error? {
            http:Response response = new;

            boolean|error isValid = authInterceptor:authenticate(req);
            if isValid is error || !isValid {
                response.statusCode = 401;
                response.setPayload({"error": "Unauthorized", "message": "Invalid or expired token"});
                check caller->respond(response);
                return;
            }

            db:UserWithRelations|persist:Error user = dbClient->/users/[id];
            if user is persist:NotFoundError {
                response.statusCode = http:STATUS_NOT_FOUND;
                response.setJsonPayload({"status": "error", "message": "User not found"});
                return caller->respond(response);
            } else if user is persist:Error {
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setJsonPayload({"status": "error", "message": "Database error"});
                return caller->respond(response);
            }

            response.statusCode = http:STATUS_OK;
            response.setJsonPayload({
                "status": "success",
                "message": "User retrieved successfully",
                "data": user is db:UserWithRelations ? user.toJson() : {}
            });
            return caller->respond(response);
        }

        // DELETE USER BY ID
        resource function delete user/[string id](http:Caller caller, http:Request req, @http:Header string authorization) returns http:Ok & readonly|error? {
            http:Response response = new;

            boolean|error isValid = authInterceptor:authenticate(req);
            if isValid is error || !isValid {
                response.statusCode = 401;
                response.setPayload({"error": "Unauthorized", "message": "Invalid or expired token"});
                check caller->respond(response);
                return;
            }

            db:User|persist:Error result = dbClient->/users/[id].delete();
            if result is persist:NotFoundError {
                response.statusCode = http:STATUS_NOT_FOUND;
                response.setJsonPayload({"status": "error", "message": "User not found"});
                return caller->respond(response);
            } else if result is persist:Error {
                response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
                response.setJsonPayload({"status": "error", "message": result.message()});
                return caller->respond(response);
            }

            response.statusCode = http:STATUS_OK;
            response.setJsonPayload({
                "status": "success",
                "message": "User deleted successfully",
                "userId": id
            });
            return caller->respond(response);
        }

    };

}

