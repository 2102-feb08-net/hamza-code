

create schema Exercise;
GO

Create Table Exercise.Employee(
	ID INT not null IDENTITY Primary key,
	FirstName NVARCHAR(50) not null,
	LastName NVARCHAR(50) not null,
	SSN NVARCHAR(20) not null UNIQUE,
	DeptID INT not null
);


Create table Exercise.Department(
	ID INT not null IDENTITY Primary Key,
	Name NVARCHAR(50) not null,
	Location NVARCHAR(100) not null,
);


Create Table Exercise.EmpDetails(
	ID INT not null IDENTITY Primary Key,
	EmployeeID INT not null,
	Salary INT not null,
	[Address 1] NVARCHAR(500) not null,
	[Address 2] NVARCHAR(500) NULL,
	City NVARCHAR(100) not null,
	State NVARCHAR(100) not null,
	Country NVARCHAR(100) not null,
);

ALTER TABLE Exercise.Employee ADD CONSTRAINT
	FK_Employee_DeptID FOREIGN KEY (DeptID) REFERENCES Exercise.Department(ID);

ALTER TABLE Exercise.EmpDetails ADD CONSTRAINT
	FK_EmpDetails_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Exercise.Employee(ID);


INSERT INTO Exercise.Department(Name, Location) VALUES 
	('HR', 'NY'),
	('Trainer', 'VA'),
	('Associate', 'PA');


INSERT INTO Exercise.Employee(FirstName, LastName, SSN, DeptID) VALUES
	('Hamza', 'Butt', '111-11-1111', 
		(Select ID from Exercise.Department where Name = 'Associate')
	),
	('Nick', 'Escalona', '222-22-2222', 
		(Select ID from Exercise.Department where Name = 'Trainer')
	),
	('Random', 'Person', '333-33-3333', 
		(Select ID from Exercise.Department where Name = 'Associate')
	);



select * from Exercise.Department;
select * from Exercise.Employee;