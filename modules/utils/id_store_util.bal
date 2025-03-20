import splittrack_backend.db as db;

import ballerina/log;
import ballerina/persist;
import ballerina/uuid;

final db:Client dbClient = check new ();

map<string> idStore = {};

public function storeId(string id) returns boolean {
    idStore[id] = id;
    return true;
}

public function getAllIds() returns string[] {
    return idStore.keys();
}

public function checkAndRemoveId(string id) returns string {
    if idStore.hasKey(id) {
        _ = idStore.remove(id);
        return "ID deleted successfully.";
    } else {
        return "ID doesn’t exist.";
    }
}

public function generateUniqueExpenseId() returns string|error {
    string newId = "";
    boolean isUnique = false;

    while (!isUnique) {
        newId = uuid:createType4AsString();

        if idStore.hasKey(newId) {
            continue; 
        }

        db:Expense|persist:Error expense = dbClient->/expenses/[newId];
        if expense is persist:NotFoundError {
            isUnique = true;
        } else if expense is persist:Error {
            log:printError("Database error while checking expense ID: " + expense.message());
            return expense;
        } else {
            continue;
        }
    }

    boolean status = storeId(newId);
    if (status) {
        return newId;
    }

    return "Error Creating Unique ID";

}
