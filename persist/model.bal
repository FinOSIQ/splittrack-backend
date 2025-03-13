import ballerina/persist as _;

public type User record {|
    readonly int user_Id;
    string email;
    string password;
    string name;
    string user_type;
    string phone_no;
    string currency_pref;
    FriendRequest[] friendRequests;
    UserGroupMember[] groupMembers;
    ExpenseParticipant[] expenseParticipants;
    Transaction[] transactions;
    Friend[] friends;
	Friend[] friend;
|};

public type FriendRequest record {|
    readonly int friend_Id;
    User send_user_Id;
    int receive_user_Id;
    string status;
|};

public type Friend record {|
    readonly int friend_Id;
    User user_Id_1;
    User user_Id_2;
|};

public type UserGroup record {|
    readonly int group_Id;
    string name;
    UserGroupMember[] groupMembers;
    Expense[] expenses;
|};

public type UserGroupMember record {|
    readonly int group_member_Id;
    string member_role;
    UserGroup group;
    User user;
|};

public type Expense record {|
    readonly int expense_Id;
    string name;
    decimal total_amount;
    ExpenseParticipant[] expenseParticipants;
    Transaction[] transactions;
	UserGroup usergroup;
|};

public type ExpenseParticipant record {|
    readonly int participant_Id;
    string participant_role;
    decimal owning_amount;
    Expense expense;
    User user;
|};

public type Transaction record {|
    readonly int transaction_Id;
    decimal payed_amount;
	Expense expense;
	User payee_Id;
|};


public type BankAccount record {|
    readonly int account_Id;
    string account_no;
    string bank;
    string branch;
    Card[] cards;
|};

public type Card record {|
    readonly int card_Id;
    string card_no;
    string card_name;
    string card_expiry;
    string card_cv;
    BankAccount bankAccount;
|};