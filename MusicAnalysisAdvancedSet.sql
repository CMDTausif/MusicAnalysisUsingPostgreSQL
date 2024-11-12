/* 
1. Find out how much amount spent by each customers on the artist? write a query to return the customer name 
artist name and total spent
*/

with best_selling_artist as (
select artist.artist_id as Artist_Id, artist.name as Artist_Name,
sum(invoice_line.unit_price * invoice_line.quantity ) as total_sales
from invoice_line
join track on track.track_id = invoice_line.track_id
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
group by 1
order by 3 desc
limit 1)

select customer.customer_id, customer.first_name, customer.last_name, best_selling_artist.Artist_Name,
sum (invoice_line.unit_price * invoice_line.quantity) as amount_spent
from invoice 
join customer on customer.customer_id = invoice.customer_id
join invoice_line  on invoice_line.invoice_id = invoice.invoice_id
join track on track.track_id  = invoice_line.track_id
join album on album.album_id = track.album_id
join best_selling_artist on best_selling_artist.artist_id = album.artist_id
group by 1, 2, 3, 4
order by 5 DESC;


/*
2. We want to find out the most popular music genre for each country.
we determine the most popular genre as genre with the highest amount of purchases
write a query that returns each country along with the top genre.
for countries where the maximum number of purchases is shared return all genres
*/

with popular_genre as 
(
select count(invoice_line.quantity) as purchases, customer.country, genre.name,  genre.genre_id,
row_number() over(partition by customer.country order by count(invoice_line.quantity)DESC) as RowNum
from invoice_line
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
group by 2, 3, 4
order by 2 ASC, 1 DESC
)
select * from popular_genre where RowNum <= 1


/*   
3. write a query that determines the customer that has spent the most on music for each country.
write the query that returns the country along with the top customers and how much they spent.
for countries where the top amount is shared provide all customers who spent this amount 
*/

With RECURSIVE
    customer_with_country AS (
		select customer.customer_id, first_name, last_name, billing_country, sum(total) as total_spending
		from invoice
		join customer on customer.customer_id = invoice.customer_id
		group by 1, 2, 3, 4
		order by 2, 3 DESC
	),
	
	country_max_spending as (

		select billing_country, MAX(total_spending) as max_spending
		from customer_with_country
		group by billing_country)
		
select cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
from customer_with_country cc
join country_max_spending ms
on cc.billing_country  = ms.billing_country
where cc.total_spending  =  ms.max_spending 
order by 1;



























