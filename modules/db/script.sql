-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `ExpenseParticipant`;
DROP TABLE IF EXISTS `Settlement`;
DROP TABLE IF EXISTS `Friend`;
DROP TABLE IF EXISTS `Expense`;
DROP TABLE IF EXISTS `UserGroupMember`;
DROP TABLE IF EXISTS `Card`;
DROP TABLE IF EXISTS `User`;
DROP TABLE IF EXISTS `Transaction`;
DROP TABLE IF EXISTS `BankAccount`;
DROP TABLE IF EXISTS `UserGroup`;

CREATE TABLE `UserGroup` (
	`groupId` INT NOT NULL,
	`name` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`groupId`)
);

CREATE TABLE `BankAccount` (
	`accountId` INT NOT NULL,
	`account_no` VARCHAR(191) NOT NULL,
	`bank` VARCHAR(191) NOT NULL,
	`branch` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`accountId`)
);

CREATE TABLE `Transaction` (
	`transactionId` INT NOT NULL,
	PRIMARY KEY(`transactionId`)
);

CREATE TABLE `User` (
	`userid` INT NOT NULL,
	`email` VARCHAR(191) NOT NULL,
	`password` VARCHAR(191) NOT NULL,
	`name` VARCHAR(191) NOT NULL,
	`user_role` VARCHAR(191) NOT NULL,
	`user_type` VARCHAR(191) NOT NULL,
	`phone_no` VARCHAR(191) NOT NULL,
	`currency_pref` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`userid`)
);

CREATE TABLE `Card` (
	`cardId` INT NOT NULL,
	`card_no` VARCHAR(191) NOT NULL,
	`card_name` VARCHAR(191) NOT NULL,
	`card_expiry` VARCHAR(191) NOT NULL,
	`card_cv` VARCHAR(191) NOT NULL,
	`bankaccountAccountId` INT NOT NULL,
	FOREIGN KEY(`bankaccountAccountId`) REFERENCES `BankAccount`(`accountId`),
	PRIMARY KEY(`cardId`)
);

CREATE TABLE `UserGroupMember` (
	`g_memberId` INT NOT NULL,
	`member_role` VARCHAR(191) NOT NULL,
	`groupGroupId` INT NOT NULL,
	FOREIGN KEY(`groupGroupId`) REFERENCES `UserGroup`(`groupId`),
	`userUserid` INT NOT NULL,
	FOREIGN KEY(`userUserid`) REFERENCES `User`(`userid`),
	PRIMARY KEY(`g_memberId`)
);

CREATE TABLE `Expense` (
	`expenseId` INT NOT NULL,
	`name` VARCHAR(191) NOT NULL,
	`owing_amount` DECIMAL(65,30) NOT NULL,
	`txnTransactionId` INT NOT NULL,
	FOREIGN KEY(`txnTransactionId`) REFERENCES `Transaction`(`transactionId`),
	PRIMARY KEY(`expenseId`)
);

CREATE TABLE `Friend` (
	`friendId` INT NOT NULL,
	`userUserid` INT NOT NULL,
	FOREIGN KEY(`userUserid`) REFERENCES `User`(`userid`),
	PRIMARY KEY(`friendId`)
);

CREATE TABLE `Settlement` (
	`settlementId` INT NOT NULL,
	`settled_amount` DECIMAL(65,30) NOT NULL,
	`txnTransactionId` INT NOT NULL,
	FOREIGN KEY(`txnTransactionId`) REFERENCES `Transaction`(`transactionId`),
	PRIMARY KEY(`settlementId`)
);

CREATE TABLE `ExpenseParticipant` (
	`participantId` INT NOT NULL,
	`participant_role` VARCHAR(191) NOT NULL,
	`expenseExpenseId` INT NOT NULL,
	FOREIGN KEY(`expenseExpenseId`) REFERENCES `Expense`(`expenseId`),
	`userUserid` INT NOT NULL,
	FOREIGN KEY(`userUserid`) REFERENCES `User`(`userid`),
	PRIMARY KEY(`participantId`)
);


