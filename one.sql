select firstname,
	   lastname,
	   customerid,
	   country
from Customer
where Country != 'USA'