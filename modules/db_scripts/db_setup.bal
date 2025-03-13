import ballerina/sql;
import splittrack_backend.db;

// Auto-generated file containing SQL queries from the persist SQL file

sql:ParameterizedQuery query1 = `DROP TABLE IF EXISTS ExpenseParticipant`;
sql:ParameterizedQuery query2 = `DROP TABLE IF EXISTS Friend`;
sql:ParameterizedQuery query3 = `DROP TABLE IF EXISTS Transaction`;
sql:ParameterizedQuery query4 = `DROP TABLE IF EXISTS Expense`;
sql:ParameterizedQuery query5 = `DROP TABLE IF EXISTS FriendRequest`;
sql:ParameterizedQuery query6 = `DROP TABLE IF EXISTS UserGroupMember`;
sql:ParameterizedQuery query7 = `DROP TABLE IF EXISTS Card`;
sql:ParameterizedQuery query8 = `DROP TABLE IF EXISTS User`;
sql:ParameterizedQuery query9 = `DROP TABLE IF EXISTS BankAccount`;
sql:ParameterizedQuery query10 = `DROP TABLE IF EXISTS UserGroup`;
sql:ParameterizedQuery query11 = `CREATE TABLE UserGroup (
group_Id INT NOT NULL,
name VARCHAR(191) NOT NULL,
PRIMARY KEY(group_Id)
)`;
sql:ParameterizedQuery query12 = `CREATE TABLE BankAccount (
account_Id INT NOT NULL,
account_no VARCHAR(191) NOT NULL,
bank VARCHAR(191) NOT NULL,
branch VARCHAR(191) NOT NULL,
PRIMARY KEY(account_Id)
)`;
sql:ParameterizedQuery query13 = `CREATE TABLE User (
user_Id INT NOT NULL,
email VARCHAR(191) NOT NULL,
password VARCHAR(191) NOT NULL,
name VARCHAR(191) NOT NULL,
user_type VARCHAR(191) NOT NULL,
phone_no VARCHAR(191) NOT NULL,
currency_pref VARCHAR(191) NOT NULL,
PRIMARY KEY(user_Id)
)`;
sql:ParameterizedQuery query14 = `CREATE TABLE Card (
card_Id INT NOT NULL,
card_no VARCHAR(191) NOT NULL,
card_name VARCHAR(191) NOT NULL,
card_expiry VARCHAR(191) NOT NULL,
card_cv VARCHAR(191) NOT NULL,
bankaccountAccount_Id INT NOT NULL,
FOREIGN KEY(bankaccountAccount_Id) REFERENCES BankAccount(account_Id),
PRIMARY KEY(card_Id)
)`;
sql:ParameterizedQuery query15 = `CREATE TABLE UserGroupMember (
group_member_Id INT NOT NULL,
member_role VARCHAR(191) NOT NULL,
groupGroup_Id INT NOT NULL,
FOREIGN KEY(groupGroup_Id) REFERENCES UserGroup(group_Id),
userUser_Id INT NOT NULL,
FOREIGN KEY(userUser_Id) REFERENCES User(user_Id),
PRIMARY KEY(group_member_Id)
)`;
sql:ParameterizedQuery query16 = `CREATE TABLE FriendRequest (
friend_Id INT NOT NULL,
receive_user_Id INT NOT NULL,
status VARCHAR(191) NOT NULL,
send_user_idUser_Id INT NOT NULL,
FOREIGN KEY(send_user_idUser_Id) REFERENCES User(user_Id),
PRIMARY KEY(friend_Id)
)`;
sql:ParameterizedQuery query17 = `CREATE TABLE Expense (
expense_Id INT NOT NULL,
name VARCHAR(191) NOT NULL,
total_amount DECIMAL(65,30) NOT NULL,
usergroupGroup_Id INT NOT NULL,
FOREIGN KEY(usergroupGroup_Id) REFERENCES UserGroup(group_Id),
PRIMARY KEY(expense_Id)
)`;
sql:ParameterizedQuery query18 = `CREATE TABLE Transaction (
transaction_Id INT NOT NULL,
payed_amount DECIMAL(65,30) NOT NULL,
expenseExpense_Id INT NOT NULL,
FOREIGN KEY(expenseExpense_Id) REFERENCES Expense(expense_Id),
payee_idUser_Id INT NOT NULL,
FOREIGN KEY(payee_idUser_Id) REFERENCES User(user_Id),
PRIMARY KEY(transaction_Id)
)`;
sql:ParameterizedQuery query19 = `CREATE TABLE Friend (
friend_Id INT NOT NULL,
user_id_1User_Id INT NOT NULL,
FOREIGN KEY(user_id_1User_Id) REFERENCES User(user_Id),
user_id_2User_Id INT NOT NULL,
FOREIGN KEY(user_id_2User_Id) REFERENCES User(user_Id),
PRIMARY KEY(friend_Id)
)`;
sql:ParameterizedQuery query20 = `CREATE TABLE ExpenseParticipant (
participant_Id INT NOT NULL,
participant_role VARCHAR(191) NOT NULL,
owning_amount DECIMAL(65,30) NOT NULL,
expenseExpense_Id INT NOT NULL,
FOREIGN KEY(expenseExpense_Id) REFERENCES Expense(expense_Id),
userUser_Id INT NOT NULL,
FOREIGN KEY(userUser_Id) REFERENCES User(user_Id),
PRIMARY KEY(participant_Id)
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
