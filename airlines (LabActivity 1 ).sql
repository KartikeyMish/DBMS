/*
Consider the following relations containing airline flight information:

•  Flights (flno: integer, from: string, to: string, distance: integer, departs: time, arrives: time)
•  Aircraft (aid: integer, aname: string, cruisingrange: integer)
•  Certified (eid: integer, aid: integer)
•  Employees (eid: integer, ename: string, salary: integer)

Note that the Employees relation describes pilots and other kinds of employees as well every pilot is certified for some aircraft (otherwise, he or she would not qualify as a pilot), and only pilots are certified to fly.

Write the following queries in SQL
1. Find the eids of pilots certified for some Boeing aircraft.
2. Find the names of pilots certified for some Boeing aircraft.
3. Find the aids of all aircraft that can be used on non-stop flights from Bonn to Madras.
4. Identify the flights that can be piloted by every pilot whose salary is more than $100,000.
5. Find the names of pilots who can operate planes with a range greater than 3,000 miles but are not certified on any Boeing aircraft.


*/
-- CREATING DATABASE -- 

CREATE DATABASE airlines
USE airlines

-- CREATING THE SCHEMA OF DATABASE -- 

CREATE TABLE Flight(
    flno INT,
    frm VARCHAR(20),
    too VARCHAR(20),
    distance INT,
    departs TIME,
    arrives TIME,
    PRIMARY KEY (flno));
    
DESC Flight;


CREATE TABLE Aircraft(
aid INT PRIMARY KEY , 
aname VARCHAR(20), 
cruisingrange INT);

DESC Aircraft;

CREATE TABLE Certified(
eid INT, 
aid INT,
PRIMARY KEY (eid,aid),
FOREIGN KEY (eid) REFERENCES Employees (eid),
FOREIGN KEY (aid) REFERENCES Aircraft (aid));

DESC Certified;

CREATE TABLE Employees(
eid INT PRIMARY KEY, 
ename VARCHAR(20), 
salary INT);

DESC Employees;

-- INSERTING VALUES TO THE TABLE -- 

INSERT INTO Flight VALUES 
(1,'Mumbai','Kolkata',1194,'10:45:00','13:00:00'),
(2,'USA','Delhi',7490,'12:15:00','05:30:00'),
(3,'London','Mumbai',4466,'02:15:00','15:25:00'),
(4,'Delhi','Mumbai',877,'10:15:00','12:05:00'),
(5,'Madras','Delhi',1756,'07:15:00','09:00:00'),
(6,'Madras','Bonn',5123,'10:00:00','03:45:00'),
(7,'Madras','Bonn',4789,'12:00:00','02:30:00');

SELECT * FROM Flight;

INSERT INTO Aircraft VALUES 
(123,'Airbus',1000),
(302,'Boeing',5000),
(306,'Jet01',5000),
(378,'Airbus380',8000),
(456,'Aircraft',500),
(789,'Aircraft02',800),
(951,'Aircraft03',1000);

SELECT * FROM Aircraft;


INSERT INTO Employees VALUES
(1,'Vineet',130000),
(2,'Aman',85000),
(3,'Ashneer',87000),
(4,'Anupam',110000),
(5,'Ranvijay',90000),
(6,'Ghazal',135000),
(7,'Piyush',150000);

SELECT * FROM Employees;

INSERT INTO Certified VALUES 
(1,123),(2,123),(1,302),(5,302),
(7,302),(1,306),(2,306),(1,378),
(2,378),(4,378),(6,456),(3,456),
(5,789),(6,789),(3,951),(1,951),(1,789);

SELECT * FROM Certified;


-- QUESTIONS --

-- 1. Find the eids of pilots certified for some Boeing aircraft.   

SELECT DISTINCT E.eid
FROM Employees E, Certified C, Aircraft A
WHERE E.eid = C.eid AND C.aid = A.aid AND A.aname='Boeing';

-- 2. Find the names of pilots certified for some Boeing aircraft. 

SELECT DISTINCT E.ename
FROM Employees E, Certified C, Aircraft A
WHERE E.eid = C.eid AND C.aid = A.aid AND A.aname = 'Boeing'

 -- 3. Find the aids of all aircraft that can be used on non-stop flights
 -- from Bonn to Madras. 
 
SELECT A.aid FROM Aircraft A 
WHERE A.cruisingrange > 
(SELECT MIN(F.distance) FROM Flight F
WHERE F.frm='Madras'
AND F.too='Bonn');

-- 4. Identify the flights that can be piloted by every pilot whose salary 
-- is more than $100,000 

SELECT DISTINCT flno
FROM Aircraft A, Certified C, Employees E, Flight F
WHERE A.aid = C.aid AND E.eid = C.eid AND 
distance < cruisingrange AND salary > 100000


-- 5. Find the names of pilots who can operate planes with a range greater 
-- than 3,000 miles but are not certified on any Boeing aircraft. --

SELECT E.ename
FROM Certified C, Employees E, Aircraft A
WHERE A.aid = C.aid AND E.eid = C.eid AND A.cruisingrange > 3000
AND E.eid NOT IN ( SELECT C2.eid
FROM Certified C2, Aircraft A2
WHERE C2.aid = A2.aid AND A2.aname = 'Boeing' )