import ballerina/persist as _;

// User entity (1-to-M with Friend, GroupMember, ExpenseParticipant)
public type User record {|
    readonly int userid;
    string email;
    string password;
    string name;
    string user_role;
    string user_type;
    string phone_no;
    string currency_pref;
    // 1-to-M relationships
    Friend[] friends;
    UserGroupMember[] groupMembers;
    ExpenseParticipant[] expenseParticipants;
|};

// Friend entity (M-to-1 with User)
public type Friend record {|
    readonly int friendId;
    User user;
|};

// Group entity (1-to-M with GroupMember)
public type UserGroup record {|
    readonly int groupId;
    string name;
    UserGroupMember[] groupMembers;
|};

// GroupMember entity (M-to-1 with Group, M-to-1 with User)
public type UserGroupMember record {|
    readonly int g_memberId;
    string member_role;
    UserGroup group;
    User user;
|};

// Expense entity (M-to-1 with Transaction)
public type Expense record {|
    readonly int expenseId;
    string name;
    decimal owing_amount;
    ExpenseParticipant[] expenseParticipants;
    Transaction txn; // Reference to Transaction
|};

// ExpenseParticipant entity (M-to-1 with Expense, M-to-1 with User)
public type ExpenseParticipant record {|
    readonly int participantId;
    string participant_role;
    Expense expense;
    User user;
|};

// Transaction entity (1-to-M with Settlement, 1-to-M with Expense)
public type Transaction record {|
    readonly int transactionId;
    Settlement[] settlements;
    Expense[] expenses; // Added to complete the 1-to-M relationship with Expense
|};

// Settlement entity (M-to-1 with Transaction)
public type Settlement record {|
    readonly int settlementId;
    decimal settled_amount;
    Transaction txn; // Reference to Transaction
|};

// BankAccount entity (1-to-M with Card)
public type BankAccount record {|
    readonly int accountId;
    string account_no;
    string bank;
    string branch;
    Card[] cards;
|};

// Card entity (M-to-1 with BankAccount)
public type Card record {|
    readonly int cardId;
    string card_no;
    string card_name;
    string card_expiry;
    string card_cv;
    BankAccount bankAccount;
|};