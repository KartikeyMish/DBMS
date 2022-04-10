-- CREATING DATABASE -- 

CREATE fur_company ;
USE fur_company;

-- CREATING THE SCHEMA OF DATABASE -- 

CREATE TABLE furniture (
Idfurniture INT NOT NULL PRIMARY KEY,
`Type` VARCHAR(20),
category VARCHAR(20),
material VARCHAR(20));

DESC furniture;

CREATE TABLE `time`(
IdTime INT NOT NULL PRIMARY KEY,
`Day` INT ,
`Month` INT,
`Year` INT); 

DESC `time`;

CREATE TABLE customer (
IdCustomer INT NOT NULL PRIMARY KEY,
`name` VARCHAR(20),
age FLOAT,
sex VARCHAR(10),
city VARCHAR(20),
region VARCHAR(20),
state VARCHAR(20));

DESC customer;

CREATE TABLE sales (
Idfurniture INT NOT NULL,
IdCustomer INT NOT NULL,
IdTime INT NOT NULL,
Quantity INT,
Income FLOAT ,
Discount FLOAT,
FOREIGN KEY(Idfurniture)REFERENCES furniture(Idfurniture),
FOREIGN KEY(IdCustomer)REFERENCES customer(IdCustomer),
FOREIGN KEY(IdTime)REFERENCES `time`(IdTime),
PRIMARY KEY(IdFurniture,IdCustomer,IdTime));

DESC sales;

SHOW TABLES ;

-- INSERING THE VALUES TO THE DATABASE --
 
INSERT INTO customer VALUES 
(1,'Robin',23,'male','Tokyo','Kantō', 'Japan'),
(2,'Raju',27,'male','Shanghai','East China', 'China'),
(3,'Naura',26,'female','Mumbai','Maharashtra','India'),
(4,'Shantanu',30,'male','Miami','Florida', 'United States'),
(5,'Aisha',29,'female','Los Angeles','California', 'United States'),
(6,'Aditya',21,'male','London','England', 'United Kingdom'),
(7,'Deepika',25,'female','Banglore','Karnataka', 'India');

SELECT * FROM customer;

INSERT INTO furniture VALUES
(101,'sofas','couche','leather'),
(102,'chairs','desk chair','chenille fabric'),
(103,'sleeper sofas','pull out','microfibers'),
(104,'recliners','lay flat','cotton'),
(105,'benches','garden','Woods'),
(106,'coffee tables','Oval','Glass & wood');


SELECT * FROM furniture;

INSERT INTO `time` VALUES
(10001,12,2,2010),
(10002,11,4,2010),
(10003,7,5,2010),
(10004,5,7,2010),
(10005,24,8,2010),
(10006,17,9,2010),
(10007,30,11,2010),
(10008,3,1,2011),
(10009,4,3,2011),
(10010,19,5,2011);


SELECT * FROM `time`;

INSERT INTO sales VALUES 
(104,5,10001,70,630000,31500),
(101,2,10003,55,900000,45000),
(102,4,10002,63,126000,6300),
(106,3,10001,80,400000,20000),
(102,5,10006,30,60000,3000),
(105,4,10004,45,270000,13500),
(103,1,10009,60,900000,45000),
(102,7,10010,65,130000,6500);

SELECT * FROM sales;

-- Questions -- 
--  Find the quantity, the total income and discount with respect to each city, type of furniture and the month
SELECT C.City, F.Type, T.Month,
SUM(S.Quantity), SUM(S.Income), SUM(S.Discount)
FROM Sales S, Customer C, `Time` T, Furniture F
WHERE S.IdCustomer = C.IdCustomer AND
S.IdTime = T.IdTime AND
S.IdFurniture = F.IdFurniture
GROUP BY T.Month, F.Type, C.City

-- Find the average quantity, income and discount with respect to each country, furniture material and year

SELECT C.Country, F.Material, T.Year,
AVG(S.Quantity), AVG(S.Income), AVG(S.Discount)
FROM Sales S, Customer C, `Time` T, Furniture F
WHERE S.IdCustomer = C.IdCustomer AND
S.IdTime = T.IdTime AND
S.IdFurniture = F.IdFurniture
GROUP BY T.Year, C.Country, F.Material

-- Determine the 5 most sold furnitures during the May month
SELECT F.Type, SUM(S.Quantity)
FROM (
SELECT F.Type, SUM(S.Quantity) AS TotQuantity,
RANK() OVER (ORDER BY SUM(S.Quantity) DESC) RANK
FROM sales S, furniture F, `time` T 
WHERE S.IdFurniture = F.IdFurniture AND  
S.IdTime = T.IdTime AND T.Month = 5) 
WHERE RANK = 5;
