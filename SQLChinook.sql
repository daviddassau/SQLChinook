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
--where e.Title = 'Sales Support Agent'

--Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
select c.FirstName + ' ' + c.LastName Name, 
	   c.Country,
	   i.Total,
	   e.FirstName + ' ' + e.LastName as [Sales Agent]
from Customer c
join Invoice i on i.CustomerId = c.CustomerId
join Employee e on e.EmployeeId = c.SupportRepId

--How many Invoices were there in 2009 and 2011?
select count(*) as [Total Invoices]
from Invoice
where InvoiceDate like '%2009%'
or InvoiceDate like '%2011%'

--What are the respective total sales for each of those years?
select SUM(Total) as [Total Sales for 2009 and 2011]
from Invoice
where InvoiceDate like '%2009%'
or InvoiceDate like '%2011%'

--Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
select COUNT(*) as [Number of line items for Invoice 37]
from InvoiceLine
where InvoiceId = 37

--Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
select COUNT(*) as [Number of line items for each invoice]
from InvoiceLine
group by InvoiceId

--Provide a query that includes the purchased track name with each invoice line item.
select t.Name as [Track Name],
	   i.InvoiceLineId
from Track t
join InvoiceLine i on i.InvoiceId = t.TrackId

--Provide a query that includes the purchased track name AND artist name with each invoice line item.
select t.Name as [Track Name],
	   t.Composer as [Artist],
	   i.InvoiceLineId
from Track t
join InvoiceLine i on i.InvoiceId = t.TrackId

--Provide a query that shows the # of invoices per country.
select COUNT(InvoiceId) as [Number of invoices],
	   BillingCountry
from Invoice
group by BillingCountry