

-- This script is used to populate the database with test data.
-- It should be run after the database schema has been created.
-- Get-Content modules\utils\test_data.sql | & "C:\xampp\mysql\bin\mysql.exe" -u root -D splittrack

-- Users
INSERT INTO User (user_Id, email, first_name, last_name, phone_number, birthdate, currency_pref)
VALUES ('d57bce76', 'alice@example.com', 'Alice', 'Smith', '1234567890', '1995-04-10', 'USD');

INSERT INTO User (user_Id, email, first_name, last_name, phone_number, birthdate, currency_pref)
VALUES ('600fc673', 'bob@example.com', 'Bob', 'Jones', '2345678901', '1993-06-20', 'USD');

INSERT INTO User (user_Id, email, first_name, last_name, phone_number, birthdate, currency_pref)
VALUES ('711ca4dc', 'carol@example.com', 'Carol', 'Taylor', '3456789012', '1990-11-05', 'EUR');

INSERT INTO User (user_Id, email, first_name, last_name, phone_number, birthdate, currency_pref)
VALUES ('65d0ed7b', 'dan@example.com', 'Dan', 'Brown', '4567890123', '1988-09-15', 'GBP');

-- User Groups
INSERT INTO UserGroup (group_Id, name) VALUES ('49bf830f', 'Trip Buddies');
INSERT INTO UserGroup (group_Id, name) VALUES ('2515d78d', 'Office Team');

-- Bank Accounts
INSERT INTO BankAccount (account_Id, account_no, bank, branch)
VALUES ('c6fb7de1', '0011223344', 'Bank A', 'Main Branch');

INSERT INTO BankAccount (account_Id, account_no, bank, branch)
VALUES ('3f005076', '5566778899', 'Bank B', 'City Branch');

-- Cards
INSERT INTO Card (card_Id, card_no, card_name, card_expiry, card_cv, bankAccountAccount_Id)
VALUES ('65ce5d5c', '4111111111111111', 'Alice''s Card', '12/27', '123', 'c6fb7de1');

INSERT INTO Card (card_Id, card_no, card_name, card_expiry, card_cv, bankAccountAccount_Id)
VALUES ('ea638936', '4222222222222222', 'Bob''s Card', '11/26', '321', '3f005076');

-- Friends
INSERT INTO Friend (friend_Id, user_id_1User_Id, user_id_2User_Id)
VALUES ('d4341b6f', 'd57bce76', '600fc673');

INSERT INTO Friend (friend_Id, user_id_1User_Id, user_id_2User_Id)
VALUES ('fe07bc52', '711ca4dc', '65d0ed7b');

-- Friend Requests
INSERT INTO FriendRequest (friendRequest_Id, send_user_idUser_Id, receive_user_Id, status)
VALUES ('19ddeeb0', '600fc673', '711ca4dc', 'pending');

-- Group Members
INSERT INTO UserGroupMember (group_member_Id, member_role, groupGroup_Id, userUser_Id)
VALUES ('2ee48272', 'admin', '49bf830f', 'd57bce76');

-- (Remaining lines continue in the same pattern...)
