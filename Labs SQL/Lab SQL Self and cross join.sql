-- Lab | SQL Self and cross join
-- In this lab, you will be using the Sakila database of movie rentals.
use sakila;
-- Instructions
#Get all pairs of actors that worked together

select a.first_name, a.last_name, f.title, fa.film_id 
from actor a 
cross join film_actor fa
on a.actor_id = fa.actor_id
join film f
on f.film_id=fa.film_id
group by a.first_name, f.title, a.last_name, fa.film_id;

select f.title as Title, fa.actor_id as id_actor, concat(a.first_name, ' ', a.last_name) as name, fa1.actor_id as id_actor1, concat(a1.first_name, ' ', a1.last_name) as name1 
from film_actor as fa
join film_actor as fa1 on fa.film_id=fa1.film_id and fa.actor_id < fa1.actor_id
join actor as a on a.actor_id=fa.actor_id
join actor as a1 on a1.actor_id=fa1.actor_id
join film as f on f.film_id=fa.film_id
join film as f1 on f1.film_id= fa1.film_id
order by Title asc;

#Get all pairs of customers that have rented the same film more than 3 times.

create temporary table tabla_1
select inventory.film_id, rental.customer_id, count(rental.rental_id) as Rentals
from rental
left join inventory on rental.inventory_id = inventory.inventory_id
group by customer_id, film_id
having Rentals >=3;

select * from tabla_1;

select film.title, tabla_1.customer_id, Rentals
from tabla_1
left join film on tabla_1.film_id = film.film_id;

#Get all possible pairs of actors and films.

select f.film_id, concat(first_name, ' ', last_name) as pairs
from actor a
join film_actor f on a.actor_id = f.actor_id
order by pairs;

select fa.actor_id, fc.category_id, count(*) as num_films
from film_actor fa join
     film_category fc
     on fa.film_id = fc.film_id
group by fa.actor_id, fc.category_id;





