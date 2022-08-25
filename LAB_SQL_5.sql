use sakila;

-- 1. Drop column picture from staff.
select * from staff;
alter table staff drop column picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from staff;
SET FOREIGN_KEY_CHECKS = 0; -- To disable safe mode
insert into staff values (3, 'Tammy', 'Sanders', 5, 'tammysanders@sakilastaff.com', 3, 1, 'Tammy', '8asdfg22668547ghjkdeghjwd', '2006-02-15 03:57:16');

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information.
--  For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
select * from rental;

select customer_id from sakila.customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- I'll get customer_id (=130)
select film_id from sakila.film where title = 'ACADEMY DINOSAUR'; -- I'll get the film_id (=1)
select inventory_id from inventory where film_id = 1; -- I'll get the inventory_id (=1,2,3,4,5,6,7,8)
select staff_id from staff where first_name = 'Mike' and last_name='Hillyer'; -- I'll get the staff_id (=1)

INSERT INTO RENTAL VALUES (16050, '2022-08-22 12:09:45', 7, 130, '2022-08-25 12:09:45', 1, '2022-08-25 12:09:45');

-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted.
-- Follow these steps: 
		-- Check if there are any non-active users
select * from customer;
select * from customer where active = 0; -- there are 15 non-active users

        -- Create a table backup table as suggested
create table deleted_users(
Customer_id int unique not null, -- our primary key
email  text default null,
delete_date int default null,
CONSTRAINT PRIMARY KEY (Customer_id)
);

        -- Insert the non active users in the table backup table
INSERT INTO deleted_users VALUES
(16,'SANDRA.MARTIN@sakilacustomer.org', 220825),
(64, 'JUDITH.COX@sakilacustomer.org', 220825),
(124,'SHEILA.WELLS@sakilacustomer.org', 220825),
(169,'ERICA.MATTHEWS@sakilacustomer.org', 220825),
(241, 'HEIDI.LARSON@sakilacustomer.org', 220825),
(271, 'PENNY.NEAL@sakilacustomer.org', 220825),
(315, 'KENNETH.GOODEN@sakilacustomer.org', 220825),
(268, 'HARRY.ARCE@sakilacustomer.org', 220825),
(406, 'NATHAN.RUNYON@sakilacustomer.org', 220825),
(446, 'THEODORE.CULP@sakilacustomer.org', 220825),
(482, 'MAURICE.CRAWLEY@sakilacustomer.org', 220825),
(510, 'BEN.EASTER@sakilacustomer.org', 220825),
(534, 'CHRISTIAN.JUNG@sakilacustomer.org', 220825),
(558, 'JIMMIE.EGGLESTON@sakilacustomer.org', 220825),
(592, 'TERRANCE.ROUSH@sakilacustomer.org', 220825);
select * from deleted_users;

        -- Delete the non active users from the table customer
select * from customer;
SET SQL_SAFE_UPDATES = 0; -- To disable safe mode
DELETE FROM customer WHERE active = 0;