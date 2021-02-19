select *
from Invoice;

select *
from Customer;


--excercise 1
select i1.*
from Invoice i1
	Inner Join Customer AS c1 ON i1.CustomerId = c1.CustomerId
where c1.Country = 'Brazil';


--excercise 2
select i1.*, e1.FirstName + ' ' + e1.LastName AS "Full Name"
from Invoice i1
	inner join Customer as c1 ON i1.CustomerId = c1.CustomerId
	inner join Employee as e1 on c1.SupportRepId = e1.EmployeeId;


-- excercise 3
