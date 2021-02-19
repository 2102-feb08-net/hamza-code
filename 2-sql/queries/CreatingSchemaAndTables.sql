-- in sql server, the default schema is dbo.
CREATE SCHEMA ChatApp;
GO

CREATE TABLE ChatApp.Person(
	Username NVARCHAR (100)
);

SELECT * FROM ChatApp.Person;

ALTER TABLE ChatApp.Person ADD
	AccountCreated DATETIME2;

INSERT INTO ChatApp.Person(Username, AccountCreated) VALUES
	('user123', SYSUTCDATETIME());


SELECT MONTH(AccountCreated) FROM ChatApp.Person;

-- we can put constraints on table columns.
-- NOT NULL vs. NULL

-- CHECK constraint
--		provide arbritrary expression that ensures that column values satisfy the expression

-- DEFAULT
--		provide a different default other than NULL

-- UNIQUE
--		all rows in the column should have unique values

-- IDENTITY
--		prevents manually setting the column's value; auto-increment value.
--		if someone removes the read-only atribute to it and changes values, they can add a duplicate id, so its not inherently UNIQUE

-- PRIMARY KEY
--		implies NOT NULL and UNIQUE
--		adds a clustered index by default

-- FOREIGN KEY


DROP TABLE ChatApp.Person;

CREATE TABLE ChatApp.Person(
	Id INT NOT NULL IDENTITY,
	Username NVARCHAR (100) NOT NULL CHECK(LEN(Username) > 4) UNIQUE,
	AccountCreated DATETIME2 NULL 
		CHECK(AccountCreated < SYSUTCDATETIME()) 
		DEFAULT (SYSUTCDATETIME()),
	COnsTRAINT PK_Id PRIMARY KEY (Id)
);

ALTER TABLE ChatApp.Person DROP Constraint CK__Person__AccountC__0A9D95DB;

INSERT INTO ChatApp.Person(Username) VALUES
	('fred123');

SELECT * FROM ChatApp.Person;



CREATE TABLE ChatApp.Message(
	Id INT NOT NULL IDENTITY,
	Contents NVARCHAR(1000) NOT NULL,
	SenderId INT NOT NULL,
	ReceiverId INT NOT NULL,
);

ALTER TABLE ChatApp.Message ADD CHECK (SenderId != ReceiverId);

ALTER TABLE ChatApp.Message ADD CONSTRAINT
	FK_Message_Sender_Person FOREIGN KEY (SenderId) REFERENCES ChatApp.Person(Id);

ALTER TABLE ChatApp.Message ADD CONSTRAINT
	FK_Message_Receiver_Person FOREIGN KEY (ReceiverId) REFERENCES ChatApp.Person(Id);

INSERT INTO ChatApp.Person(Username) VALUES
	('nick456');

INSERT INTO ChatApp.Message(Contents, SenderId, ReceiverId) VALUES
	('hello', 
		(Select Id FROM ChatApp.Person Where Username = 'fred123'),
		(Select Id FROM ChatApp.Person Where Username = 'nick456')
	);

SELECT * FROM ChatApp.Message;

