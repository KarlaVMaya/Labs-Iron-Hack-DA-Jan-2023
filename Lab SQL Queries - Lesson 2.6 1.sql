#Lab SQL Queries - Lesson 2.6	
use sakila;
    
# 1. Get release years.
select release_year from film;

# 2. Get all films with ARMAGEDDON in the title.
select title from film;
select * from film
where title like '%ARMAGEDDON%'; # " % " LO QUE SEA QUE CONTENGA LA PALABRA   

# 3. Get all films which title ends with APOLLO. # " % " LO QUE SEA QUE CONTENGA LA PALABRA SOLO DEL LADO IZQUIERDO, ANTES DE LA PALABRA
select * from film where title like '%APOLLO';

# 4. Get 10 the longest films.
select * from film order by length desc limit 10;

# 5. How many films include Behind the Scenes content?
#1000
select * from film;
select count(special_features like '%Behind the Scenes%') from film;


# 6. Drop column picture from staff.
select * from staff;
alter table staff
drop column picture;

 select * from staff;
 
# 7. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select*from sakila customer;
select*from sakila.staff;
insert into staff values (3,'TAMMY', 'SANDERS',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'tammy','null','2023-01-31');
select*from sakila.staff;

# 8.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
#You can use current date for the rental_date column in the rental table. 
#Hint: Check the columns in the table rental and see what information you would need to add there. 
#You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
select*from rental;

select max(rental_id) from rental;

select customer_id from sakila.customer 
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

insert into rental values (16050,'2023-01-25 18:55:14',1, 130,'2023-01-31 14:55:21', 1, '2023-01-25 18:55:14');
select*from rental;

# Use similar method to get inventory_id, film_id, and staff_id.

# 9. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, 
#and the date for the users that would be deleted. Follow these steps:
	#Check if there are any non-active users
	#Create a table backup table as suggested
	#Insert the non active users in the table backup table
	#Delete the non active users from the table customer
    
select*from customer;

select*from customer where active='0';

CREATE TEMPORARY TABLE sakila.non_active_users
select*from customer where active='0';

-- Para ver los tipos de datos se selecciona el botoncito de llave que aparece en casa tabla en SCHEMAS

use sakila;
CREATE TABLE non_active_users (
  `customer_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar (50) DEFAULT NULL,
  `delete_date` date,
  CONSTRAINT PRIMARY KEY (customer_id)  -- constraint keyword is optional but its a good practice
);

delete from non_active_users ;

select * from non_active_users ;

show variables like 'local_infile';
set global local_infile=1;

load data local infile '/Users/karla/Documents/DOCS IRONHACK/2.06/non_active1.csv'
into table non_active_users 
fields terminated by ',';

select * from non_active_users ;

select*from customer where active='0';
DELETE FROM customer WHERE active=0;

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`payment`, CONSTRAINT `fk_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE)
-- Se debe desactivar el modo seguro y aplicar lo siguiente:
SET FOREIGN_KEY_CHECKS=0; -- option specifies wheter or not to check foreign key constraints for InnoDB tables, si queremos activarlas le damos 1

select*from customer where active='0';