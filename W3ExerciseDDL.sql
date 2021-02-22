
-- This part is creating the tables (DDL)

CREATE SCHEMA W3Exercise;
GO

CREATE TABLE W3Exercise.Products(
	ID INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50) not null,
	Price FLOAT not null,
);

CREATE TABLE W3Exercise.Customers(
	ID INT IDENTITY PRIMARY KEY,
	Firstname NVARCHAR(50) not null,
	Lastname NVARCHAR(50) not null,
	CardNumber NVARCHAR(30) not null,
);

CREATE TABLE W3Exercise.Orders(
	ID INT IDENTITY PRIMARY KEY,
	ProductID INT not null,
	CustomerID INT not null,
);

drop table W3Exercise.Orders;


ALTER TABLE W3Exercise.Orders ADD CONSTRAINT
	FK_Orders_ProductID FOREIGN KEY (ProductID) REFERENCES W3Exercise.Products(ID);

ALTER TABLE W3Exercise.Orders ADD CONSTRAINT
	FK_Orders_CustomerID FOREIGN KEY (CustomerID) REFERENCES W3Exercise.Customers(ID);



-- This part is manipulating the tables (DML)

-- 1.) Insert 3 items into each table

INSERT INTO W3Exercise.Products(Name, Price) VALUES
	('Banana', 1.19),
	('Apple', 0.99),
	('Orange', 1.09);

INSERT INTO W3Exercise.Customers(Firstname, Lastname, CardNumber) VALUES
	('Hamza', 'Butt', '1234567890123456'),
	('John', 'Doe', '0987654321098765'),
	('Jane', 'White', '1029384756098765');

INSERT INTO W3Exercise.Orders(ProductID, CustomerID) VALUES
	(
		(SELECT ID FROM W3Exercise.Products WHERE Name = 'Banana'),
		(SELECT ID FROM W3Exercise.Customers WHERE Firstname = 'Hamza' AND Lastname = 'Butt')
	),
	(
		(SELECT ID FROM W3Exercise.Products WHERE Name = 'Apple'),
		(SELECT ID FROM W3Exercise.Customers WHERE Firstname = 'Hamza' AND Lastname = 'Butt')
	),
	(
		(SELECT ID FROM W3Exercise.Products WHERE Name = 'Orange'),
		(SELECT ID FROM W3Exercise.Customers WHERE Firstname = 'John' AND Lastname = 'Doe')
	);


-- 2.) add product iphone

INSERT INTO W3Exercise.Products(Name, Price) VALUES
	('iPhone', 200);

-- 3.) add customer Tina Smith

INSERT INTO W3Exercise.Customers(Firstname, Lastname, CardNumber) VALUES
	('Tina', 'Smith', '73890654210123456');

-- 4.) create order for tina smith

INSERT INTO W3Exercise.Orders(ProductID, CustomerID) VALUES
	(
		(SELECT ID FROM W3Exercise.Products WHERE Name = 'iPhone'),
		(SELECT ID FROM W3Exercise.Customers WHERE Firstname = 'Tina' AND Lastname = 'Smith')
	);

-- 5.) report all orders from tina smith

SELECT ord.* FROM W3Exercise.Orders AS ord INNER JOIN W3Exercise.Customers AS cust ON ord.CustomerID = cust.ID
WHERE cust.Firstname = 'Tina' AND cust.Lastname = 'Smith';

-- 6.) report all revenue by sales of iPhone
SELECT prod.Name, Sum(Price) AS Sum FROM W3Exercise.Orders AS ord INNER JOIN W3Exercise.Products AS prod ON ord.ProductID = prod.ID
WHERE prod.Name = 'iPhone'
GROUP BY prod.Name;



-- 7.) Increase price of iPhone to $250

UPDATE W3Exercise.Products
SET Price = 250
Where Name = 'iPhone';