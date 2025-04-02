import ballerinax/mysql;

public final mysql:Client dbClient = check new (
    host = "localhost",
    user = "root",
    password = "",
    port = 3306,
    database = "splittrack"
);