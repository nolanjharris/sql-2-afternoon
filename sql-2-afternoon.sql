--PRACTICE JOINS =========================================================================
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


-- PRACTICE NESTED QUERIES ============================================================
--1.
SELECT * FROM invoice
WHERE invoice_id IN 
(SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

--2. 
SELECT * FROM playlist_track
WHERE playlist_id IN
(SELECT playlist_id FROM playlist WHERE name = 'Music');

--3.
SELECT name FROM track
WHERE track_id IN 
(SELECT track_id FROM playlist_track WHERE playlist_id = 5);

--4.
SELECT * FROM track
WHERE genre_id IN
(SELECT genre_id FROM genre WHERE name = 'Comedy');

--5.
SELECT * FROM track
WHERE album_id IN
(SELECT album_id FROM album WHERE title = 'Fireball');

--6.
SELECT * FROM track
WHERE album_id IN
(SELECT album_id FROM album WHERE artist_id IN
 (SELECT artist_id FROM artist WHERE name = 'Queen'));


 --PRACTICE UPDATING ROWS =======================================================================
 --1.
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

--2. 
UPDATE customer
SET company = 'Self'
WHERE company IS null;

--3.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

--4. 
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

--5. 
UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS null AND genre_id IN 
(SELECT genre_id FROM genre WHERE name = 'Metal');


--GROUP BY =============================================================================
--1. 
SELECT COUNT(*), genre.name
FROM track
INNER JOIN genre
ON track.genre_id = genre.genre_id
GROUP BY genre.name;

--2. 
SELECT COUNT(*), genre.name
FROM track
JOIN genre 
ON genre.genre_id = track.genre_id
WHERE genre.name IN ('Pop', 'Rock')
GROUP BY genre.name;

--3. 
SELECT COUNT(*), artist.name
FROM album
JOIN artist
ON album.artist_id = artist.artist_id
GROUP BY artist.name;


--USE DISTINCT =============================================================================
--1. 
SELECT DISTINCT composer FROM track;

--2.
SELECT DISTINCT billing_postal_code FROM invoice;

--3.
SELECT DISTINCT company FROM customer;


--DELETE ROWS ==============================================================================
--1.
CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
SELECT * FROM practice_delete;

--2.
DELETE FROM practice_delete 
WHERE type = 'bronze';

--3.
DELETE FROM practice_delete 
WHERE type = 'silver';

--4.
DELETE FROM practice_delete 
WHERE value = 150;


--eCOMMERCE SIMULATION =================================================================

--create users table --
CREATE TABLE users
(user_id SERIAL PRIMARY KEY,
 name VARCHAR(255) NOT NULL,
 email VARCHAR(255) NOT NULL)

--create products table --
CREATE TABLE products
(product_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
price NUMERIC NOT NULL)

--create orders table --
CREATE TABLE orders
(order_id SERIAl PRIMARY KEY,
 product_id INTEGER FOREIGN KEY REFERENCES products(product_id),
 user_id INTEGER FOREIGN KEY REFERENCES users(user_id));

 --add 3 users to users table --
 INSERT INTO products
(name, email)
VALUES
('NolanJames', 'theOGballer@hustlin.com'),
('Spanky', 'littleRascal@twoPickles.com'),
('Mike Jones', 'who@3308004.com')

--add 3 products to products table --
INSERT INTO products
(name, price)
VALUES
('New Cadillac', 95000),
('Toilet Paper', 3),
('Gold Grill', 2000)


INSERT INTO orders (order_id, user_id, product_id)
VALUES (1, 1, 1),
       (1, 1, 3),
       (2, 2, 2),
       (3, 3, 3),
       (3, 3, 2),
       (4, 1, 1);

--Get all products for the first order
SELECT p.name
FROM orders o
JOIN product p ON o.product_id = p.product_id
WHERE o.order_id = 1;
​
--Get all orders
SELECT *
FROM orders;
​
--Get the total cost of an order
SELECT o.order_id, SUM(p.price) AS total_price
FROM orders o
JOIN product p ON o.product_id = p.product_id
GROUP BY o.order_id;

--Added a foreign key reference from orders to users in the above create table statement
--Updated the orders table to link a user to each order in the above create table statement 

--Get all orders for a user
SELECT *
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE u.user_id = 1;
​
--Get how many orders each user has
SELECT u.user_id, COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id;
​
--BLACK DIAMOND --Get the total amount on all orders for each user -----------------------
SELECT u.user_id, SUM(p.price)
FROM orders o
JOIN product p ON o.product_id = p.product_id
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id;