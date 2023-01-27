USE sakila;
# 1. Select all the actors with the first name ‘Scarlett’.
SELECT first_name from actor where first_name= 'Scarlett';
# 2. How many films (movies) are available for rent?
#15861
SELECT * FROM rental;
SELECT count(inventory_id) from rental as available where return_date is not null;

# 2. How many films have been rented?
#183
SELECT count(inventory_id) from rental as rented where return_date is null;

# 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT max(length) as max_duration FROM film;
SELECT min(length) as min_duration FROM film;

# 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT FLOOR(AVG(length)) from film;

# 5. How many distinct (different) actors' last names are there?
SELECT count(distinct(last_name)) from actor;

# 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT * FROM address;
SELECT DATEDIFF("2014-09-25", "2006-02-15");

# 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT rental_date, date_format(rental_date, "%M") as Month,
 date_format(rental_date, "%W") as Weekday from rental
 limit 20;

# 8. Add an additional column day_type with values 'weekend' and 'workday' depending 
# on the rental day of the week.
select rental_date,
case
when date_format(rental_date, "%w") in (1,2,3,4,5) then "Weekday"
else "Weekend"
end as day_type
from sakila.rental; 

# 9. How many rentals were in the last month of activity

select * from rental order by rental_date desc limit 1; #Ordenar de forma descendiente

select count(rental_id) from rental 
where date_format(rental_date, '%m') = 2;

