// import splittrack_backend.db;

// import ballerina/sql;
import splittrack_backend.db_scripts as generator;
import splittrack_backend.db_scripts as db_setup;
import splittrack_backend.users;

import ballerina/http;
import ballerina/io;

// Configure the main listener
listener http:Listener httpListener = new (9090);

public function main() returns error? {

    check executeSqlScript();
    check httpListener.attach(users:getUserService(), "api/users");

    check httpListener.start();
}

function executeSqlScript() returns error? {
    future<error?> genFuture = start generator:generateDbSetup();
    error? genResult = wait genFuture;
    if genResult is error {
        io:println("Error generating db_setup.bal: ", genResult.message());
        return genResult;
    }

    future<error?> execFuture = start db_setup:createTables();
    error? execResult = wait execFuture;
    if execResult is error {
        io:println("Error executing SQL queries: ", execResult.message());
        return execResult;
    }

    io:println("Database setup completed successfully");
}

