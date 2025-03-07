import splittrack_backend.db;
import splittrack_backend.users;

import ballerina/http;
import ballerina/io;
import ballerina/regex;
import ballerina/sql;

// Configure the main listener
listener http:Listener httpListener = new (9000);

public function main() returns error? {

    check executeSqlScript();
    // Attach the services directly
    check httpListener.attach(users:getUserService(), "/users");

    // Start the listener
    check httpListener.start();
}

// Function to execute the SQL script automatically
function executeSqlScript() returns error? {
    db:Client dbClient = check new ();
    string sqlContent = check io:fileReadString("modules/db/script.sql");
    string[] queries = regex:split(sqlContent, ";");

    foreach var query in queries {
        string bal = "DROP TABLE IF EXISTS Use";
        sql:ParameterizedQuery queryOne = `${bal}`;
        _ = check dbClient->executeNativeSQL(queryOne);
    }
}

