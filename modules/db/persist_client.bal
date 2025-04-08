// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/persist.sql as psql;

const USER = "users";
const FRIEND_REQUEST = "friendrequests";
const FRIEND = "friends";
const USER_GROUP = "usergroups";
const USER_GROUP_MEMBER = "usergroupmembers";
const EXPENSE = "expenses";
const EXPENSE_PARTICIPANT = "expenseparticipants";
const TRANSACTION = "transactions";
const BANK_ACCOUNT = "bankaccounts";
const CARD = "cards";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [USER]: {
            entityName: "User",
            tableName: "User",
            fieldMetadata: {
                user_Id: {columnName: "user_Id"},
                email: {columnName: "email"},
                first_name: {columnName: "first_name"},
                last_name: {columnName: "last_name"},
                phone_number: {columnName: "phone_number"},
                birthdate: {columnName: "birthdate"},
                currency_pref: {columnName: "currency_pref"},
                "friendRequests[].friend_Id": {relation: {entityName: "friendRequests", refField: "friend_Id"}},
                "friendRequests[].send_user_idUser_Id": {relation: {entityName: "friendRequests", refField: "send_user_idUser_Id"}},
                "friendRequests[].receive_user_Id": {relation: {entityName: "friendRequests", refField: "receive_user_Id"}},
                "friendRequests[].status": {relation: {entityName: "friendRequests", refField: "status"}},
                "groupMembers[].group_member_Id": {relation: {entityName: "groupMembers", refField: "group_member_Id"}},
                "groupMembers[].member_role": {relation: {entityName: "groupMembers", refField: "member_role"}},
                "groupMembers[].groupGroup_Id": {relation: {entityName: "groupMembers", refField: "groupGroup_Id"}},
                "groupMembers[].userUser_Id": {relation: {entityName: "groupMembers", refField: "userUser_Id"}},
                "expenseParticipants[].participant_Id": {relation: {entityName: "expenseParticipants", refField: "participant_Id"}},
                "expenseParticipants[].participant_role": {relation: {entityName: "expenseParticipants", refField: "participant_role"}},
                "expenseParticipants[].owning_amount": {relation: {entityName: "expenseParticipants", refField: "owning_amount"}},
                "expenseParticipants[].expenseExpense_Id": {relation: {entityName: "expenseParticipants", refField: "expenseExpense_Id"}},
                "expenseParticipants[].userUser_Id": {relation: {entityName: "expenseParticipants", refField: "userUser_Id"}},
                "transactions[].transaction_Id": {relation: {entityName: "transactions", refField: "transaction_Id"}},
                "transactions[].payed_amount": {relation: {entityName: "transactions", refField: "payed_amount"}},
                "transactions[].expenseExpense_Id": {relation: {entityName: "transactions", refField: "expenseExpense_Id"}},
                "transactions[].payee_idUser_Id": {relation: {entityName: "transactions", refField: "payee_idUser_Id"}},
                "friends[].friend_Id": {relation: {entityName: "friends", refField: "friend_Id"}},
                "friends[].user_id_1User_Id": {relation: {entityName: "friends", refField: "user_id_1User_Id"}},
                "friends[].user_id_2User_Id": {relation: {entityName: "friends", refField: "user_id_2User_Id"}},
                "friend[].friend_Id": {relation: {entityName: "friend", refField: "friend_Id"}},
                "friend[].user_id_1User_Id": {relation: {entityName: "friend", refField: "user_id_1User_Id"}},
                "friend[].user_id_2User_Id": {relation: {entityName: "friend", refField: "user_id_2User_Id"}}
            },
            keyFields: ["user_Id"],
            joinMetadata: {
                friendRequests: {entity: FriendRequest, fieldName: "friendRequests", refTable: "FriendRequest", refColumns: ["send_user_idUser_Id"], joinColumns: ["user_Id"], 'type: psql:MANY_TO_ONE},
                groupMembers: {entity: UserGroupMember, fieldName: "groupMembers", refTable: "UserGroupMember", refColumns: ["userUser_Id"], joinColumns: ["user_Id"], 'type: psql:MANY_TO_ONE},
                expenseParticipants: {entity: ExpenseParticipant, fieldName: "expenseParticipants", refTable: "ExpenseParticipant", refColumns: ["userUser_Id"], joinColumns: ["user_Id"], 'type: psql:MANY_TO_ONE},
                transactions: {entity: Transaction, fieldName: "transactions", refTable: "Transaction", refColumns: ["payee_idUser_Id"], joinColumns: ["user_Id"], 'type: psql:MANY_TO_ONE},
                friends: {entity: Friend, fieldName: "friends", refTable: "Friend", refColumns: ["user_id_1User_Id"], joinColumns: ["user_Id"], 'type: psql:MANY_TO_ONE},
                friend: {entity: Friend, fieldName: "friend", refTable: "Friend", refColumns: ["user_id_2User_Id"], joinColumns: ["user_Id"], 'type: psql:MANY_TO_ONE}
            }
        },
        [FRIEND_REQUEST]: {
            entityName: "FriendRequest",
            tableName: "FriendRequest",
            fieldMetadata: {
                friend_Id: {columnName: "friend_Id"},
                send_user_idUser_Id: {columnName: "send_user_idUser_Id"},
                receive_user_Id: {columnName: "receive_user_Id"},
                status: {columnName: "status"},
                "send_user_Id.user_Id": {relation: {entityName: "send_user_Id", refField: "user_Id"}},
                "send_user_Id.email": {relation: {entityName: "send_user_Id", refField: "email"}},
                "send_user_Id.first_name": {relation: {entityName: "send_user_Id", refField: "first_name"}},
                "send_user_Id.last_name": {relation: {entityName: "send_user_Id", refField: "last_name"}},
                "send_user_Id.phone_number": {relation: {entityName: "send_user_Id", refField: "phone_number"}},
                "send_user_Id.birthdate": {relation: {entityName: "send_user_Id", refField: "birthdate"}},
                "send_user_Id.currency_pref": {relation: {entityName: "send_user_Id", refField: "currency_pref"}}
            },
            keyFields: ["friend_Id"],
            joinMetadata: {send_user_Id: {entity: User, fieldName: "send_user_Id", refTable: "User", refColumns: ["user_Id"], joinColumns: ["send_user_idUser_Id"], 'type: psql:ONE_TO_MANY}}
        },
        [FRIEND]: {
            entityName: "Friend",
            tableName: "Friend",
            fieldMetadata: {
                friend_Id: {columnName: "friend_Id"},
                user_id_1User_Id: {columnName: "user_id_1User_Id"},
                user_id_2User_Id: {columnName: "user_id_2User_Id"},
                "user_Id_1.user_Id": {relation: {entityName: "user_Id_1", refField: "user_Id"}},
                "user_Id_1.email": {relation: {entityName: "user_Id_1", refField: "email"}},
                "user_Id_1.first_name": {relation: {entityName: "user_Id_1", refField: "first_name"}},
                "user_Id_1.last_name": {relation: {entityName: "user_Id_1", refField: "last_name"}},
                "user_Id_1.phone_number": {relation: {entityName: "user_Id_1", refField: "phone_number"}},
                "user_Id_1.birthdate": {relation: {entityName: "user_Id_1", refField: "birthdate"}},
                "user_Id_1.currency_pref": {relation: {entityName: "user_Id_1", refField: "currency_pref"}},
                "user_Id_2.user_Id": {relation: {entityName: "user_Id_2", refField: "user_Id"}},
                "user_Id_2.email": {relation: {entityName: "user_Id_2", refField: "email"}},
                "user_Id_2.first_name": {relation: {entityName: "user_Id_2", refField: "first_name"}},
                "user_Id_2.last_name": {relation: {entityName: "user_Id_2", refField: "last_name"}},
                "user_Id_2.phone_number": {relation: {entityName: "user_Id_2", refField: "phone_number"}},
                "user_Id_2.birthdate": {relation: {entityName: "user_Id_2", refField: "birthdate"}},
                "user_Id_2.currency_pref": {relation: {entityName: "user_Id_2", refField: "currency_pref"}}
            },
            keyFields: ["friend_Id"],
            joinMetadata: {
                user_Id_1: {entity: User, fieldName: "user_Id_1", refTable: "User", refColumns: ["user_Id"], joinColumns: ["user_id_1User_Id"], 'type: psql:ONE_TO_MANY},
                user_Id_2: {entity: User, fieldName: "user_Id_2", refTable: "User", refColumns: ["user_Id"], joinColumns: ["user_id_2User_Id"], 'type: psql:ONE_TO_MANY}
            }
        },
        [USER_GROUP]: {
            entityName: "UserGroup",
            tableName: "UserGroup",
            fieldMetadata: {
                group_Id: {columnName: "group_Id"},
                name: {columnName: "name"},
                "groupMembers[].group_member_Id": {relation: {entityName: "groupMembers", refField: "group_member_Id"}},
                "groupMembers[].member_role": {relation: {entityName: "groupMembers", refField: "member_role"}},
                "groupMembers[].groupGroup_Id": {relation: {entityName: "groupMembers", refField: "groupGroup_Id"}},
                "groupMembers[].userUser_Id": {relation: {entityName: "groupMembers", refField: "userUser_Id"}},
                "expenses[].expense_Id": {relation: {entityName: "expenses", refField: "expense_Id"}},
                "expenses[].name": {relation: {entityName: "expenses", refField: "name"}},
                "expenses[].expense_total_amount": {relation: {entityName: "expenses", refField: "expense_total_amount"}},
                "expenses[].expense_actual_amount": {relation: {entityName: "expenses", refField: "expense_actual_amount"}},
                "expenses[].usergroupGroup_Id": {relation: {entityName: "expenses", refField: "usergroupGroup_Id"}}
            },
            keyFields: ["group_Id"],
            joinMetadata: {
                groupMembers: {entity: UserGroupMember, fieldName: "groupMembers", refTable: "UserGroupMember", refColumns: ["groupGroup_Id"], joinColumns: ["group_Id"], 'type: psql:MANY_TO_ONE},
                expenses: {entity: Expense, fieldName: "expenses", refTable: "Expense", refColumns: ["usergroupGroup_Id"], joinColumns: ["group_Id"], 'type: psql:MANY_TO_ONE}
            }
        },
        [USER_GROUP_MEMBER]: {
            entityName: "UserGroupMember",
            tableName: "UserGroupMember",
            fieldMetadata: {
                group_member_Id: {columnName: "group_member_Id"},
                member_role: {columnName: "member_role"},
                groupGroup_Id: {columnName: "groupGroup_Id"},
                userUser_Id: {columnName: "userUser_Id"},
                "group.group_Id": {relation: {entityName: "group", refField: "group_Id"}},
                "group.name": {relation: {entityName: "group", refField: "name"}},
                "user.user_Id": {relation: {entityName: "user", refField: "user_Id"}},
                "user.email": {relation: {entityName: "user", refField: "email"}},
                "user.first_name": {relation: {entityName: "user", refField: "first_name"}},
                "user.last_name": {relation: {entityName: "user", refField: "last_name"}},
                "user.phone_number": {relation: {entityName: "user", refField: "phone_number"}},
                "user.birthdate": {relation: {entityName: "user", refField: "birthdate"}},
                "user.currency_pref": {relation: {entityName: "user", refField: "currency_pref"}}
            },
            keyFields: ["group_member_Id"],
            joinMetadata: {
                'group: {entity: UserGroup, fieldName: "'group", refTable: "UserGroup", refColumns: ["group_Id"], joinColumns: ["groupGroup_Id"], 'type: psql:ONE_TO_MANY},
                user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["user_Id"], joinColumns: ["userUser_Id"], 'type: psql:ONE_TO_MANY}
            }
        },
        [EXPENSE]: {
            entityName: "Expense",
            tableName: "Expense",
            fieldMetadata: {
                expense_Id: {columnName: "expense_Id"},
                name: {columnName: "name"},
                expense_total_amount: {columnName: "expense_total_amount"},
                expense_actual_amount: {columnName: "expense_actual_amount"},
                usergroupGroup_Id: {columnName: "usergroupGroup_Id"},
                "expenseParticipants[].participant_Id": {relation: {entityName: "expenseParticipants", refField: "participant_Id"}},
                "expenseParticipants[].participant_role": {relation: {entityName: "expenseParticipants", refField: "participant_role"}},
                "expenseParticipants[].owning_amount": {relation: {entityName: "expenseParticipants", refField: "owning_amount"}},
                "expenseParticipants[].expenseExpense_Id": {relation: {entityName: "expenseParticipants", refField: "expenseExpense_Id"}},
                "expenseParticipants[].userUser_Id": {relation: {entityName: "expenseParticipants", refField: "userUser_Id"}},
                "transactions[].transaction_Id": {relation: {entityName: "transactions", refField: "transaction_Id"}},
                "transactions[].payed_amount": {relation: {entityName: "transactions", refField: "payed_amount"}},
                "transactions[].expenseExpense_Id": {relation: {entityName: "transactions", refField: "expenseExpense_Id"}},
                "transactions[].payee_idUser_Id": {relation: {entityName: "transactions", refField: "payee_idUser_Id"}},
                "usergroup.group_Id": {relation: {entityName: "usergroup", refField: "group_Id"}},
                "usergroup.name": {relation: {entityName: "usergroup", refField: "name"}}
            },
            keyFields: ["expense_Id"],
            joinMetadata: {
                expenseParticipants: {entity: ExpenseParticipant, fieldName: "expenseParticipants", refTable: "ExpenseParticipant", refColumns: ["expenseExpense_Id"], joinColumns: ["expense_Id"], 'type: psql:MANY_TO_ONE},
                transactions: {entity: Transaction, fieldName: "transactions", refTable: "Transaction", refColumns: ["expenseExpense_Id"], joinColumns: ["expense_Id"], 'type: psql:MANY_TO_ONE},
                usergroup: {entity: UserGroup, fieldName: "usergroup", refTable: "UserGroup", refColumns: ["group_Id"], joinColumns: ["usergroupGroup_Id"], 'type: psql:ONE_TO_MANY}
            }
        },
        [EXPENSE_PARTICIPANT]: {
            entityName: "ExpenseParticipant",
            tableName: "ExpenseParticipant",
            fieldMetadata: {
                participant_Id: {columnName: "participant_Id"},
                participant_role: {columnName: "participant_role"},
                owning_amount: {columnName: "owning_amount"},
                expenseExpense_Id: {columnName: "expenseExpense_Id"},
                userUser_Id: {columnName: "userUser_Id"},
                "expense.expense_Id": {relation: {entityName: "expense", refField: "expense_Id"}},
                "expense.name": {relation: {entityName: "expense", refField: "name"}},
                "expense.expense_total_amount": {relation: {entityName: "expense", refField: "expense_total_amount"}},
                "expense.expense_actual_amount": {relation: {entityName: "expense", refField: "expense_actual_amount"}},
                "expense.usergroupGroup_Id": {relation: {entityName: "expense", refField: "usergroupGroup_Id"}},
                "user.user_Id": {relation: {entityName: "user", refField: "user_Id"}},
                "user.email": {relation: {entityName: "user", refField: "email"}},
                "user.first_name": {relation: {entityName: "user", refField: "first_name"}},
                "user.last_name": {relation: {entityName: "user", refField: "last_name"}},
                "user.phone_number": {relation: {entityName: "user", refField: "phone_number"}},
                "user.birthdate": {relation: {entityName: "user", refField: "birthdate"}},
                "user.currency_pref": {relation: {entityName: "user", refField: "currency_pref"}}
            },
            keyFields: ["participant_Id"],
            joinMetadata: {
                expense: {entity: Expense, fieldName: "expense", refTable: "Expense", refColumns: ["expense_Id"], joinColumns: ["expenseExpense_Id"], 'type: psql:ONE_TO_MANY},
                user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["user_Id"], joinColumns: ["userUser_Id"], 'type: psql:ONE_TO_MANY}
            }
        },
        [TRANSACTION]: {
            entityName: "Transaction",
            tableName: "Transaction",
            fieldMetadata: {
                transaction_Id: {columnName: "transaction_Id"},
                payed_amount: {columnName: "payed_amount"},
                expenseExpense_Id: {columnName: "expenseExpense_Id"},
                payee_idUser_Id: {columnName: "payee_idUser_Id"},
                "expense.expense_Id": {relation: {entityName: "expense", refField: "expense_Id"}},
                "expense.name": {relation: {entityName: "expense", refField: "name"}},
                "expense.expense_total_amount": {relation: {entityName: "expense", refField: "expense_total_amount"}},
                "expense.expense_actual_amount": {relation: {entityName: "expense", refField: "expense_actual_amount"}},
                "expense.usergroupGroup_Id": {relation: {entityName: "expense", refField: "usergroupGroup_Id"}},
                "payee_Id.user_Id": {relation: {entityName: "payee_Id", refField: "user_Id"}},
                "payee_Id.email": {relation: {entityName: "payee_Id", refField: "email"}},
                "payee_Id.first_name": {relation: {entityName: "payee_Id", refField: "first_name"}},
                "payee_Id.last_name": {relation: {entityName: "payee_Id", refField: "last_name"}},
                "payee_Id.phone_number": {relation: {entityName: "payee_Id", refField: "phone_number"}},
                "payee_Id.birthdate": {relation: {entityName: "payee_Id", refField: "birthdate"}},
                "payee_Id.currency_pref": {relation: {entityName: "payee_Id", refField: "currency_pref"}}
            },
            keyFields: ["transaction_Id"],
            joinMetadata: {
                expense: {entity: Expense, fieldName: "expense", refTable: "Expense", refColumns: ["expense_Id"], joinColumns: ["expenseExpense_Id"], 'type: psql:ONE_TO_MANY},
                payee_Id: {entity: User, fieldName: "payee_Id", refTable: "User", refColumns: ["user_Id"], joinColumns: ["payee_idUser_Id"], 'type: psql:ONE_TO_MANY}
            }
        },
        [BANK_ACCOUNT]: {
            entityName: "BankAccount",
            tableName: "BankAccount",
            fieldMetadata: {
                account_Id: {columnName: "account_Id"},
                account_no: {columnName: "account_no"},
                bank: {columnName: "bank"},
                branch: {columnName: "branch"},
                "cards[].card_Id": {relation: {entityName: "cards", refField: "card_Id"}},
                "cards[].card_no": {relation: {entityName: "cards", refField: "card_no"}},
                "cards[].card_name": {relation: {entityName: "cards", refField: "card_name"}},
                "cards[].card_expiry": {relation: {entityName: "cards", refField: "card_expiry"}},
                "cards[].card_cv": {relation: {entityName: "cards", refField: "card_cv"}},
                "cards[].bankaccountAccount_Id": {relation: {entityName: "cards", refField: "bankaccountAccount_Id"}}
            },
            keyFields: ["account_Id"],
            joinMetadata: {cards: {entity: Card, fieldName: "cards", refTable: "Card", refColumns: ["bankaccountAccount_Id"], joinColumns: ["account_Id"], 'type: psql:MANY_TO_ONE}}
        },
        [CARD]: {
            entityName: "Card",
            tableName: "Card",
            fieldMetadata: {
                card_Id: {columnName: "card_Id"},
                card_no: {columnName: "card_no"},
                card_name: {columnName: "card_name"},
                card_expiry: {columnName: "card_expiry"},
                card_cv: {columnName: "card_cv"},
                bankaccountAccount_Id: {columnName: "bankaccountAccount_Id"},
                "bankAccount.account_Id": {relation: {entityName: "bankAccount", refField: "account_Id"}},
                "bankAccount.account_no": {relation: {entityName: "bankAccount", refField: "account_no"}},
                "bankAccount.bank": {relation: {entityName: "bankAccount", refField: "bank"}},
                "bankAccount.branch": {relation: {entityName: "bankAccount", refField: "branch"}}
            },
            keyFields: ["card_Id"],
            joinMetadata: {bankAccount: {entity: BankAccount, fieldName: "bankAccount", refTable: "BankAccount", refColumns: ["account_Id"], joinColumns: ["bankaccountAccount_Id"], 'type: psql:ONE_TO_MANY}}
        }
    };

    public isolated function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [USER]: check new (dbClient, self.metadata.get(USER), psql:MYSQL_SPECIFICS),
            [FRIEND_REQUEST]: check new (dbClient, self.metadata.get(FRIEND_REQUEST), psql:MYSQL_SPECIFICS),
            [FRIEND]: check new (dbClient, self.metadata.get(FRIEND), psql:MYSQL_SPECIFICS),
            [USER_GROUP]: check new (dbClient, self.metadata.get(USER_GROUP), psql:MYSQL_SPECIFICS),
            [USER_GROUP_MEMBER]: check new (dbClient, self.metadata.get(USER_GROUP_MEMBER), psql:MYSQL_SPECIFICS),
            [EXPENSE]: check new (dbClient, self.metadata.get(EXPENSE), psql:MYSQL_SPECIFICS),
            [EXPENSE_PARTICIPANT]: check new (dbClient, self.metadata.get(EXPENSE_PARTICIPANT), psql:MYSQL_SPECIFICS),
            [TRANSACTION]: check new (dbClient, self.metadata.get(TRANSACTION), psql:MYSQL_SPECIFICS),
            [BANK_ACCOUNT]: check new (dbClient, self.metadata.get(BANK_ACCOUNT), psql:MYSQL_SPECIFICS),
            [CARD]: check new (dbClient, self.metadata.get(CARD), psql:MYSQL_SPECIFICS)
        };
    }

    isolated resource function get users(UserTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get users/[string user_Id](UserTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post users(UserInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserInsert inserted in data
            select inserted.user_Id;
    }

    isolated resource function put users/[string user_Id](UserUpdate value) returns User|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runUpdateQuery(user_Id, value);
        return self->/users/[user_Id].get();
    }

    isolated resource function delete users/[string user_Id]() returns User|persist:Error {
        User result = check self->/users/[user_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runDeleteQuery(user_Id);
        return result;
    }

    isolated resource function get friendrequests(FriendRequestTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get friendrequests/[string friend_Id](FriendRequestTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post friendrequests(FriendRequestInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND_REQUEST);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from FriendRequestInsert inserted in data
            select inserted.friend_Id;
    }

    isolated resource function put friendrequests/[string friend_Id](FriendRequestUpdate value) returns FriendRequest|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND_REQUEST);
        }
        _ = check sqlClient.runUpdateQuery(friend_Id, value);
        return self->/friendrequests/[friend_Id].get();
    }

    isolated resource function delete friendrequests/[string friend_Id]() returns FriendRequest|persist:Error {
        FriendRequest result = check self->/friendrequests/[friend_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND_REQUEST);
        }
        _ = check sqlClient.runDeleteQuery(friend_Id);
        return result;
    }

    isolated resource function get friends(FriendTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get friends/[string friend_Id](FriendTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post friends(FriendInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from FriendInsert inserted in data
            select inserted.friend_Id;
    }

    isolated resource function put friends/[string friend_Id](FriendUpdate value) returns Friend|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND);
        }
        _ = check sqlClient.runUpdateQuery(friend_Id, value);
        return self->/friends/[friend_Id].get();
    }

    isolated resource function delete friends/[string friend_Id]() returns Friend|persist:Error {
        Friend result = check self->/friends/[friend_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND);
        }
        _ = check sqlClient.runDeleteQuery(friend_Id);
        return result;
    }

    isolated resource function get usergroups(UserGroupTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get usergroups/[string group_Id](UserGroupTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post usergroups(UserGroupInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserGroupInsert inserted in data
            select inserted.group_Id;
    }

    isolated resource function put usergroups/[string group_Id](UserGroupUpdate value) returns UserGroup|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP);
        }
        _ = check sqlClient.runUpdateQuery(group_Id, value);
        return self->/usergroups/[group_Id].get();
    }

    isolated resource function delete usergroups/[string group_Id]() returns UserGroup|persist:Error {
        UserGroup result = check self->/usergroups/[group_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP);
        }
        _ = check sqlClient.runDeleteQuery(group_Id);
        return result;
    }

    isolated resource function get usergroupmembers(UserGroupMemberTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get usergroupmembers/[string group_member_Id](UserGroupMemberTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post usergroupmembers(UserGroupMemberInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP_MEMBER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserGroupMemberInsert inserted in data
            select inserted.group_member_Id;
    }

    isolated resource function put usergroupmembers/[string group_member_Id](UserGroupMemberUpdate value) returns UserGroupMember|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP_MEMBER);
        }
        _ = check sqlClient.runUpdateQuery(group_member_Id, value);
        return self->/usergroupmembers/[group_member_Id].get();
    }

    isolated resource function delete usergroupmembers/[string group_member_Id]() returns UserGroupMember|persist:Error {
        UserGroupMember result = check self->/usergroupmembers/[group_member_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP_MEMBER);
        }
        _ = check sqlClient.runDeleteQuery(group_member_Id);
        return result;
    }

    isolated resource function get expenses(ExpenseTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get expenses/[string expense_Id](ExpenseTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post expenses(ExpenseInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ExpenseInsert inserted in data
            select inserted.expense_Id;
    }

    isolated resource function put expenses/[string expense_Id](ExpenseUpdate value) returns Expense|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE);
        }
        _ = check sqlClient.runUpdateQuery(expense_Id, value);
        return self->/expenses/[expense_Id].get();
    }

    isolated resource function delete expenses/[string expense_Id]() returns Expense|persist:Error {
        Expense result = check self->/expenses/[expense_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE);
        }
        _ = check sqlClient.runDeleteQuery(expense_Id);
        return result;
    }

    isolated resource function get expenseparticipants(ExpenseParticipantTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get expenseparticipants/[string participant_Id](ExpenseParticipantTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post expenseparticipants(ExpenseParticipantInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE_PARTICIPANT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ExpenseParticipantInsert inserted in data
            select inserted.participant_Id;
    }

    isolated resource function put expenseparticipants/[string participant_Id](ExpenseParticipantUpdate value) returns ExpenseParticipant|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE_PARTICIPANT);
        }
        _ = check sqlClient.runUpdateQuery(participant_Id, value);
        return self->/expenseparticipants/[participant_Id].get();
    }

    isolated resource function delete expenseparticipants/[string participant_Id]() returns ExpenseParticipant|persist:Error {
        ExpenseParticipant result = check self->/expenseparticipants/[participant_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE_PARTICIPANT);
        }
        _ = check sqlClient.runDeleteQuery(participant_Id);
        return result;
    }

    isolated resource function get transactions(TransactionTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get transactions/[string transaction_Id](TransactionTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post transactions(TransactionInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(TRANSACTION);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from TransactionInsert inserted in data
            select inserted.transaction_Id;
    }

    isolated resource function put transactions/[string transaction_Id](TransactionUpdate value) returns Transaction|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(TRANSACTION);
        }
        _ = check sqlClient.runUpdateQuery(transaction_Id, value);
        return self->/transactions/[transaction_Id].get();
    }

    isolated resource function delete transactions/[string transaction_Id]() returns Transaction|persist:Error {
        Transaction result = check self->/transactions/[transaction_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(TRANSACTION);
        }
        _ = check sqlClient.runDeleteQuery(transaction_Id);
        return result;
    }

    isolated resource function get bankaccounts(BankAccountTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get bankaccounts/[string account_Id](BankAccountTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post bankaccounts(BankAccountInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BANK_ACCOUNT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from BankAccountInsert inserted in data
            select inserted.account_Id;
    }

    isolated resource function put bankaccounts/[string account_Id](BankAccountUpdate value) returns BankAccount|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BANK_ACCOUNT);
        }
        _ = check sqlClient.runUpdateQuery(account_Id, value);
        return self->/bankaccounts/[account_Id].get();
    }

    isolated resource function delete bankaccounts/[string account_Id]() returns BankAccount|persist:Error {
        BankAccount result = check self->/bankaccounts/[account_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BANK_ACCOUNT);
        }
        _ = check sqlClient.runDeleteQuery(account_Id);
        return result;
    }

    isolated resource function get cards(CardTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get cards/[string card_Id](CardTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post cards(CardInsert[] data) returns string[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CARD);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from CardInsert inserted in data
            select inserted.card_Id;
    }

    isolated resource function put cards/[string card_Id](CardUpdate value) returns Card|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CARD);
        }
        _ = check sqlClient.runUpdateQuery(card_Id, value);
        return self->/cards/[card_Id].get();
    }

    isolated resource function delete cards/[string card_Id]() returns Card|persist:Error {
        Card result = check self->/cards/[card_Id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CARD);
        }
        _ = check sqlClient.runDeleteQuery(card_Id);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

