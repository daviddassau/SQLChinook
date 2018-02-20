use Chinook
GO

--Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
select firstname + ' ' + lastname as Name, customerid, country
from Customer
where Country != 'USA'

--Provide a query only showing the Customers from Brazil.
select *
from customer
where country = 'Brazil'

--Provide a query showing the Invoices of customers who are from Brazil. 
--The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
select c.FirstName + ' ' + c.LastName Name, i.InvoiceId, i.InvoiceDate, i.BillingCountry
from customer c
join invoice i on i.CustomerId = c.CustomerId
where c.Country = 'Brazil'

--Provide a query showing only the Employees who are Sales Agents.
select e.FirstName + ' ' + e.LastName Name
from Employee e
where e.Title = 'Sales Support Agent'

--Provide a query showing a unique/distinct list of billing countries from the Invoice table.
select i.BillingCountry
from Invoice i

--Provide a query that shows the invoices associated with each sales agent. 
--The resultant table should include the Sales Agent's full name.
select e.FirstName + ' ' + e.LastName Name, i.InvoiceId
from Employee e
join customer c on c.SupportRepId = e.EmployeeId
join invoice i on i.CustomerId = c.CustomerId
where e.Title = 'Sales Support Agent'