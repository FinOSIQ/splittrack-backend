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
const FRIEND = "friends";
const USER_GROUP = "usergroups";
const USER_GROUP_MEMBER = "usergroupmembers";
const EXPENSE = "expenses";
const EXPENSE_PARTICIPANT = "expenseparticipants";
const TRANSACTION = "transactions";
const SETTLEMENT = "settlements";
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
                userid: {columnName: "userid"},
                email: {columnName: "email"},
                password: {columnName: "password"},
                name: {columnName: "name"},
                user_role: {columnName: "user_role"},
                user_type: {columnName: "user_type"},
                phone_no: {columnName: "phone_no"},
                currency_pref: {columnName: "currency_pref"},
                "friends[].friendId": {relation: {entityName: "friends", refField: "friendId"}},
                "friends[].userUserid": {relation: {entityName: "friends", refField: "userUserid"}},
                "groupMembers[].g_memberId": {relation: {entityName: "groupMembers", refField: "g_memberId"}},
                "groupMembers[].member_role": {relation: {entityName: "groupMembers", refField: "member_role"}},
                "groupMembers[].groupGroupId": {relation: {entityName: "groupMembers", refField: "groupGroupId"}},
                "groupMembers[].userUserid": {relation: {entityName: "groupMembers", refField: "userUserid"}},
                "expenseParticipants[].participantId": {relation: {entityName: "expenseParticipants", refField: "participantId"}},
                "expenseParticipants[].participant_role": {relation: {entityName: "expenseParticipants", refField: "participant_role"}},
                "expenseParticipants[].expenseExpenseId": {relation: {entityName: "expenseParticipants", refField: "expenseExpenseId"}},
                "expenseParticipants[].userUserid": {relation: {entityName: "expenseParticipants", refField: "userUserid"}}
            },
            keyFields: ["userid"],
            joinMetadata: {
                friends: {entity: Friend, fieldName: "friends", refTable: "Friend", refColumns: ["userUserid"], joinColumns: ["userid"], 'type: psql:MANY_TO_ONE},
                groupMembers: {entity: UserGroupMember, fieldName: "groupMembers", refTable: "UserGroupMember", refColumns: ["userUserid"], joinColumns: ["userid"], 'type: psql:MANY_TO_ONE},
                expenseParticipants: {entity: ExpenseParticipant, fieldName: "expenseParticipants", refTable: "ExpenseParticipant", refColumns: ["userUserid"], joinColumns: ["userid"], 'type: psql:MANY_TO_ONE}
            }
        },
        [FRIEND]: {
            entityName: "Friend",
            tableName: "Friend",
            fieldMetadata: {
                friendId: {columnName: "friendId"},
                userUserid: {columnName: "userUserid"},
                "user.userid": {relation: {entityName: "user", refField: "userid"}},
                "user.email": {relation: {entityName: "user", refField: "email"}},
                "user.password": {relation: {entityName: "user", refField: "password"}},
                "user.name": {relation: {entityName: "user", refField: "name"}},
                "user.user_role": {relation: {entityName: "user", refField: "user_role"}},
                "user.user_type": {relation: {entityName: "user", refField: "user_type"}},
                "user.phone_no": {relation: {entityName: "user", refField: "phone_no"}},
                "user.currency_pref": {relation: {entityName: "user", refField: "currency_pref"}}
            },
            keyFields: ["friendId"],
            joinMetadata: {user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["userid"], joinColumns: ["userUserid"], 'type: psql:ONE_TO_MANY}}
        },
        [USER_GROUP]: {
            entityName: "UserGroup",
            tableName: "UserGroup",
            fieldMetadata: {
                groupId: {columnName: "groupId"},
                name: {columnName: "name"},
                "groupMembers[].g_memberId": {relation: {entityName: "groupMembers", refField: "g_memberId"}},
                "groupMembers[].member_role": {relation: {entityName: "groupMembers", refField: "member_role"}},
                "groupMembers[].groupGroupId": {relation: {entityName: "groupMembers", refField: "groupGroupId"}},
                "groupMembers[].userUserid": {relation: {entityName: "groupMembers", refField: "userUserid"}}
            },
            keyFields: ["groupId"],
            joinMetadata: {groupMembers: {entity: UserGroupMember, fieldName: "groupMembers", refTable: "UserGroupMember", refColumns: ["groupGroupId"], joinColumns: ["groupId"], 'type: psql:MANY_TO_ONE}}
        },
        [USER_GROUP_MEMBER]: {
            entityName: "UserGroupMember",
            tableName: "UserGroupMember",
            fieldMetadata: {
                g_memberId: {columnName: "g_memberId"},
                member_role: {columnName: "member_role"},
                groupGroupId: {columnName: "groupGroupId"},
                userUserid: {columnName: "userUserid"},
                "group.groupId": {relation: {entityName: "group", refField: "groupId"}},
                "group.name": {relation: {entityName: "group", refField: "name"}},
                "user.userid": {relation: {entityName: "user", refField: "userid"}},
                "user.email": {relation: {entityName: "user", refField: "email"}},
                "user.password": {relation: {entityName: "user", refField: "password"}},
                "user.name": {relation: {entityName: "user", refField: "name"}},
                "user.user_role": {relation: {entityName: "user", refField: "user_role"}},
                "user.user_type": {relation: {entityName: "user", refField: "user_type"}},
                "user.phone_no": {relation: {entityName: "user", refField: "phone_no"}},
                "user.currency_pref": {relation: {entityName: "user", refField: "currency_pref"}}
            },
            keyFields: ["g_memberId"],
            joinMetadata: {
                'group: {entity: UserGroup, fieldName: "'group", refTable: "UserGroup", refColumns: ["groupId"], joinColumns: ["groupGroupId"], 'type: psql:ONE_TO_MANY},
                user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["userid"], joinColumns: ["userUserid"], 'type: psql:ONE_TO_MANY}
            }
        },
        [EXPENSE]: {
            entityName: "Expense",
            tableName: "Expense",
            fieldMetadata: {
                expenseId: {columnName: "expenseId"},
                name: {columnName: "name"},
                owing_amount: {columnName: "owing_amount"},
                txnTransactionId: {columnName: "txnTransactionId"},
                "expenseParticipants[].participantId": {relation: {entityName: "expenseParticipants", refField: "participantId"}},
                "expenseParticipants[].participant_role": {relation: {entityName: "expenseParticipants", refField: "participant_role"}},
                "expenseParticipants[].expenseExpenseId": {relation: {entityName: "expenseParticipants", refField: "expenseExpenseId"}},
                "expenseParticipants[].userUserid": {relation: {entityName: "expenseParticipants", refField: "userUserid"}},
                "txn.transactionId": {relation: {entityName: "txn", refField: "transactionId"}}
            },
            keyFields: ["expenseId"],
            joinMetadata: {
                expenseParticipants: {entity: ExpenseParticipant, fieldName: "expenseParticipants", refTable: "ExpenseParticipant", refColumns: ["expenseExpenseId"], joinColumns: ["expenseId"], 'type: psql:MANY_TO_ONE},
                txn: {entity: Transaction, fieldName: "txn", refTable: "Transaction", refColumns: ["transactionId"], joinColumns: ["txnTransactionId"], 'type: psql:ONE_TO_MANY}
            }
        },
        [EXPENSE_PARTICIPANT]: {
            entityName: "ExpenseParticipant",
            tableName: "ExpenseParticipant",
            fieldMetadata: {
                participantId: {columnName: "participantId"},
                participant_role: {columnName: "participant_role"},
                expenseExpenseId: {columnName: "expenseExpenseId"},
                userUserid: {columnName: "userUserid"},
                "expense.expenseId": {relation: {entityName: "expense", refField: "expenseId"}},
                "expense.name": {relation: {entityName: "expense", refField: "name"}},
                "expense.owing_amount": {relation: {entityName: "expense", refField: "owing_amount"}},
                "expense.txnTransactionId": {relation: {entityName: "expense", refField: "txnTransactionId"}},
                "user.userid": {relation: {entityName: "user", refField: "userid"}},
                "user.email": {relation: {entityName: "user", refField: "email"}},
                "user.password": {relation: {entityName: "user", refField: "password"}},
                "user.name": {relation: {entityName: "user", refField: "name"}},
                "user.user_role": {relation: {entityName: "user", refField: "user_role"}},
                "user.user_type": {relation: {entityName: "user", refField: "user_type"}},
                "user.phone_no": {relation: {entityName: "user", refField: "phone_no"}},
                "user.currency_pref": {relation: {entityName: "user", refField: "currency_pref"}}
            },
            keyFields: ["participantId"],
            joinMetadata: {
                expense: {entity: Expense, fieldName: "expense", refTable: "Expense", refColumns: ["expenseId"], joinColumns: ["expenseExpenseId"], 'type: psql:ONE_TO_MANY},
                user: {entity: User, fieldName: "user", refTable: "User", refColumns: ["userid"], joinColumns: ["userUserid"], 'type: psql:ONE_TO_MANY}
            }
        },
        [TRANSACTION]: {
            entityName: "Transaction",
            tableName: "Transaction",
            fieldMetadata: {
                transactionId: {columnName: "transactionId"},
                "settlements[].settlementId": {relation: {entityName: "settlements", refField: "settlementId"}},
                "settlements[].settled_amount": {relation: {entityName: "settlements", refField: "settled_amount"}},
                "settlements[].txnTransactionId": {relation: {entityName: "settlements", refField: "txnTransactionId"}},
                "expenses[].expenseId": {relation: {entityName: "expenses", refField: "expenseId"}},
                "expenses[].name": {relation: {entityName: "expenses", refField: "name"}},
                "expenses[].owing_amount": {relation: {entityName: "expenses", refField: "owing_amount"}},
                "expenses[].txnTransactionId": {relation: {entityName: "expenses", refField: "txnTransactionId"}}
            },
            keyFields: ["transactionId"],
            joinMetadata: {
                settlements: {entity: Settlement, fieldName: "settlements", refTable: "Settlement", refColumns: ["txnTransactionId"], joinColumns: ["transactionId"], 'type: psql:MANY_TO_ONE},
                expenses: {entity: Expense, fieldName: "expenses", refTable: "Expense", refColumns: ["txnTransactionId"], joinColumns: ["transactionId"], 'type: psql:MANY_TO_ONE}
            }
        },
        [SETTLEMENT]: {
            entityName: "Settlement",
            tableName: "Settlement",
            fieldMetadata: {
                settlementId: {columnName: "settlementId"},
                settled_amount: {columnName: "settled_amount"},
                txnTransactionId: {columnName: "txnTransactionId"},
                "txn.transactionId": {relation: {entityName: "txn", refField: "transactionId"}}
            },
            keyFields: ["settlementId"],
            joinMetadata: {txn: {entity: Transaction, fieldName: "txn", refTable: "Transaction", refColumns: ["transactionId"], joinColumns: ["txnTransactionId"], 'type: psql:ONE_TO_MANY}}
        },
        [BANK_ACCOUNT]: {
            entityName: "BankAccount",
            tableName: "BankAccount",
            fieldMetadata: {
                accountId: {columnName: "accountId"},
                account_no: {columnName: "account_no"},
                bank: {columnName: "bank"},
                branch: {columnName: "branch"},
                "cards[].cardId": {relation: {entityName: "cards", refField: "cardId"}},
                "cards[].card_no": {relation: {entityName: "cards", refField: "card_no"}},
                "cards[].card_name": {relation: {entityName: "cards", refField: "card_name"}},
                "cards[].card_expiry": {relation: {entityName: "cards", refField: "card_expiry"}},
                "cards[].card_cv": {relation: {entityName: "cards", refField: "card_cv"}},
                "cards[].bankaccountAccountId": {relation: {entityName: "cards", refField: "bankaccountAccountId"}}
            },
            keyFields: ["accountId"],
            joinMetadata: {cards: {entity: Card, fieldName: "cards", refTable: "Card", refColumns: ["bankaccountAccountId"], joinColumns: ["accountId"], 'type: psql:MANY_TO_ONE}}
        },
        [CARD]: {
            entityName: "Card",
            tableName: "Card",
            fieldMetadata: {
                cardId: {columnName: "cardId"},
                card_no: {columnName: "card_no"},
                card_name: {columnName: "card_name"},
                card_expiry: {columnName: "card_expiry"},
                card_cv: {columnName: "card_cv"},
                bankaccountAccountId: {columnName: "bankaccountAccountId"},
                "bankAccount.accountId": {relation: {entityName: "bankAccount", refField: "accountId"}},
                "bankAccount.account_no": {relation: {entityName: "bankAccount", refField: "account_no"}},
                "bankAccount.bank": {relation: {entityName: "bankAccount", refField: "bank"}},
                "bankAccount.branch": {relation: {entityName: "bankAccount", refField: "branch"}}
            },
            keyFields: ["cardId"],
            joinMetadata: {bankAccount: {entity: BankAccount, fieldName: "bankAccount", refTable: "BankAccount", refColumns: ["accountId"], joinColumns: ["bankaccountAccountId"], 'type: psql:ONE_TO_MANY}}
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
            [FRIEND]: check new (dbClient, self.metadata.get(FRIEND), psql:MYSQL_SPECIFICS),
            [USER_GROUP]: check new (dbClient, self.metadata.get(USER_GROUP), psql:MYSQL_SPECIFICS),
            [USER_GROUP_MEMBER]: check new (dbClient, self.metadata.get(USER_GROUP_MEMBER), psql:MYSQL_SPECIFICS),
            [EXPENSE]: check new (dbClient, self.metadata.get(EXPENSE), psql:MYSQL_SPECIFICS),
            [EXPENSE_PARTICIPANT]: check new (dbClient, self.metadata.get(EXPENSE_PARTICIPANT), psql:MYSQL_SPECIFICS),
            [TRANSACTION]: check new (dbClient, self.metadata.get(TRANSACTION), psql:MYSQL_SPECIFICS),
            [SETTLEMENT]: check new (dbClient, self.metadata.get(SETTLEMENT), psql:MYSQL_SPECIFICS),
            [BANK_ACCOUNT]: check new (dbClient, self.metadata.get(BANK_ACCOUNT), psql:MYSQL_SPECIFICS),
            [CARD]: check new (dbClient, self.metadata.get(CARD), psql:MYSQL_SPECIFICS)
        };
    }

    isolated resource function get users(UserTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get users/[int userid](UserTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post users(UserInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserInsert inserted in data
            select inserted.userid;
    }

    isolated resource function put users/[int userid](UserUpdate value) returns User|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runUpdateQuery(userid, value);
        return self->/users/[userid].get();
    }

    isolated resource function delete users/[int userid]() returns User|persist:Error {
        User result = check self->/users/[userid].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER);
        }
        _ = check sqlClient.runDeleteQuery(userid);
        return result;
    }

    isolated resource function get friends(FriendTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get friends/[int friendId](FriendTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post friends(FriendInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from FriendInsert inserted in data
            select inserted.friendId;
    }

    isolated resource function put friends/[int friendId](FriendUpdate value) returns Friend|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND);
        }
        _ = check sqlClient.runUpdateQuery(friendId, value);
        return self->/friends/[friendId].get();
    }

    isolated resource function delete friends/[int friendId]() returns Friend|persist:Error {
        Friend result = check self->/friends/[friendId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(FRIEND);
        }
        _ = check sqlClient.runDeleteQuery(friendId);
        return result;
    }

    isolated resource function get usergroups(UserGroupTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get usergroups/[int groupId](UserGroupTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post usergroups(UserGroupInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserGroupInsert inserted in data
            select inserted.groupId;
    }

    isolated resource function put usergroups/[int groupId](UserGroupUpdate value) returns UserGroup|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP);
        }
        _ = check sqlClient.runUpdateQuery(groupId, value);
        return self->/usergroups/[groupId].get();
    }

    isolated resource function delete usergroups/[int groupId]() returns UserGroup|persist:Error {
        UserGroup result = check self->/usergroups/[groupId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP);
        }
        _ = check sqlClient.runDeleteQuery(groupId);
        return result;
    }

    isolated resource function get usergroupmembers(UserGroupMemberTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get usergroupmembers/[int g_memberId](UserGroupMemberTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post usergroupmembers(UserGroupMemberInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP_MEMBER);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from UserGroupMemberInsert inserted in data
            select inserted.g_memberId;
    }

    isolated resource function put usergroupmembers/[int g_memberId](UserGroupMemberUpdate value) returns UserGroupMember|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP_MEMBER);
        }
        _ = check sqlClient.runUpdateQuery(g_memberId, value);
        return self->/usergroupmembers/[g_memberId].get();
    }

    isolated resource function delete usergroupmembers/[int g_memberId]() returns UserGroupMember|persist:Error {
        UserGroupMember result = check self->/usergroupmembers/[g_memberId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(USER_GROUP_MEMBER);
        }
        _ = check sqlClient.runDeleteQuery(g_memberId);
        return result;
    }

    isolated resource function get expenses(ExpenseTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get expenses/[int expenseId](ExpenseTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post expenses(ExpenseInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ExpenseInsert inserted in data
            select inserted.expenseId;
    }

    isolated resource function put expenses/[int expenseId](ExpenseUpdate value) returns Expense|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE);
        }
        _ = check sqlClient.runUpdateQuery(expenseId, value);
        return self->/expenses/[expenseId].get();
    }

    isolated resource function delete expenses/[int expenseId]() returns Expense|persist:Error {
        Expense result = check self->/expenses/[expenseId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE);
        }
        _ = check sqlClient.runDeleteQuery(expenseId);
        return result;
    }

    isolated resource function get expenseparticipants(ExpenseParticipantTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get expenseparticipants/[int participantId](ExpenseParticipantTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post expenseparticipants(ExpenseParticipantInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE_PARTICIPANT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ExpenseParticipantInsert inserted in data
            select inserted.participantId;
    }

    isolated resource function put expenseparticipants/[int participantId](ExpenseParticipantUpdate value) returns ExpenseParticipant|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE_PARTICIPANT);
        }
        _ = check sqlClient.runUpdateQuery(participantId, value);
        return self->/expenseparticipants/[participantId].get();
    }

    isolated resource function delete expenseparticipants/[int participantId]() returns ExpenseParticipant|persist:Error {
        ExpenseParticipant result = check self->/expenseparticipants/[participantId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(EXPENSE_PARTICIPANT);
        }
        _ = check sqlClient.runDeleteQuery(participantId);
        return result;
    }

    isolated resource function get transactions(TransactionTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get transactions/[int transactionId](TransactionTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post transactions(TransactionInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(TRANSACTION);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from TransactionInsert inserted in data
            select inserted.transactionId;
    }

    isolated resource function put transactions/[int transactionId](TransactionUpdate value) returns Transaction|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(TRANSACTION);
        }
        _ = check sqlClient.runUpdateQuery(transactionId, value);
        return self->/transactions/[transactionId].get();
    }

    isolated resource function delete transactions/[int transactionId]() returns Transaction|persist:Error {
        Transaction result = check self->/transactions/[transactionId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(TRANSACTION);
        }
        _ = check sqlClient.runDeleteQuery(transactionId);
        return result;
    }

    isolated resource function get settlements(SettlementTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get settlements/[int settlementId](SettlementTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post settlements(SettlementInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SETTLEMENT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from SettlementInsert inserted in data
            select inserted.settlementId;
    }

    isolated resource function put settlements/[int settlementId](SettlementUpdate value) returns Settlement|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SETTLEMENT);
        }
        _ = check sqlClient.runUpdateQuery(settlementId, value);
        return self->/settlements/[settlementId].get();
    }

    isolated resource function delete settlements/[int settlementId]() returns Settlement|persist:Error {
        Settlement result = check self->/settlements/[settlementId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SETTLEMENT);
        }
        _ = check sqlClient.runDeleteQuery(settlementId);
        return result;
    }

    isolated resource function get bankaccounts(BankAccountTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get bankaccounts/[int accountId](BankAccountTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post bankaccounts(BankAccountInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BANK_ACCOUNT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from BankAccountInsert inserted in data
            select inserted.accountId;
    }

    isolated resource function put bankaccounts/[int accountId](BankAccountUpdate value) returns BankAccount|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BANK_ACCOUNT);
        }
        _ = check sqlClient.runUpdateQuery(accountId, value);
        return self->/bankaccounts/[accountId].get();
    }

    isolated resource function delete bankaccounts/[int accountId]() returns BankAccount|persist:Error {
        BankAccount result = check self->/bankaccounts/[accountId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(BANK_ACCOUNT);
        }
        _ = check sqlClient.runDeleteQuery(accountId);
        return result;
    }

    isolated resource function get cards(CardTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get cards/[int cardId](CardTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post cards(CardInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CARD);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from CardInsert inserted in data
            select inserted.cardId;
    }

    isolated resource function put cards/[int cardId](CardUpdate value) returns Card|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CARD);
        }
        _ = check sqlClient.runUpdateQuery(cardId, value);
        return self->/cards/[cardId].get();
    }

    isolated resource function delete cards/[int cardId]() returns Card|persist:Error {
        Card result = check self->/cards/[cardId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(CARD);
        }
        _ = check sqlClient.runDeleteQuery(cardId);
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

