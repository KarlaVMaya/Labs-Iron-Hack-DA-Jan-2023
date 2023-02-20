#Lab | SQL Advanced queries
#In this lab, you will be using the Sakila database of movie rentals.

#Instructions
-- List each pair of actors that have worked together.
-- For each film, list actor that has acted in more films.
use sakila;

select f.film_id, fa1.actor_id, fa2.actor_id, concat(a1.first_name," ", a1.last_name), concat(a2.first_name," ", a2.last_name)
from film f
join film_actor fa1
on f.film_id=fa1.film_id
    join actor a1
    on fa1.actor_id=a1.actor_id
    join film_actor fa2
    on f.film_id=fa2.film_id
    join actor a2
    on fa2.actor_id=a2.actor_id   
where f.film_id = 82;

