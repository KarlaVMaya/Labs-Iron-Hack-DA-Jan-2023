# LAB 2.08 #
-- In this lab, you will be using the Sakila database of movie rentals. 
-- You have been using this database for a couple labs already, 
-- but if you need to get the data again, refer to the official installation link.
-- The database is structured as follows:
# Instructions #
use sakila;
select*from film;
-- Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.

SELECT count(length) from film where length is null;
SELECT length from film where length = 0;

SELECT title as Title, length as Length,
DENSE_RANK() OVER (ORDER BY length asc) AS 'Length_ RANK'
from film;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
-- In your output, only select the columns title, length, rating and rank.

SELECT count(length) from film where length is null;

# Rating can be G, PG, PG-13, R, or NC-17.
select title, length as Length, rating as Rating,
dense_rank() over (order by length asc) as 'RANK_LengthRatingG'
from film 
where rating like 'PG'
order by Length, Rating;

select title, length as Length, rating as Rating,
dense_rank() over (order by length asc) as 'RANK_LengthRatingG'
from film 
where rating like 'G'
order by Length, Rating;

select title, length as Length, rating as Rating,
dense_rank() over (order by length asc) as 'RANK_LengthRatingG'
from film 
where rating like 'PG-13'
order by Length, Rating;

select title, length as Length, rating as Rating,
dense_rank() over (order by length asc) as 'RANK_LengthRatingG'
from film 
where rating like 'R'
order by Length, Rating;

select title, length as Length, rating as Rating,
dense_rank() over (order by length asc) as 'RANK_LengthRatingG'
from film 
where rating like 'NC-17'
order by Length, Rating;

-- How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".
SELECT*FROM category;
SELECT*FROM film_category;

select c.name, count(f.film_id) counter
from category c left join film_category f
on f.category_id = c.category_id
group by c.category_id, c.name;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" 
-- and "film actor" and count the number of times an actor appears.
select*from actor;
select*from film_actor;

SELECT actor.first_name AS first_name,
actor.last_name AS last_name,
a.film_count
FROM actor
LEFT JOIN( SELECT COUNT(film_id) AS film_count, actor_id FROM film_actor GROUP BY actor_id)AS a 
ON (actor.actor_id=a.actor_id)
ORDER BY film_count DESC
LIMIT 1;

-- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT 
customer.first_name,
customer.last_name,
a.total_rent
FROM customer
LEFT JOIN(
SELECT 
rental.customer_id,
SUM(rental.customer_id) AS total_rent
FROM rental
LEFT JOIN customer ON (rental.customer_id=customer.customer_id)
GROUP BY 1) AS a ON(customer.customer_id=a.customer_id)
ORDER BY a.total_rent DESC
LIMIT 1;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and 
-- count the rental ids for each film.

SELECT
COUNT(film.title) AS film_count,
film.title
FROM payment
LEFT JOIN rental ON (payment.rental_id=rental.rental_id)
LEFT JOIN inventory ON (rental.inventory_id=inventory.inventory_id)
LEFT JOIN film ON (inventory.film_id=film.film_id)
GROUP BY film.title
ORDER BY film_count DESC
LIMIT 1;

