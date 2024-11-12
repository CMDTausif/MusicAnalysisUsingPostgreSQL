/* Q1. Who is the senior most employee based on the job title */

select * from employee
order by levels desc 
limit 1

/* Q2 which countries have the most Invoices */
select count(*) as Count, billing_country
from invoice
group by billing_country 
order by Count desc

/* 
3. What are the top 5 values of Total Invoice
*/

--select * from invoice 

select total from invoice
order by total desc
limit 5


/*
4. which city has the best customer? write a query that returns one city that has highest sum of invoice totals.
return both city name and sum of all invoice total
*/

select sum(total) as Total_Invoice, billing_city  
from invoice
group by billing_city
order by Total_Invoice desc


/*
5. Who is the best customer? The customer who has spent most money will be declared as the best customer. 
write a query who have spent most pf the money
*/
--select * from invoice
--select * from customer


select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as Total
from customer
JOIN invoice on customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total desc
limit 1


















