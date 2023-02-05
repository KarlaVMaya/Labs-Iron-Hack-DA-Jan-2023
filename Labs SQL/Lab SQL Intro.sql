# 1. Use sakila database.  
SHOW DATABASES;
USE sakila;
# 2. Get all the data from tables actor, film and customer.
SHOW TABLES;
SELECT * FROM sakila.actor, sakila.film, sakila.customer;

# 3. Get film titles.
SELECT title FROM sakila.film;

# 4. Get unique list of film languages under the alias language.
SELECT name from sakila.language;

#5
# 5.1 Find out how many stores does the company have?
SELECT store_id from sakila.store;
#They have two stores

# 5.2 Find out how many employees staff does the company have?
SELECT staff_id from sakila.staff;

# 5.3 Return a list of employee first names only?
select first_name from sakila.staff;







