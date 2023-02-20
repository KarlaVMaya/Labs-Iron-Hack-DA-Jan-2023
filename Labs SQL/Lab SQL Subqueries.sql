#Lab | SQL Subqueries

#In this lab, you will be using the Sakila database of movie rentals. 
#Create appropriate joins wherever necessary.
use sakila;
#Instructions
#How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, COUNT(inventory_id)
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";
#List all films whose length is longer than the average of all the films.
select*from film;
select title from film 
where length >(select avg(length) from film);

#Use subqueries to display all actors who appear in the film Alone Trip.

SELECT last_name, first_name
FROM actor
WHERE actor_id in
(SELECT actor_id FROM film_actor
WHERE film_id in 
(SELECT film_id FROM film
WHERE title = "Alone Trip"));
        
#Sales have been lagging among young families, and you wish to target all family movies 
#for a promotion. Identify all movies categorized as family films.
SELECT title, category
FROM film_list
WHERE category = 'Family';

#Get name and email from customers from Canada using subqueries. Do the same with joins.
-- Note that to create a join, you will have to identify the correct tables with their
-- primary keys and foreign keys, that will help you get the relevant information.

select email,first_name from sakila.customer 
where address_id in (select address_id from sakila.address
where city_id in (select city_id from sakila.city
where country_id in (select country_id from sakila.country
where country = 'canada')) );

#Which are films starred by the most prolific actor? Most prolific actor is defined 
-- as the actor that has acted in the most number of films. First you will have 
-- to find the most prolific actor and then use that actor_id to find the different films 
-- that he/she starred.

SELECT T1.first_name, T1.last_name, count(*) as films
FROM sakila.actor as T1
LEFT JOIN film_actor as T2 ON T1.actor_id = T2.actor_id 
GROUP BY first_name, last_name
ORDER BY films desc;

#Films rented by most profitable customer. You can use the customer table and payment
-- table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT CONCAT(first_name,' ', last_name) as Customer,
city as City,
country as Country,
COUNT(distinct rental_id) as Rentals
FROM rental
INNER JOIN customer ON customer.customer_id = rental.customer_id
INNER JOIN address ON customer.address_id= address.address_id
INNER JOIN city ON city.city_id=address.city_id
INNER JOIN country on country.country_id=city.country_id
GROUP BY
    rental.customer_id
order by Rentals DESC
limit 10;

#Get the client_id and the total_amount_spent of those clients who spent more 
-- than the average of the total_amount spent by each client.
