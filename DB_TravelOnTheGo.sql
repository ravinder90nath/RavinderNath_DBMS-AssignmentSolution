create database if not exists DB_TravelOnTheGo;

use DB_TravelOnTheGo;

/*Passenger table and insert data*/
create table if not exists PASSENGER(
passenger_name varchar(100),
cateogry varchar(15),
gender varchar(15),
boarding_city varchar(100),
destination_city varchar(100),
distance int,
bus_type varchar(15)
);

insert into  Passenger values
("Sejal","AC","F","Bengaluru","Chennai",350,"Sleeper"),
("Anmol","Non-AC","M","Mumbai","Hyderabad",700,"Sitting"),
("Pallavi","AC","F","Panaji","Bengaluru",600,"Sleeper"),
("Khusboo","AC","F","Chennai","Mumbai",1500,"Sleeper"),
("Udit","Non-AC","M","Trivandrum","panaji",1000,"Sleeper"),
("Ankur","AC","M","Nagpur","Hyderabad",500,"Sitting"),
("Hemant","Non-AC","M","panaji","Mumbai","700","Sleeper"),
("Manish","Non-AC","M","Hyderabad","Bengaluru",500,"Sitting"),
("Piyush","AC","M","Pune","Nagpur",700,"Sitting");

/*Price  table and insert data*/
create table if not exists Price (
 Bus_Type varchar(15),
 Distance int,
 Price int
 );
 
 insert into Price values 
('Sleeper', 350, 770  ),
('Sleeper', 500 ,1100 ),
('Sleeper', 600 ,1320 ),
('Sleeper', 700 ,1540 ),
('Sleeper', 1000 ,2200),
('Sleeper', 1200 ,2640),
('Sleeper', 1500 ,2700),
('Sitting', 500 ,620  ),
('Sitting', 600 ,744  ),
('Sitting', 700 ,868  ),
('Sitting', 1000 ,1240),
('Sitting', 1500 ,1860),
('Sitting', 1200 ,1488);

/*Select Query*/
Select * from Passenger;
Select * from Price;

/* 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s? */
select Gender,count(*) from Passenger where distance >=600 group by Gender;

/* 4) Find the minimum ticket price for Sleeper Bus */
select min(price) from price where bus_type="Sleeper";

/* 5) Select passenger names whose names start with character 'S' */
select passenger_name from passenger where passenger_name like 'S%';

/* 6) Calculate price charged for each passenger 
displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output */
select pa.passenger_name as 'Passenger Name', pa.boarding_city as 'Boarding City', 
pa.destination_city as 'Destination City', pa.bus_type as 'Bus type', pr.price as 'Price'
from passenger pa
left join price pr on pa.bus_type = pr.bus_type and pa.distance = pr.distance;


/* 7) What are the passenger name/s and his/her ticket price
 who travelled in the Sitting bus for a distance of 1000 KM s */
 
select pa.passenger_name as 'Passenger Name', pa.boarding_city as 'Boarding City', 
pa.destination_city as 'Destination City', pa.bus_type as 'Bus type', pr.price as 'Price'
from passenger pa
left join price pr on pa.bus_type = pr.bus_type and pa.distance = pr.distance
where pa.bus_type = 'Sitting' and pa.distance = 1000;

/* 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? */

select bus_type as 'Bus Type', price as 'Price' from price where distance = (
select distance from passenger 
where (boarding_city = 'Panaji' and destination_city = 'Bengaluru')
or (boarding_city = 'Bengaluru' and destination_city = 'Panaji')) ;


/* 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. */

select distinct distance from passenger order by distance desc;

/* 10) Display the passenger name and percentage of distance travelled
 by that passenger from the total distance travelled by all passengers without using user variables */
 
SELECT passenger_name as 'Passenger Name', distance * 100 / pr.total as '% Distance Travelled'
FROM passenger
CROSS JOIN (SELECT SUM(distance) AS total FROM passenger) pr;

/*
11) Display the distance, price in three categories in table Price 
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/

select bus_type, distance, price,
case  
	when price>1000 then 'Expensive'
    when price>500 then 'Average Cost'
    else 'Cheap'
end category
from price;