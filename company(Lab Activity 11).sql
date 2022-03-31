/*
Join Queries: Assume necessary database schema

• Display the name of each employee with his department name.
• Display a list of all departments with the employees in each department.
• Display all the departments with the manager for that department.
• Display the names of each employee with the name of his/her boss.
• Display the names of each employee with the name of his/her boss with a blank for the boss of the president.
• Display the employee number and name of each employee who manages other employees with the number of people he or she manages.
• Repeat the display for the last question, but this time display the rows in descending order of the number of employees managed.

*/

-- CREATING DATABASE -- 

CREATE DATABASE company;
USE company;

-- CREATING THE SCHEMA OF DATABASE -- 

CREATE TABLE Dept (
  `deptno` INT(11) NOT NULL AUTO_INCREMENT,
  `dname` VARCHAR(30) NOT NULL,
  `loc` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`deptno`)
);

DESC dept;


CREATE TABLE `Emp` (
  `empno` INT(11) NOT NULL AUTO_INCREMENT,
  `ename` VARCHAR(30) NOT NULL,
  `hiredate` DATE NOT NULL,
  `deptno` INT(11) NOT NULL,
  `job` ENUM('SALESMAN','ANALYST','CLERK','MANAGER','PRESIDENT') NOT NULL,
  `sal` DECIMAL(7,2) NOT NULL,
  `mgr` INT(11) DEFAULT NULL,
  PRIMARY KEY (`empno`),
  KEY `mgr` (`mgr`),
  CONSTRAINT `Emp_ibfk_1` FOREIGN KEY (`mgr`) REFERENCES `Emp` (`empno`)
);

DESC emp;

-- INSERING THE VALUES TO THE DATABASE --

INSERT INTO dept VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

SELECT * FROM dept;

INSERT INTO emp VALUES
(7839, 'KING'  ,STR_TO_DATE('17/11/1981','%d/%m/%y'), 10, 5, 5000, NULL),
(7698, 'BLAKE' ,STR_TO_DATE('1/5/1981','%d/%m/%y')  , 30, 4, 2850, 7839),
(7782, 'CLARK' ,STR_TO_DATE('9/6/1981','%d/%m/%y')  , 10, 4, 2450, 7839),
(7566, 'JONES' ,STR_TO_DATE('2/4/1981','%d/%m/%y')  , 20, 4, 2975, 7839),
(7788, 'SCOTT' ,STR_TO_DATE('13/7/1987','%d/%m/%y') , 20, 2, 3000, 7566),
(7902, 'FORD'  ,STR_TO_DATE('3/12/1981','%d/%m/%y') , 20, 2, 3000, 7566),
(7369, 'SMITH' ,STR_TO_DATE('17/12/1980','%d/%m/%y'), 20, 3,  800, 7902),
(7499, 'ALLEN' ,STR_TO_DATE('20/2/1981','%d/%m/%y') , 30, 1, 1600, 7698),
(7521, 'WARD'  ,STR_TO_DATE('22/2/1981','%d/%m/%y') , 30, 1, 1250, 7698),
(7654, 'MARTIN',STR_TO_DATE('28/9/1981','%d/%m/%y') , 30, 1, 1250, 7698),
(7844, 'TURNER',STR_TO_DATE('8/9/1981' ,'%d/%m/%y') , 30, 1, 1500, 7698),
(7876, 'ADAMS' ,STR_TO_DATE('13/7/1987','%d/%m/%y') , 20, 3, 1100, 7788),
(7900, 'JAMES' ,STR_TO_DATE('3/12/1981','%d/%m/%y') , 30, 3,  950, 7698),
(7934, 'MILLER',STR_TO_DATE('23/1/1982','%d/%m/%y') , 10, 3, 1300, 7782);

SELECT * FROM emp;

-- QUESTIONS --

-- 1) Display the name of each employee with his department name

SELECT ename, dname
FROM Emp JOIN Dept USING(deptno);

-- 2) Display a list of all departments with the employees in each department

SELECT dname, COUNT(empno)
FROM Emp RIGHT JOIN Dept USING(deptno)
GROUP BY deptno;

-- 3) Display all the departments with the manager for that department

SELECT dname, ename
FROM Emp JOIN Dept USING(deptno)
WHERE job = 'MANAGER';

-- 4) Display the names of each employee with the name of his/her boss

SELECT me.ename, boss.ename AS bossname
FROM (Emp AS me) JOIN (Emp AS boss) ON (boss.empno = me.mgr);

-- 5) Display the names of each employee with the name of his/her boss with a
--    blank for the boss of the president

SELECT me.ename, boss.ename AS bossname
FROM (Emp AS me) LEFT JOIN (Emp AS boss) ON (boss.empno = me.mgr);

-- 6) Display the employee number and name of each employee who manages other
-- employees with the number of people he or she manages

SELECT boss.empno, boss.ename, COUNT(*) AS employees
FROM (Emp AS me) JOIN (Emp AS boss) ON (boss.empno = me.mgr)
GROUP BY boss.empno;

-- 7) Repeat the display for the last question, but this time display the rows
--    in descending order of the number of employees managed

SELECT boss.empno, boss.ename, COUNT(*) AS employees
FROM (Emp AS me) JOIN (Emp AS boss) ON (boss.empno = me.mgr)
GROUP BY boss.empno
ORDER BY employees DESC;
