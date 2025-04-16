// import splittrack_backend.db;

// import ballerina/sql;
import splittrack_backend.db_scripts as generator;
import splittrack_backend.db_scripts as db_setup;
import splittrack_backend.users;

import ballerina/http;
import ballerina/io;
import splittrack_backend.search;
import splittrack_backend.groups;
import splittrack_backend.expense;

// Configure the main listener
listener http:Listener httpListener = new (9090);

public function main() returns error? {


    check httpListener.attach(users:getUserService(), "api_user/v1");
    check httpListener.attach(expense:getExpenseService(), "api_expense/v1");
    check httpListener.attach(groups:getGroupService(), "api_group/v1");
    check httpListener.attach(search:getSearchService(), "api_search/v1");
    check executeSqlScript();
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

