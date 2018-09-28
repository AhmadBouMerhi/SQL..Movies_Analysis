Use sakila;

SELECT * FROM ACTOR;

-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name FROM sakila.actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. 
SELECT CONCAT(first_name, " ", last_name) AS "ACTOR NAME" FROM SAKILA.ACTOR;

-- 2a. Find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
SELECT actor_id, first_name, last_name FROM sakila.actor WHERE first_name = "JOE";

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT * FROM sakila.actor WHERE last_name like "%GEN%";

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT * FROM sakila.actor WHERE last_name like "%LI%" order by last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
Select country_id, country FROM sakila.country Where country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Create a column in the table actor named description and use the data type BLOB 
ALTER Table sakila.actor ADD newDescription BLOB;

-- Display the data to check
SELECT * from actor;

-- 3b. Delete the description column.
ALTER TABLE actor DROP newDescription;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, 
COUNT(last_name) from sakila.actor 
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors but only for names that are shared by at least two actors
SELECT last_name, 
COUNT(last_name) from sakila.actor 
GROUP BY last_name
 HAVING COUNT(last_name)>=2;

-- 4c. fix the actor name GROUCHO WILLIAMS to HARPO WILLIAMS
UPDATE sakila.actor SET first_name = REPLACE(first_name, "GROUCHO", "HARPO") WHERE last_name = "WILLIAMS";

-- 4d. Return the name HARPO to GROUCHO 
UPDATE sakila.actor SET first_name = REPLACE(first_name, "HARPO", "GROUCHO") WHERE first_name = "HARPO";

-- 5a.Create the schema of the address table. 
SHOW CREATE TABLE address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT staff.first_name, staff.last_name, address.address FROM ADDRESS 
join staff on (address.address_id=staff.address_id);

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT staff_id, SUM(amount) 'Total amount' FROM payment 
join staff using (staff_id) 
WHERE payment_date LIKE '2005-08%' group by staff_id;
          
-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.title, film_id, count(actor_id) 
from film_actor 
Join film Using(film_id) 
group by film_id;


-- 6d. Find how many copies of the film Hunchback Impossible exist in inventory system
SELECT * FROM film;
SELECT * FROM inventory;
SELECT film.title, COUNT(inventory.inventory_id) 
FROM film 
JOIN inventory USING(film_id)
WHERE film.title="Hunchback Impossible"
GROUP BY film.film_id;


-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name
SELECT * FROM payment;
SELECT * FROM customer;
SELECT customer_id, c.first_name, c.last_name, SUM(p.amount) "Total Paid by Customer"
FROM payment p
JOIN customer c USING(customer_id)
GROUP BY c.customer_id
ORDER BY c.last_name;

-- 7a. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English
SELECT * FROM film;
SELECT * FROM language;
SELECT film_id, title FROM film
WHERE(title LIKE "K%" 
OR title LIKE "Q%") AND language_id IN(
SELECT language_id FROM language
WHERE name="English");

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;
SELECT actor_id, first_name, last_name FROM actor
WHERE actor_id IN(
SELECT actor_id FROM film_actor
WHERE film_id IN(
SELECT film_id FROM film
WHERE title = "Alone Trip"
));

-- 7c. Retrieve the names and email addresses of all Canadian customers
SELECT * from address;
SELECT * from city;
SELECT * from country;
SELECT * from customer;

SELECT c.customer_id, c.first_name, c.last_name, email FROM customer c 
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country="Canada";

-- 7d. Identify all movies categorized as family films
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT film_id, title FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
WHERE name="Family";

-- 7e. Display the most frequently rented movies in descending order
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

SELECT film_id, title, COUNT(film_id) FROM film
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
GROUP BY title
ORDER BY COUNT(film_id) DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM store;
SELECT * FROM payment;
SELECT * FROM staff;

SELECT staff_id, SUM(amount) FROM payment
JOIN staff USING(staff_id)
JOIN store USING(store_id)
GROUP BY staff_id;

 -- 7g. Write a query to display for each store its store ID, city, and country.
SELECT * FROM store;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

SELECT store_id, city, country FROM store
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id);

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM payment;
SELECT * FROM rental;

SELECT name, SUM(amount) FROM category
JOIN film_category USING(category_id)
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

-- 8a.Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW top_five_genres AS
SELECT name, SUM(amount) FROM category
JOIN film_category USING(category_id)
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

-- 8b. Display the view created in 8a
SELECT * FROM top_five_genres;

-- 8c. Write a query to delete the view top_five_genres (try to display top_five_genres to double-check)
DROP VIEW top_five_genres;
SELECT * FROM top_five_genres;

