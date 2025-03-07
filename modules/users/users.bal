import ballerina/http;
import splittrack_backend.db;

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
            string message = hello("sonal");
            check caller->respond(message);
        }

        resource function post addUser(http:Caller caller, http:Request req) returns http:Created & readonly|http:BadRequest & readonly|error {
            json payload = check req.getJsonPayload();
            // Try to convert JSON to CustomerCreateRequest type
            CustomerRequest|error customerRequest = payload.cloneWithType(CustomerRequest);
            // Check if type conversion was successful
            if customerRequest is error {
                // Return BadRequest if type conversion fails
                http:Response resp = new;
                resp.statusCode = 400;
                resp.setPayload({ "error": "Invalid request format", "details": customerRequest.message() });
                check caller->respond(resp);    
                
            }


            db:UserInsert customer = check payload.cloneWithType(db:UserInsert);
            _ = check dbClient->/users.post([customer]);
            check caller->respond("Book added successfully");
            return http:CREATED;
        }
    };
}