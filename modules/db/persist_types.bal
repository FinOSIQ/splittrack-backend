// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type User record {|
    readonly int userid;
    string email;
    string password;
    string name;
    string user_role;
    string user_type;
    string phone_no;
    string currency_pref;

|};

public type UserOptionalized record {|
    int userid?;
    string email?;
    string password?;
    string name?;
    string user_role?;
    string user_type?;
    string phone_no?;
    string currency_pref?;
|};

public type UserWithRelations record {|
    *UserOptionalized;
    FriendOptionalized[] friends?;
    UserGroupMemberOptionalized[] groupMembers?;
    ExpenseParticipantOptionalized[] expenseParticipants?;
|};

public type UserTargetType typedesc<UserWithRelations>;

public type UserInsert User;

public type UserUpdate record {|
    string email?;
    string password?;
    string name?;
    string user_role?;
    string user_type?;
    string phone_no?;
    string currency_pref?;
|};

public type Friend record {|
    readonly int friendId;
    int userUserid;
|};

public type FriendOptionalized record {|
    int friendId?;
    int userUserid?;
|};

public type FriendWithRelations record {|
    *FriendOptionalized;
    UserOptionalized user?;
|};

public type FriendTargetType typedesc<FriendWithRelations>;

public type FriendInsert Friend;

public type FriendUpdate record {|
    int userUserid?;
|};

public type UserGroup record {|
    readonly int groupId;
    string name;

|};

public type UserGroupOptionalized record {|
    int groupId?;
    string name?;
|};

public type UserGroupWithRelations record {|
    *UserGroupOptionalized;
    UserGroupMemberOptionalized[] groupMembers?;
|};

public type UserGroupTargetType typedesc<UserGroupWithRelations>;

public type UserGroupInsert UserGroup;

public type UserGroupUpdate record {|
    string name?;
|};

public type UserGroupMember record {|
    readonly int g_memberId;
    string member_role;
    int groupGroupId;
    int userUserid;
|};

public type UserGroupMemberOptionalized record {|
    int g_memberId?;
    string member_role?;
    int groupGroupId?;
    int userUserid?;
|};

public type UserGroupMemberWithRelations record {|
    *UserGroupMemberOptionalized;
    UserGroupOptionalized 'group?;
    UserOptionalized user?;
|};

public type UserGroupMemberTargetType typedesc<UserGroupMemberWithRelations>;

public type UserGroupMemberInsert UserGroupMember;

public type UserGroupMemberUpdate record {|
    string member_role?;
    int groupGroupId?;
    int userUserid?;
|};

public type Expense record {|
    readonly int expenseId;
    string name;
    decimal owing_amount;

    int txnTransactionId;
|};

public type ExpenseOptionalized record {|
    int expenseId?;
    string name?;
    decimal owing_amount?;
    int txnTransactionId?;
|};

public type ExpenseWithRelations record {|
    *ExpenseOptionalized;
    ExpenseParticipantOptionalized[] expenseParticipants?;
    TransactionOptionalized txn?;
|};

public type ExpenseTargetType typedesc<ExpenseWithRelations>;

public type ExpenseInsert Expense;

public type ExpenseUpdate record {|
    string name?;
    decimal owing_amount?;
    int txnTransactionId?;
|};

public type ExpenseParticipant record {|
    readonly int participantId;
    string participant_role;
    int expenseExpenseId;
    int userUserid;
|};

public type ExpenseParticipantOptionalized record {|
    int participantId?;
    string participant_role?;
    int expenseExpenseId?;
    int userUserid?;
|};

public type ExpenseParticipantWithRelations record {|
    *ExpenseParticipantOptionalized;
    ExpenseOptionalized expense?;
    UserOptionalized user?;
|};

public type ExpenseParticipantTargetType typedesc<ExpenseParticipantWithRelations>;

public type ExpenseParticipantInsert ExpenseParticipant;

public type ExpenseParticipantUpdate record {|
    string participant_role?;
    int expenseExpenseId?;
    int userUserid?;
|};

public type Transaction record {|
    readonly int transactionId;

|};

public type TransactionOptionalized record {|
    int transactionId?;
|};

public type TransactionWithRelations record {|
    *TransactionOptionalized;
    SettlementOptionalized[] settlements?;
    ExpenseOptionalized[] expenses?;
|};

public type TransactionTargetType typedesc<TransactionWithRelations>;

public type TransactionInsert Transaction;

public type TransactionUpdate record {|
|};

public type Settlement record {|
    readonly int settlementId;
    decimal settled_amount;
    int txnTransactionId;
|};

public type SettlementOptionalized record {|
    int settlementId?;
    decimal settled_amount?;
    int txnTransactionId?;
|};

public type SettlementWithRelations record {|
    *SettlementOptionalized;
    TransactionOptionalized txn?;
|};

public type SettlementTargetType typedesc<SettlementWithRelations>;

public type SettlementInsert Settlement;

public type SettlementUpdate record {|
    decimal settled_amount?;
    int txnTransactionId?;
|};

public type BankAccount record {|
    readonly int accountId;
    string account_no;
    string bank;
    string branch;

|};

public type BankAccountOptionalized record {|
    int accountId?;
    string account_no?;
    string bank?;
    string branch?;
|};

public type BankAccountWithRelations record {|
    *BankAccountOptionalized;
    CardOptionalized[] cards?;
|};

public type BankAccountTargetType typedesc<BankAccountWithRelations>;

public type BankAccountInsert BankAccount;

public type BankAccountUpdate record {|
    string account_no?;
    string bank?;
    string branch?;
|};

public type Card record {|
    readonly int cardId;
    string card_no;
    string card_name;
    string card_expiry;
    string card_cv;
    int bankaccountAccountId;
|};

public type CardOptionalized record {|
    int cardId?;
    string card_no?;
    string card_name?;
    string card_expiry?;
    string card_cv?;
    int bankaccountAccountId?;
|};

public type CardWithRelations record {|
    *CardOptionalized;
    BankAccountOptionalized bankAccount?;
|};

public type CardTargetType typedesc<CardWithRelations>;

public type CardInsert Card;

public type CardUpdate record {|
    string card_no?;
    string card_name?;
    string card_expiry?;
    string card_cv?;
    int bankaccountAccountId?;
|};

