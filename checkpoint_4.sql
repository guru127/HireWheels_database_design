/**
ToDo 1:
Add all the necessary constraints to each attribute of the tables.
**/
--  i have already updated all contraints while creating tables itself 

create database HireWheels;
use HireWheels;
-- user role table creation and data insertion
create table user_role(
role_id NUMERIC(10) primary key,
role_name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO user_role 
values( 1, 'Customer'),
      (2, 'Admin');
      
alter table user_role
modify role_id int auto_increment;
-- user table creation and data inserion10:12:28	
 
create table user( 
user_id numeric(10) primary key,
first_name varchar(50) not null,
last_name varchar(50) ,
password varchar(10) not null check(length(password)>5),
email_id varchar(50) not null unique,
mobile_number char(10) not null unique,
wallet numeric(10, 2)  default 10000,
user_type_id int 
);

--  adding foreign kry contraints to user table
alter table user 
add foreign key(user_type_id) references user_role(role_id);

-- setting user id to auto increment so that we get unique user id for new user every time  
ALTER TABLE user
MODIFY user_id INT AUTO_INCREMENT;

-- inserting data intto user table
insert into user
 (first_name ,last_name,password ,email_id ,mobile_number ,wallet,user_type_id )
 values('guru','n','123456','guru.com','0000000001',default, 1),
	   ('charan','n','123456','charan.com','0000000002',default, 2),
       ('gurucharan','n','123456','gurucharan.com','0000000003',default, 1),
	   ('charanguru','n','123456','charanguru.com','0000000004',default, 2);

-- creating vehical_category table
create table vehical_category(
vehical_type_id numeric(10) primary key,
vehical_type_name varchar(50) not null unique
);

desc vehical_category;
select * from vehical_category;
insert into vehical_category values(1, 'car'),(2,'bike');

create table vehical_subcategory(
vehical_sucategory_id numeric(10) primary key,
vehical_category_id	NUMERIC(10)	NOT NULL, 
vehical_sucategory_name	VARCHAR(50)	NOT NULL  UNIQUE,
price_per_day	NUMERIC(10, 2)	NOT NULL
);

-- adding foreign kry contraints to vehical subcattegory table
alter table vehical_subcategory
  add foreign key (vehical_category_id)
  references vehical_category(vehical_type_id);
 
insert into vehical_subcategory values
(1, 1,'Hatchback',1000 ),
(2, 1,'Sedan', 1500),
(3, 1,'SUV', 2000),
(4, 2,'Dirt bike', 500),
(5, 2,'Cruiser', 800),
(6, 2,'Sports bike', 1000);

select * from vehical_subcategory;

-- creating a table for fuel types
create table fuel_type(
fuel_type_id	NUMERIC(10)	PRIMARY KEY,
fuel_type	VARCHAR(500)	NOT NULL      UNIQUE
);
insert into fuel_type values
(1, 'CNG'),
(2,'Petrol'),
(3,'Diesel');
select * from fuel_type;

-- creating city table and insrting data
create table city (
city_id	NUMERIC(10)	PRIMARY KEY,
city_name	VARCHAR(50)	NOT NULL      UNIQUE
);
ALTER TABLE city
MODIFY city_id INT AUTO_INCREMENT;

insert into city values
(1, 'Banglore'),
(2,'hyderabad'),
(3,'chennai'),
(4,'mumbai');

select * from city;	

-- creating  location table
CREATE TABLE  location(
location_id	NUMERIC(10)	PRIMARY KEY,
location_name	VARCHAR(50)	NOT NULL,
address	VARCHAR(100)	NOT NULL,
city_id	integer	NOT NULL    ,
pincode	CHAR(6)	NOT NULL
);

-- adding foreign key contraints to location table
alter table location
  add foreign key (city_id)
  references city(city_id);
  
  ALTER TABLE location
MODIFY location_id INT AUTO_INCREMENT;

  
insert into location values
  (1, 'mejestic', 'mejestic, main road',1, '001001'),
  (2, 'whitefield',' whitefied, main road',1, '001002'),
  (3, 'charminar', 'charminar, main road',2, '002001'),
  (4, 'salem', 'salem, main road',3, '003001'),
  (5, 'andheri','andheri, main road',4, '004001');
  
  select * from location;
  
  -- creating vehical table 
create table vehical(
vehical_id	NUMERIC(10)	PRIMARY KEY,
vehical_model	VARCHAR(50)	NOT NULL,
vehical_number	VARCHAR(50)	NOT NULL,
vehical_subcategory_id	NUMERIC(10)	, 
fuel_type_id	NUMERIC(10)	NOT NULL ,  
colour	VARCHAR(50)	NOT NULL,
location_id	integer	NOT NULL    ,  
availability_status	 boolean NOT NULL,
vehical_image_url	VARCHAR(500)	NOT NULL
);
desc vehical;
insert into vehical values
(1, 'creta', 'ka-10 001',  3 ,  2, 'black', 1,  1, 'https/iamage.car1'),
(2, 'nexan', 'hy-11 007',  1 ,  3, 'blue',  2,  1, 'https/iamage.car2'),
(3, 'swift', 'ka-10 001',  2 ,  3, 'red',   3,  1, 'https/iamage.car3'),
(4, 'meteor', 'ka-15 001', 5 ,  2, 'grey',  1,  1, 'https/iamage.car3');
select * from vehical;
alter table vehical
  add foreign key (location_id)
  references location(location_id);
  
  alter table vehical
  add foreign key (fuel_type_id)
  references fuel_type(fuel_type_id);
  
alter table vehical
  add foreign key (vehical_subcategory_id)
  references vehical_subcategory(vehical_sucategory_id);
  
  alter table vehical 
  modify vehical_id int  AUTO_INCREMENT;
  

create table booking( 
bookin_id	NUMERIC(10)	PRIMARY KEY,
pickup_date  	DATE	NOT NULL,
drop_off_date	DATE	NOT NULL,
booking_date	DATE	NOT NULL,
amount	NUMERIC(10, 2)	NOT NULL,
location_id	NUMERIC(10)	NOT NULL ,  
vehical_id	NUMERIC(10)	NOT NULL, 
user_id	NUMERIC(10)	NOT NULL   
);

alter table booking 
  add foreign key (location_id)
  references location(location_id);
  
  alter table booking 
  add foreign key (vehical_id)
  references vehical(vehical_id);
  
  alter table booking 
  add foreign key (user_id)
  references user(user_id);
-- setting  booking id to suto increment so that it givs unique id for every booking
ALTER TABLE booking 
MODIFY bookin_id INT AUTO_INCREMENT;
  
desc booking;
 
insert into booking values
(1,'2020-02-01',' 2020-02-02', '2020-02-01', 2000 , 1, 1,  1 ),
(2, '2020-02-03', '2020-02-04', '2020-02-02', 1000 , 2, 4,  3 );

select * from booking;
