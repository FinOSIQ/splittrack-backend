import ballerina/sql;
import splittrack_backend.db;

// Auto-generated file containing SQL queries from the persist SQL file

sql:ParameterizedQuery query1 = `DROP TABLE IF EXISTS ExpenseParticipant`;
sql:ParameterizedQuery query2 = `DROP TABLE IF EXISTS Settlement`;
sql:ParameterizedQuery query3 = `DROP TABLE IF EXISTS Friend`;
sql:ParameterizedQuery query4 = `DROP TABLE IF EXISTS Expense`;
sql:ParameterizedQuery query5 = `DROP TABLE IF EXISTS UserGroupMember`;
sql:ParameterizedQuery query6 = `DROP TABLE IF EXISTS Card`;
sql:ParameterizedQuery query7 = `DROP TABLE IF EXISTS User`;
sql:ParameterizedQuery query8 = `DROP TABLE IF EXISTS Transaction`;
sql:ParameterizedQuery query9 = `DROP TABLE IF EXISTS BankAccount`;
sql:ParameterizedQuery query10 = `DROP TABLE IF EXISTS UserGroup`;
sql:ParameterizedQuery query11 = `CREATE TABLE UserGroup (
groupId INT NOT NULL,
name VARCHAR(191) NOT NULL,
PRIMARY KEY(groupId)
)`;
sql:ParameterizedQuery query12 = `CREATE TABLE BankAccount (
accountId INT NOT NULL,
account_no VARCHAR(191) NOT NULL,
bank VARCHAR(191) NOT NULL,
branch VARCHAR(191) NOT NULL,
PRIMARY KEY(accountId)
)`;
sql:ParameterizedQuery query13 = `CREATE TABLE Transaction (
transactionId INT NOT NULL,
PRIMARY KEY(transactionId)
)`;
sql:ParameterizedQuery query14 = `CREATE TABLE User (
userid INT NOT NULL,
email VARCHAR(191) NOT NULL,
password VARCHAR(191) NOT NULL,
name VARCHAR(191) NOT NULL,
user_role VARCHAR(191) NOT NULL,
user_type VARCHAR(191) NOT NULL,
phone_no VARCHAR(191) NOT NULL,
currency_pref VARCHAR(191) NOT NULL,
PRIMARY KEY(userid)
)`;
sql:ParameterizedQuery query15 = `CREATE TABLE Card (
cardId INT NOT NULL,
card_no VARCHAR(191) NOT NULL,
card_name VARCHAR(191) NOT NULL,
card_expiry VARCHAR(191) NOT NULL,
card_cv VARCHAR(191) NOT NULL,
bankaccountAccountId INT NOT NULL,
FOREIGN KEY(bankaccountAccountId) REFERENCES BankAccount(accountId),
PRIMARY KEY(cardId)
)`;
sql:ParameterizedQuery query16 = `CREATE TABLE UserGroupMember (
g_memberId INT NOT NULL,
member_role VARCHAR(191) NOT NULL,
groupGroupId INT NOT NULL,
FOREIGN KEY(groupGroupId) REFERENCES UserGroup(groupId),
userUserid INT NOT NULL,
FOREIGN KEY(userUserid) REFERENCES User(userid),
PRIMARY KEY(g_memberId)
)`;
sql:ParameterizedQuery query17 = `CREATE TABLE Expense (
expenseId INT NOT NULL,
name VARCHAR(191) NOT NULL,
owing_amount DECIMAL(65,30) NOT NULL,
txnTransactionId INT NOT NULL,
FOREIGN KEY(txnTransactionId) REFERENCES Transaction(transactionId),
PRIMARY KEY(expenseId)
)`;
sql:ParameterizedQuery query18 = `CREATE TABLE Friend (
friendId INT NOT NULL,
userUserid INT NOT NULL,
FOREIGN KEY(userUserid) REFERENCES User(userid),
PRIMARY KEY(friendId)
)`;
sql:ParameterizedQuery query19 = `CREATE TABLE Settlement (
settlementId INT NOT NULL,
settled_amount DECIMAL(65,30) NOT NULL,
txnTransactionId INT NOT NULL,
FOREIGN KEY(txnTransactionId) REFERENCES Transaction(transactionId),
PRIMARY KEY(settlementId)
)`;
sql:ParameterizedQuery query20 = `CREATE TABLE ExpenseParticipant (
participantId INT NOT NULL,
participant_role VARCHAR(191) NOT NULL,
expenseExpenseId INT NOT NULL,
FOREIGN KEY(expenseExpenseId) REFERENCES Expense(expenseId),
userUserid INT NOT NULL,
FOREIGN KEY(userUserid) REFERENCES User(userid),
PRIMARY KEY(participantId)
)`;

public function createTables() returns error? {
    db:Client dbClient = check new ();
 _ = check dbClient->executeNativeSQL(query1);
 _ = check dbClient->executeNativeSQL(query2);
 _ = check dbClient->executeNativeSQL(query3);
 _ = check dbClient->executeNativeSQL(query4);
 _ = check dbClient->executeNativeSQL(query5);
 _ = check dbClient->executeNativeSQL(query6);
 _ = check dbClient->executeNativeSQL(query7);
 _ = check dbClient->executeNativeSQL(query8);
 _ = check dbClient->executeNativeSQL(query9);
 _ = check dbClient->executeNativeSQL(query10);
 _ = check dbClient->executeNativeSQL(query11);
 _ = check dbClient->executeNativeSQL(query12);
 _ = check dbClient->executeNativeSQL(query13);
 _ = check dbClient->executeNativeSQL(query14);
 _ = check dbClient->executeNativeSQL(query15);
 _ = check dbClient->executeNativeSQL(query16);
 _ = check dbClient->executeNativeSQL(query17);
 _ = check dbClient->executeNativeSQL(query18);
 _ = check dbClient->executeNativeSQL(query19);
 _ = check dbClient->executeNativeSQL(query20);
    check dbClient.close();
}
