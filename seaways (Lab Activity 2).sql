-- CREATING DATABASE -- 

CREATE DATABASE seaways
USE seaways

-- CREATING THE SCHEMA OF DATABASE -- 

CREATE TABLE SAILORS 
(SID INT,
SNAME VARCHAR(20),
RATING INT,
AGE REAL);

DESC sailors ;

CREATE TABLE BOATS(
BID INT,
BNAME VARCHAR(20), 
COLOR VARCHAR(10));

DESC boats;

CREATE TABLE RESERVES(
SID INT, 
BID INT, 
R_DAY DATE);

DESC reserves;

SHOW TABLES

-- INSERTING VALUES TO THE TABLE -- 

INSERT INTO sailors
VALUES 
(22,'Dustin',7,45),
(29,'Brutus',1,33),
(31,'Lubber',8,55.5),
(32,'Andy',  8,25.5),
(58,'Rusty', 10,35),
(64,'Horataio',7,35),
(71,'Zorba', 10,16),
(74,'Horataio',9,35),
(85,'Art',3,25.5),
(95,'Bob',3,63.5);

SELECT * FROM sailors;


INSERT INTO reserves 
VALUES 
(22,101,'2015-10-10'),
(22,102,'2015-10-10'),                                                
(22,103,'2015-10-08'),                                             
(22,104,'2015-10-07'),                                              
(31,102,'2015-11-10'),                                                 
(31,103,'2015-11-06'),                                               
(31,104,'2015-11-12'),                                               
(64,101,'2015-9-05'),                                              
(64,102,'2015-9-08'),                                           
(74,103,'2015-9-08');

SELECT * FROM reserves;

INSERT INTO boats
VALUES 
(101,'Interlake','blue'),
(102,'Interlake','red'),
(103,'Clipper','green'),
(104,'Marine','red');

SELECT * FROM boats;

-- Questions --

-- 1. Display names & ages of all sailors.

SELECT sname,age FROM sailors;

-- 2. Find all sailors with a rating above 7.

SELECT sid,sname FROM sailors 
WHERE rating >= 7;

-- 3. Display all the names & colors of the boats

SELECT bname,color FROM boats

-- 4. Find all the boats with Red color.

SELECT * FROM boats 
WHERE color = 'red';

-- 5. Find the names of sailors who have reserved boat number 123.

SELECT s.sname FROM sailors s,reserves r
WHERE s.sid = r.sid AND r.bid = 103;
 
-- 6. Find SIDs of sailors who have reserved Pink Boat;

SELECT s.sid FROM sailors s,reserves r, boats b
WHERE s.sid = r.sid AND r.bid = b.bid AND b.color = 'pink';

-- 7. Find the color of the boats reserved by Rajesh.

SELECT DISTINCT b.color FROM boats b, sailors s,reserves r
WHERE s.sid = r.sid AND r.bid = b.bid AND sname  = 'Lubber';

-- 8. Find names of the sailors who have reserved at least one boat.

SELECT DISTINCT s.sname FROM sailors s, reserves r WHERE s.sid = r.sid;

-- 9. Find the names of sailors who have reserved a red or a green boat.

SELECT DISTINCT s.sname FROM sailors s,reserves r, boats b
WHERE s.sid = r.sid AND r.bid = b.bid AND b.color = 'red' OR b.color = 'green';

-- 10. Find the names of sailors who have reserved boat 103.

SELECT DISTINCT s.sname FROM sailors s,reserves r
WHERE s.sid = r.sid AND r.bid = 103;

-- 11. Find the names of sailors who have not reserved boat 103.

SELECT DISTINCT s.sname FROM sailors s,reserves r
WHERE s.sid = r.sid  AND r.bid != 103;

-- 12. Find sailors whose rating is better than some sailor called Dustin.

SELECT * FROM sailors 
WHERE rating > (SELECT rating FROM sailors WHERE sname LIKE 'Dustin')

-- 13. Find the sailor's with the highest rating using ALL.

SELECT sid, sname
FROM sailors s1
WHERE s1.rating >= ALL (SELECT rating FROM sailors) 

-- 14. To count number SIDs of sailors in Sailors table

SELECT LENGTH(sid) , sid FROM sailors;


-- 15. To count numbers of boats booked in Reserves table.

SELECT COUNT(bid) FROM reserves;

-- 16. To count number of Boats in Boats table.

SELECT COUNT(bid) FROM boats;

-- 17. To find age of Oldest Sailor.

SELECT MAX(age) FROM sailors ;

-- 18. To find age of Youngest Sailor.

SELECT MIN(age) FROM sailors ;

-- 19. Find the average age of sailors with a rating of 10.

SELECT AVG(age) FROM sailors ;

-- 20. Count the number of different sailor names.

SELECT COUNT(DISTINCT sname) FROM sailors ;

-- 21. Find the name and age of the oldest sailor.

SELECT sname, age FROM sailors WHERE age = (SELECT MAX(age) FROM sailors );

-- 22. Count the number of Sailors.

SELECT COUNT(sid) FROM sailors;

-- 23. Find the names of sailors who are older than the oldest sailor with a rating of 10.

SELECT sname FROM sailors 
WHERE age > (SELECT MAX(age) FROM sailors WHERE rating = 10); 

-- 24. Display all the sailors according to their age

SELECT * FROM sailors ORDER BY age;  

-- 25. To display names of sailors according to alphabetical order.

SELECT sname FROM sailors GROUP BY sname ASC 