/* 
1. Write a query to return the email, first name, last name, and Genre of all music listeners 
Return your list ordered alphabetically by email starting with A
*/
--select * from genre;
--select * from track;
--select * from customer;

select distinct email, first_name, last_name 
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id IN (
select track_id from track
join genre on track.genre_id  = genre.genre_id
where genre.name like 'Rock'
)
order by email;


/*   
2. Lets invite the artist who have written the most rock music in our dataset.
write a query that returns the artist name and total track count of the top 10 rock brands 
*/

--select * from artist;
--select * from album;
--select * from genre;
--select * from track;

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs DESC
limit 10;

/*
3. Return the name of all tracks name that have a song length longer than average song length. Return the name 
and miliseconds for each track. Order the song length with longest songs listed first. 
*/


select * from track;

select name, milliseconds
from track 

where milliseconds > (
select avg(milliseconds) as avg_track_length
from track)

order by milliseconds DESC;


























