USE sakila;

#1a
SELECT first_name,last_name FROM actor;

#1b
SELECT first_name,last_name,
CONCAT (first_name,' ',last_name)
FROM actor;

#2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

#2b
SELECT * FROM actor WHERE last_name LIKE "%GEN%";

#2c
SELECT * FROM actor WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

#2d
SELECT country_id, country
FROM country 
WHERE country IN("Afganistan","Bangladesh","China");

#3a
ALTER TABLE actor
ADD description BLOB(255);

#3b
ALTER TABLE actor
DROP COLUMN description;

#4a
SELECT COUNT(last_name), last_name
FROM actor
GROUP BY last_name;

#4b
SELECT last_name, COUNT(last_name) AS "number"
FROM actor
GROUP BY last_name
HAVING number >= 2;

#4c
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

#4d
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO" AND last_name = "WILLIAMS";

#5a
SHOW CREATE TABLE address;

CREATE TABLE IF NOT EXISTS address(
address_id SMALLINT(5),
address VARCHAR(50),
address2 VARCHAR(50),
district VARCHAR(20),
city_id SMALLINT(5),
postal_code VARCHAR(10),
phone VARCHAR(20),
location GEOMETRY,
last_update TIMESTAMP
);

#6a
SELECT first_name, last_name, address
FROM staff
JOIN address ON
staff.address_id = address.address_id;

#6b
SELECT first_name, last_name, SUM(amount)
FROM staff
JOIN payment ON
staff.staff_id = payment.staff_id
WHERE payment_date LIKE "2005-08-%"
GROUP BY staff.staff_id;

#6c
SELECT title, film.film_id, COUNT(film.film_id)
FROM film
INNER JOIN film_actor ON
film.film_id = film_actor.film_id
GROUP BY film.film_id;

#6d
SELECT title, film.film_id, COUNT(film.film_id)
FROM film
JOIN inventory ON
film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible";

#6e
SELECT first_name, last_name, SUM(amount)
FROM customer 
JOIN payment ON
customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;

#7a
SELECT title
FROM film
WHERE title LIKE "K%" OR title LIKE "Q%" AND
language_id IN (SELECT language_id
FROM language 
WHERE name = "English");

#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
FROM film_actor WHERE film_id IN (SELECT film_id
FROM film WHERE title = "Alone Trip"));

#7c
SELECT first_name, last_name, email
FROM customer 
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = "Canada";

#7d
SELECT film.title
FROM film 
JOIN film_list
ON film.title = film_list.title
WHERE film_list.category = 'Family';

#7e
SELECT title, COUNT(rental_id) AS "Total_Rented"
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY "Total_Rented" DESC;

#7f
SELECT store.store_id, SUM(payment.amount)
FROM store 
JOIN customer ON customer.store_id = store.store_id
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

#7g
SELECT store.store_id, country.country, city.city
FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON country.country_id = city.country_id;
 
#7h
SELECT category.name, SUM(payment.amount) as "Gross_Revenue"
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY "Gross_Revenue" DESC
LIMIT 5;

#8a
CREATE VIEW top_five_genres AS
SELECT category.name, SUM(payment.amount) as "Gross_Revenue"
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY "Gross_Revenue" DESC
LIMIT 5;

#8b 
SELECT * FROM Top_Five_Genres; 

#8c. 
DROP VIEW Top_Five_Genres; 














