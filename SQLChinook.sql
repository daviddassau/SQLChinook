select firstname + ' ' + lastname as Name, customerid, country
from Customer
where Country != 'USA'