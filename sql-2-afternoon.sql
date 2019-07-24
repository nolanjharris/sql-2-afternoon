--1.
SELECT *
FROM invoice
INNER JOIN invoice_line
ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > .99;

--2. 
SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total
FROM customer
INNER JOIN invoice
ON customer.customer_id = invoice.customer_id;

--3. 
SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name
FROM customer
INNER JOIN employee
ON customer.support_rep_id = employee.employee_id;

--4.
SELECT album.title, artist.name
FROM artist
INNER JOIN album
ON album.artist_id = artist.artist_id;

--5. 
SELECT playlist_track.track_id
FROM playlist_track
INNER JOIN playlist
ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';

--6. 
SELECT track.name
FROM track
INNER JOIN playlist_track
ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5;

--7. 
SELECT track.name, playlist.name
FROM track
INNER JOIN playlist_track
ON track.track_id = playlist_track.track_id
INNER JOIN playlist
ON playlist_track.playlist_id = playlist.playlist_id;

--8. 
SELECT track.name, album.title
FROM track
INNER JOIN album
ON track.album_id = album.album_id
INNER JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name = 'Alternative & Punk';


--BLACK DIAMOND -------------------------------------------
SELECT track.name, genre.name, album.title, artist.name
FROM track
INNER JOIN genre
ON track.genre_id = genre.genre_id
INNER JOIN album
ON track.album_id = album.album_id
INNER JOIN artist
ON album.artist_id = artist.artist_id
INNER JOIN playlist_track
ON track.track_id = playlist_track.track_id
INNER JOIN playlist
ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';