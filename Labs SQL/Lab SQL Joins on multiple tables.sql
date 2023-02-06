-- Lab | SQL Joins on multiple tables
-- In this lab, you will be using the Sakila database of movie rentals.
use sakila;

-- Instructions
#Write a query to display for each store its store ID, city, and country.
SELECT cc.store_id, cc.address, cc.city, country.country from country
JOIN (SELECT aa.store_id, aa.address, c.city, c.country_id FROM city c 
JOIN (SELECT s.store_id, a.address, a.city_id from store s 
JOIN address a ON s.address_id = a.address_id) aa 
ON (aa.city_id = c.city_id)) cc 
ON (cc.country_id = country.country_id);

#Write a query to display how much business, in dollars, each store brought in.
SELECT address, SUM(amount) as 'business' from payment p 
JOIN(SELECT address, rental_id FROM rental r 
JOIN(SELECT address, inventory_id FROM inventory i
JOIN (SELECT s.store_id as store_id, a.address FROM store s 
JOIN address a ON a.address_id = s.address_id) b
ON i.store_id = b.store_id) c 
ON c.inventory_id = r.inventory_id) d 
ON d.rental_id = p.rental_id 
GROUP BY address;

#What is the average running time of films by category?
select*from film;

SELECT category.name, round(AVG(length)) AS Average_running
FROM film JOIN film_category USING (film_id) 
JOIN category USING (category_id)
GROUP BY category.name
ORDER BY AVG(length) ASC;

#Which film categories are longest?

SELECT category.name, round(AVG(length)) AS Longest_movie
FROM film JOIN film_category USING (film_id) 
JOIN category USING (category_id)
GROUP BY category.name
ORDER BY AVG(length) DESC
LIMIT 1;

#Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(f.title) as rentals from film f 
JOIN 
(SELECT r.rental_id, i.film_id FROM rental r 
JOIN inventory i ON i.inventory_id = r.inventory_id) a
ON a.film_id = f.film_id 
GROUP BY f.title 
ORDER BY rentals DESC;

#List the top five genres in gross revenue in descending order.
SELECT cat.name as category, SUM(d.revenue) as Revenue from category cat 
JOIN (SELECT catf.category_id, c.revenue FROM film_category catf 
JOIN (SELECT i.film_id, b.revenue FROM inventory i 
JOIN (SELECT r.inventory_id, a.revenue from rental r 
JOIN (SELECT p.rental_id, p.amount as Revenue FROM payment p) a 
ON a.rental_id = r.rental_id) b
ON b.inventory_id = i.inventory_id) c
ON c.film_id = catf.film_id) d 
ON d.category_id = cat.category_id 
GROUP BY cat.name
ORDER BY revenue DESC
LIMIT 5;

#Is "Academy Dinosaur" available for rent from Store 1?

select film.film_id, film.title, store.store_id, inventory.inventory_id
from inventory 
join store using (store_id) 
join film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;
