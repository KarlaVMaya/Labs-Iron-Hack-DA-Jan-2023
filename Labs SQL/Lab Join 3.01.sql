-- Lab | SQL Join
-- In this lab, you will be using the Sakila database of movie rentals.
-- The database is structured as follows:
use sakila;
-- Instructions
#List the number of films per category.
-- categories= G, PG, PG-13, R, or NC-17.
SELECT
COUNT(category.category_id) as Number_of_films,
category.name
FROM film_category
LEFT JOIN category ON (film_category.category_id=category.category_id)
GROUP BY category.name;

#Display the first and the last names, as well as the address, of each staff member.
DROP TEMPORARY TABLE IF EXISTS Info_staff;
CREATE TEMPORARY TABLE Info_staff
SELECT st.first_name, st.last_name, ad.address #Nota, aquí solo debo llamar a la dirección para que aparezca en la tabla y no el address ID
FROM staff st INNER JOIN address ad 
ON st.address_id = ad.address_id;
SELECT*FROM Info_staff;

#Display the total amount rung up by each staff member in August 2005.

SELECT st.first_name, st.last_name, sum(p.amount) as amount_staff
FROM staff st JOIN payment p 
ON st.staff_id = p.staff_id
GROUP BY p.staff_id
ORDER BY last_name ASC;

#List all films and the number of actors who are listed for each film.

SELECT fl.title, count(fla.actor_id) as number_of_actors
FROM film fl JOIN film_actor fla
ON fl.film_id = fla.film_id
GROUP BY fla.film_id
ORDER BY fl.title;

#Using the payment and the customer tables as well as the JOIN command, list the total amount 
#paid by each customer. List the customers alphabetically by their last names.

SELECT c.last_name, sum(p.amount) as total_amount
FROM payment p JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY c.last_name;