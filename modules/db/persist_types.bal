// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type User record {|
    readonly int user_Id;
    string email;
    string password;
    string name;
    string user_type;
    string phone_no;
    string currency_pref;

|};

public type UserOptionalized record {|
    int user_Id?;
    string email?;
    string password?;
    string name?;
    string user_type?;
    string phone_no?;
    string currency_pref?;
|};

public type UserWithRelations record {|
    *UserOptionalized;
    FriendRequestOptionalized[] friendRequests?;
    UserGroupMemberOptionalized[] groupMembers?;
    ExpenseParticipantOptionalized[] expenseParticipants?;
    TransactionOptionalized[] transactions?;
    FriendOptionalized[] friends?;
    FriendOptionalized[] friend?;
|};

public type UserTargetType typedesc<UserWithRelations>;

public type UserInsert User;

public type UserUpdate record {|
    string email?;
    string password?;
    string name?;
    string user_type?;
    string phone_no?;
    string currency_pref?;
|};

public type FriendRequest record {|
    readonly int friend_Id;
    int send_user_idUser_Id;
    int receive_user_Id;
    string status;
|};

public type FriendRequestOptionalized record {|
    int friend_Id?;
    int send_user_idUser_Id?;
    int receive_user_Id?;
    string status?;
|};

public type FriendRequestWithRelations record {|
    *FriendRequestOptionalized;
    UserOptionalized send_user_Id?;
|};

public type FriendRequestTargetType typedesc<FriendRequestWithRelations>;

public type FriendRequestInsert FriendRequest;

public type FriendRequestUpdate record {|
    int send_user_idUser_Id?;
    int receive_user_Id?;
    string status?;
|};

public type Friend record {|
    readonly int friend_Id;
    int user_id_1User_Id;
    int user_id_2User_Id;
|};

public type FriendOptionalized record {|
    int friend_Id?;
    int user_id_1User_Id?;
    int user_id_2User_Id?;
|};

public type FriendWithRelations record {|
    *FriendOptionalized;
    UserOptionalized user_Id_1?;
    UserOptionalized user_Id_2?;
|};

public type FriendTargetType typedesc<FriendWithRelations>;

public type FriendInsert Friend;

public type FriendUpdate record {|
    int user_id_1User_Id?;
    int user_id_2User_Id?;
|};

public type UserGroup record {|
    readonly int group_Id;
    string name;

|};

public type UserGroupOptionalized record {|
    int group_Id?;
    string name?;
|};

public type UserGroupWithRelations record {|
    *UserGroupOptionalized;
    UserGroupMemberOptionalized[] groupMembers?;
    ExpenseOptionalized[] expenses?;
|};

public type UserGroupTargetType typedesc<UserGroupWithRelations>;

public type UserGroupInsert UserGroup;

public type UserGroupUpdate record {|
    string name?;
|};

public type UserGroupMember record {|
    readonly int group_member_Id;
    string member_role;
    int groupGroup_Id;
    int userUser_Id;
|};

public type UserGroupMemberOptionalized record {|
    int group_member_Id?;
    string member_role?;
    int groupGroup_Id?;
    int userUser_Id?;
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
    int groupGroup_Id?;
    int userUser_Id?;
|};

public type Expense record {|
    readonly int expense_Id;
    string name;
    decimal total_amount;

    int usergroupGroup_Id;
|};

public type ExpenseOptionalized record {|
    int expense_Id?;
    string name?;
    decimal total_amount?;
    int usergroupGroup_Id?;
|};

public type ExpenseWithRelations record {|
    *ExpenseOptionalized;
    ExpenseParticipantOptionalized[] expenseParticipants?;
    TransactionOptionalized[] transactions?;
    UserGroupOptionalized usergroup?;
|};

public type ExpenseTargetType typedesc<ExpenseWithRelations>;

public type ExpenseInsert Expense;

public type ExpenseUpdate record {|
    string name?;
    decimal total_amount?;
    int usergroupGroup_Id?;
|};

public type ExpenseParticipant record {|
    readonly int participant_Id;
    string participant_role;
    decimal owning_amount;
    int expenseExpense_Id;
    int userUser_Id;
|};

public type ExpenseParticipantOptionalized record {|
    int participant_Id?;
    string participant_role?;
    decimal owning_amount?;
    int expenseExpense_Id?;
    int userUser_Id?;
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
    decimal owning_amount?;
    int expenseExpense_Id?;
    int userUser_Id?;
|};

public type Transaction record {|
    readonly int transaction_Id;
    decimal payed_amount;
    int expenseExpense_Id;
    int payee_idUser_Id;
|};

public type TransactionOptionalized record {|
    int transaction_Id?;
    decimal payed_amount?;
    int expenseExpense_Id?;
    int payee_idUser_Id?;
|};

public type TransactionWithRelations record {|
    *TransactionOptionalized;
    ExpenseOptionalized expense?;
    UserOptionalized payee_Id?;
|};

public type TransactionTargetType typedesc<TransactionWithRelations>;

public type TransactionInsert Transaction;

public type TransactionUpdate record {|
    decimal payed_amount?;
    int expenseExpense_Id?;
    int payee_idUser_Id?;
|};

public type BankAccount record {|
    readonly int account_Id;
    string account_no;
    string bank;
    string branch;

|};

public type BankAccountOptionalized record {|
    int account_Id?;
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
    readonly int card_Id;
    string card_no;
    string card_name;
    string card_expiry;
    string card_cv;
    int bankaccountAccount_Id;
|};

public type CardOptionalized record {|
    int card_Id?;
    string card_no?;
    string card_name?;
    string card_expiry?;
    string card_cv?;
    int bankaccountAccount_Id?;
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
    int bankaccountAccount_Id?;
|};

