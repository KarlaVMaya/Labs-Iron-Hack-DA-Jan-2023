-- Lab | SQL Queries 9
-- Instructions
-- In this lab we will find the customers who were active in consecutive months of May and June. 
-- Follow the steps to complete the analysis.
use sakila;
#Create a table rentals_may to store the data from rental table with information for the month of May.
#Insert values in the table rentals_may using the table rental, 
#filtering values only for the month of May.

select*from rental;

drop table if exists rentals_may;
CREATE TABLE `rentals_may` (
`rental_id` INT(5),
`rental_date` DATETIME,
`inventory_id` MEDIUMINT,
`customer_id` SMALLINT,
`return_date` DATETIME,
`staff_id` TINYINT(3) UNSIGNED NOT NULL,
`last_update` TIMESTAMP,
CONSTRAINT PRIMARY KEY (`rental_id`) );

select*from rentals_may;

INSERT INTO rentals_may (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update FROM rental
WHERE rental_date like '2005-05%';

select*from rentals_may;


#Create a table rentals_june to store the data from rental table with information for the month of June.
#Insert values in the table rentals_june using the table rental, filtering values only for the month of June.

select* from rental;
drop table if exists rentals_june;
CREATE TABLE `rentals_june` (
`rental_id` INT(5),
`rental_date` DATETIME,
`inventory_id` MEDIUMINT,
`customer_id` SMALLINT,
`return_date` DATETIME,
`staff_id` TINYINT(3) UNSIGNED NOT NULL,
`last_update` TIMESTAMP,
CONSTRAINT PRIMARY KEY (`rental_id`) );

select*from rentals_june;

INSERT INTO rentals_june (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update FROM rental
WHERE rental_date like '2005-06%';

select*from rentals_june;

#Check the number of rentals for each customer for May.
select*from rentals_may;

SELECT customer.first_name,
customer.last_name,
a.total_rent_may
FROM customer
LEFT JOIN(
SELECT 
rentals_may.customer_id,
COUNT(rentals_may.customer_id) AS total_rent_may
FROM rentals_may
LEFT JOIN customer ON (rentals_may.customer_id=customer.customer_id)
GROUP BY 1)
AS a ON(customer.customer_id=a.customer_id)
ORDER BY a.total_rent_may DESC;

select count(*) as total_rent_may, rm.customer_id 
from rentals_may rm 
join customer c on rm.customer_id = c.customer_id
group by rm.customer_id
order by total_rent_may desc;

#Check the number of rentals for each customer for June.

SELECT customer.first_name,
customer.last_name,
a.total_rent_june
FROM customer
LEFT JOIN(
SELECT 
rentals_june.customer_id,
COUNT(rentals_june.customer_id) AS total_rent_june
FROM rentals_june
LEFT JOIN customer ON (rentals_june.customer_id=customer.customer_id)
GROUP BY 1) AS a ON(customer.customer_id=a.customer_id)
ORDER BY a.total_rent_june DESC;

#Create a Python connection with SQL database and retrieve the results of the last two queries (also mentioned below) as dataframes:
#Check the number of rentals for each customer for May
#Check the number of rentals for each customer for June
-- Hint: You can store the results from the two queries in two separate dataframes.
#Write a function that checks if customer borrowed more or less films in the month of June as compared to May.
-- Hint: For this part, you can create a join between the two dataframes created before, using the merge function available for pandas dataframes. Here is a link to the documentation for the merge function.
