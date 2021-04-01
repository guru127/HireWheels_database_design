
USE HireWheels;
----------
-- PART A--
 ----------
INSERT INTO city (city_name)
  VALUE('Delhi'),('Kolkata'); 

SELECT * FROM location;

INSERT INTO location (location_name, address, city_id, pincode)
 VALUES
 ('Banglore railway station',' Kempegowda, Sevashrama, Bengaluru', 1, '560023'),
 ('New Delhi Railway station','Bhavbhuti Marg, Ratan Lal Market, Kamla Market, Ajmeri Gate', 6, '110006');
 
-- finding city in which bookings are happened
 
SELECT a.city_name,  
 count(location_id IN (SELECT location_id FROM booking))
  FROM city a
  INNER JOIN location b
  ON a.city_id = b.location_id
  GROUP BY city_name;

-- finding user_id and booking made by user id 
SELECT a.user_id,  count(b.user_id )
  FROM user a 
  INNER JOIN booking b
  ON a.user_id = b.user_id
  GROUP BY user_id 
  ORDER BY  count(b.user_id ) DESC;

DESC user_role;
 
 INSERT INTO user_role(role_name) VALUE ('Employee');
 
-- joining user and role by left join
SELECT a.first_name, last_name, b.role_name 
 FROM user a 
 LEFT JOIN user_role b 
 ON a.user_type_id=b.role_id;

-- inserting new records into booking 
INSERT INTO booking (pickup_date, drop_off_date, booking_date, amount, location_id, vehical_id, user_id)
 VALUES
 ('21-05-20','29-05-20','25-05-20',3000.00, 3, 4, 2),
 ( '21-04-20','29-04-20','10-04-20',2000.00, 5, 3, 3),
 ( '11-04-20','20-04-20','10-04-20',1000.00, 2, 5, 1),
 ( '21-07-20','29-07-20','10-07-20',3000.00, 5, 2, 3),
 ( '11-07-20','20-07-20','10-07-20',5000.00, 6, 2, 3),
 ( '11-08-20','23-08-20','10-08-20',5000.00, 1, 1, 1);
 
/* Slecting months in 2020 which ahve bookings 
   and calculating the  % icrease with respect to previous months which has booking
*/
select  EXTRACT(MONTH FROM booking_date) as month, 
 (((select count(bookin_id) from booking
 where EXTRACT(MONTH FROM booking_date)-1)-count(bookin_id))/count(bookin_id) )*100 as 'progress in %'
 from booking where booking_date  like '2020%'
 group by EXTRACT(MONTH FROM booking_date)
 ORDER BY booking_date asc;
/*
sleecting number of bookings made in a month of 2020 which have booking amount 
greater than average booking anount of that month
*/

SELECT EXTRACT(MONTH FROM booking_date) as month, count(bookin_id)    
FROM booking b
WHERE    amount > (SELECT AVG(amount) FROM booking 
 WHERE EXTRACT(MONTH FROM booking_date) = EXTRACT(MONTH FROM b.booking_date))
 AND booking_date LIKE '2020%'
 GROUP BY EXTRACT(MONTH FROM booking_date) 
 ORDER BY booking_date asc;
 
 -- Calcutating total revenue from vehical type car
 SELECT sum(amount) as 'Revenue by Car' FROM booking 
 WHERE vehical_id IN (SELECT vehical_id FROM vehical
 WHERE vehical_subcategory_id IN ( SELECT vehical_subcategory_id FROM vehical_subcategory 
 WHERE vehical_category_id IN ( SELECT vehical_type_id FROM vehical_category 
 WHERE vehical_type_name='car')));



----------
--  PART G--
----------
/*
creating an index from user table  with first name and last name columns
*/ 
 CREATE INDEX users_name_index
ON user ( first_name ,last_name);

----------
--  PART H--
----------
-- creating a view from booking and vehical and vehical category tables

CREATE OR REPLACE VIEW booking_view AS
SELECT  booking.booking_date,
 booking.amount,
 vehical.vehical_model, 
 Vehical_category.vehical_type_name,
 vehical_subcategory.vehical_sucategory_name
 FROM  vehical 
 INNER JOIN booking ON (vehical.vehical_id = booking.vehical_id)
 INNER JOIN vehical_subcategory ON (vehical.vehical_subcategory_id= vehical_subcategory.vehical_sucategory_id)
 INNER JOIN vehical_category ON (vehical_subcategory.vehical_sucategory_id= vehical_category.vehical_type_id);
select * from booking_view;

----------
 -- PART I--
----------
-- creting user role view
CREATE OR REPLACE VIEW user_role_view AS
SELECT * 
FROM user  
INNER JOIN user_role ON user.user_type_id= user_role.role_id;
select * from user_role_view;
