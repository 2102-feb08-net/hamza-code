-- excercise 1
SELECT FirstName + ' ' + LastName AS "Full Name", CustomerId, Country
FROM Customer
where Country != 'USA';


-- excercise 2
Select *
from Customer
where Country = 'Brazil';


-- excercise 3
select * 
from Employee
where Title = 'Sales Support Agent'


--excercise 4
select distinct BillingCountry
from Invoice


-- excercise 5
