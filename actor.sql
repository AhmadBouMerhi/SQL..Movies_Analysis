Use sakila;

SELECT * FROM ACTOR;

-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name FROM sakila.actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT CONCAT(first_name, " ", last_name) AS "ACTOR NAME" FROM SAKILA.ACTOR;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name FROM sakila.actor WHERE first_name = "JOE";

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT * FROM sakila.actor WHERE last_name like "%GEN%";

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT * FROM sakila.actor WHERE last_name like "%LI%" order by last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
Select country_id, country FROM sakila.country Where country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, 
-- so create a column in the table actor named description and use the data type BLOB (Make sure to research the 
-- type BLOB, as the difference between it and VARCHAR are significant).

