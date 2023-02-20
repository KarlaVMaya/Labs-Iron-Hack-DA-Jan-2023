#Lab | SQL Advanced queries
#In this lab, you will be using the Sakila database of movie rentals.

#Instructions
-- List each pair of actors that have worked together.
use sakila;

select f.film_id, fa1.actor_id, fa2.actor_id, concat(a1.first_name," ", a1.last_name) AS Actor_1, concat(a2.first_name," ", a2.last_name) AS Actor_2
from film f
join film_actor fa1
on f.film_id=fa1.film_id
    join actor a1
    on fa1.actor_id=a1.actor_id
    join film_actor fa2
    on f.film_id=fa2.film_id
    join actor a2
    on fa2.actor_id=a2.actor_id;


#2.For each film, list actor that has acted in more films.
SELECT T1.first_name, T1.last_name, count(*) as films
FROM sakila.actor as T1
LEFT JOIN film_actor as T2 ON T1.actor_id = T2.actor_id 
GROUP BY first_name, last_name
ORDER BY films desc
LIMIT 1;

