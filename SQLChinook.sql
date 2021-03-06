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

--Provide a query that shows the total number of tracks in each playlist. 
--The Playlist name should be included on the resulant table.
select *
from Playlist

select *
from Track

select *
from PlaylistTrack

select *
from Genre

select COUNT(*) as [Number of tracks in each playlist]
from Playlist

--Provide a query that shows all the Tracks, but displays no IDs. 
--The result should include the Album name, Media type and Genre.
select t.Name as [Track Name],
	   a.Title as [Album Name],
	   m.Name as [Media Type],
	   g.Name as [Genre]
from Track t
	join Album a on a.AlbumId = t.TrackId
	join MediaType m on m.MediaTypeId = t.TrackId
	join Genre g on g.GenreId = t.TrackId

--Provide a query that shows all Invoices but includes the # of invoice line items.
select *
from Invoice

select *
from InvoiceLine

select i.InvoiceId as [Invoices],
	   il.TrackId [Number of invoice line items]
from Invoice i
	join InvoiceLine il on il.InvoiceLineId = i.InvoiceId


--Provide a query that shows total sales made by each sales agent.
select e.FirstName + ' ' + e.LastName as [Sales Agent],
	   COUNT(*) as [Number of Sales]
from Employee e
	join Customer c on c.SupportRepId = e.EmployeeId
	join Invoice i on i.CustomerId = c.CustomerId
group by e.FirstName, e.LastName


--Which sales agent made the most in sales in 2009?
select e.FirstName + ' ' + e.LastName as [Sales Agent],
	   COUNT(*) as [Number of sales in 2009]
from Employee e
	join Customer c on c.SupportRepId = e.EmployeeId
	join Invoice i on i.CustomerId = c.CustomerId
where DATENAME(yyyy, i.InvoiceDate) like '%2009%'
group by e.FirstName, e.LastName
order by COUNT(*) desc
























-- subquery
select (select firstname + ' ' + lastname 
	    from customer 
		where customer.CustomerId = i.customerId), 
  i.Total
from Invoice i
where i.InvoiceDate between '2009-01-01' and '2011-01-01'


select
i.CustomerId,
i.Total,
x.NumberOfItems
from Invoice i
	join (select invoiceId, count(*) NumberOfItems
		  from InvoiceLine il
		  group by il.InvoiceId
		  ) x on x.InvoiceId = i.InvoiceId
where i.InvoiceDate between '2009-01-01' and '2011-01-01'


select *
from invoice i
	join InvoiceLine x on x.InvoiceId = i.InvoiceId
where  x.TrackId in (select TrackId from Track where Name like 'a%')