-- This is a single-line comment
SELECT * FROM employees; -- This comment is at the end of a line

/*
This is a multi-line comment.
It can span multiple lines.
*/


/* ALTER TABLE statements can be used to add or remove columns from a table,
to modify the data type of columns, to add or remove keys, and to add or remove constraints.
The syntax of the ALTER TABLE statement is:*/

-- ADD a COLUMN syntax --
ALTER TABLE table_name
ADD column_name data_type;
-- A variation of the syntax for adding column is:--
ALTER TABLE table_name
ADD COLUMN column_name data_type;

/* By default, all the entries are initially assigned the value NULL. You can then use
UPDATE statements to add the necessary column values.
For example, to add a telephone_number column to the author table in the library database,
the statement will be written as: */

ALTER TABLE author
ADD telephone_number BIGINT;

-- Change datatype
-- Modify column data type--
ALTER TABLE table_name
MODIFY column_name data_type;

ALTER TABLE author
MODIFY telephone_number CHAR(20);

-- Delete all rows
-- TRUNCATE TABLE statements are used to delete all of the rows in a table.
-- The syntax of the statement is:

TRUNCATE TABLE table_name;
-- So, to truncate the "author" table, the statement will be written as:
TRUNCATE TABLE author;

-- Create a table
CREATE TABLE TableName (
   COLUMN1 datatype,
   COLUMN2 datatype,
   COLUMN3 datatype,
   ...
);

/* Create a TEST table with two columns - ID of type integer and NAME of type varchar.
For this, we use the following SQL statement.*/
CREATE TABLE TEST (
   ID int,
   NAME varchar(30)
);

/* Create a COUNTRY table with an integer ID column, a two-letter country code column,
and a variable length country name column. For this, we may use the following SQL statement.*/
CREATE TABLE COUNTRY (
   ID int,
   CCODE char(2),
   Name varchar(60)
);

-- Make ID primary key --
/* In the example above, make ID a primary key. Then, the statement will be modified as shown
below. */
CREATE TABLE COUNTRY (
   ID int NOT NULL,
   CCODE char(2),
   Name varchar(60)
   PRIMARY KEY (ID)
);

/* Note: In the above example, the ID column has the NOT NULL constraint added after the datatype,
 meaning that it cannot contain a NULL or an empty value. This is added since the database does
 not allow Primary Keys to have NULL values.*/

-- Drop a table --
/* If the table you are trying to create already exists in the database, you will get an
error indicating table XXX.YYY already exists. To circumvent this error, create a table with
a different name or first DROP the existing table. It is common to issue a DROP before doing a
CREATE in test and development scenarios.*/

-- The syntax to drop a table is:
DROP TABLE TableName;

/* For example, consider that you wish to drop the contents of the table COUNTRY if a
table exists in the dataset with the same name. In such a case, the code for the last
example  */
DROP TABLE COUNTRY;
CREATE TABLE COUNTRY (
   ID int NOT NULL,
   CCODE char(2),
   Name varchar(60)
   PRIMARY KEY (ID)
);

/*WARNING: Before dropping a table, ensure it doesn't contain important data that can't
be recovered easily.
Note that if the table does not exist and you try to drop it, you will see an error
like XXX.YYY is an undefined name. You can ignore this error if the subsequent CREATE
statement is executed successfully.*/

-- SQL SCRIPTS ---

-- Example script to creat 5 tables

DROP TABLE IF EXISTS PATIENTS;
DROP TABLE IF EXISTS MEDICAL_HISTORY;
DROP TABLE IF EXISTS MEDICAL_PROCEDURES;
DROP TABLE IF EXISTS MEDICAL_DEPARTMENTS;
DROP TABLE IF EXISTS MEDICAL_LOCATIONS;


CREATE TABLE PATIENTS (
  PATIENT_ID CHAR(9) NOT NULL,
  FIRST_NAME VARCHAR(15) NOT NULL,
  LAST_NAME VARCHAR(15) NOT NULL,
  SSN CHAR(9),
  BIRTH_DATE DATE,
  SEX CHAR,
  ADDRESS VARCHAR(30),
  DEPT_ID CHAR(9) NOT NULL,
  PRIMARY KEY (PATIENT_ID)
);

CREATE TABLE MEDICAL_HISTORY (
  MEDICAL_HISTORY_ID CHAR(9) NOT NULL,
  PATIENT_ID CHAR(9) NOT NULL,
  DIAGNOSIS_DATE DATE,
  DIAGNOSIS_CODE VARCHAR(10),
  MEDICAL_CONDITION VARCHAR(100),
  DEPT_ID CHAR(9),
  PRIMARY KEY (MEDICAL_HISTORY_ID)
);

CREATE TABLE MEDICAL_PROCEDURES (
  PROCEDURE_ID CHAR(9) NOT NULL,
  PROCEDURE_NAME VARCHAR(30),
  PROCEDURE_DATE DATE,
  PATIENT_ID CHAR(9) NOT NULL,
  DEPT_ID CHAR(9),
  PRIMARY KEY (PROCEDURE_ID)
);

CREATE TABLE MEDICAL_DEPARTMENTS (
  DEPT_ID CHAR(9) NOT NULL,
  DEPT_NAME VARCHAR(15),
  MANAGER_ID CHAR(9),
  LOCATION_ID CHAR(9),
  PRIMARY KEY (DEPT_ID)
);

CREATE TABLE MEDICAL_LOCATIONS (
  LOCATION_ID CHAR(9) NOT NULL,
  DEPT_ID CHAR(9) NOT NULL,
  LOCATION_NAME VARCHAR(50),
  PRIMARY KEY (LOCATION_ID, DEPT_ID)
);

/* This script incorporates commands to first drop any tables with the mentioned names in
the database. After that, the script contains commands to create 5 different tables.
All these commands are executed sequentially on the interface.*/

/* The contents of this file can be saved in a .sql file format and executed on the
phpMyAdmin interface. This can be done by first selecting the database, uploading the
SQL script in the provided space, and executing it, as shown in the image below.*/

-- Using Github Copilot to generate SQL scripts, then TAB to complete
// SQL script to add the column "PHONE" to the table "EMPLOYEES"
ALTER TABLE EMPLOYEES ADD COLUMN PHONE CHAR(10);

-- Use Command and right arrow to accept next words in ghost text
// SQL script to add the column "EMAIL" to the table "EMPLOYEES"
ALTER TABLE EMPLOYEES ADD

-- Use copilot for suggestions
// SQL script to add a foreign key constraint to the "DEPT_ID" column in the "EMPLOYEES" table
ALTER TABLE EMPLOYEES ADD CONSTRAINT FK_DEPT_ID FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID);

-- Chat with copilot in file: Command + i
-- There is also an AI chat


-- Script to create a table of pet rescue data

drop table if exists PETRESCUE;

create table PETRESCUE (
	ID INTEGER NOT NULL,
	ANIMAL VARCHAR(20),
	QUANTITY INTEGER,
	COST DECIMAL(6,2),
	RESCUEDATE DATE,
	PRIMARY KEY (ID)
	);

insert into PETRESCUE values
	(1,'Cat',9,450.09,'2018-05-29'),
	(2,'Dog',3,666.66,'2018-06-01'),
	(3,'Dog',1,100.00,'2018-06-04'),
	(4,'Parrot',2,50.00,'2018-06-04'),
	(5,'Dog',1,75.75,'2018-06-10'),
	(6,'Hamster',6,60.60,'2018-06-11'),
	(7,'Cat',1,44.44,'2018-06-11'),
	(8,'Goldfish',24,48.48,'2018-06-14'),
	(9,'Dog',2,222.22,'2018-06-15')

;


-- Aggregation Functions

--Write a query that calculates the total cost of all animal rescues in the PETRESCUE table.
SELECT SUM(COST) FROM PETRESCUE;

-- You can further assign a label to the query SUM_OF_COST.
SELECT SUM(COST) AS SUM_OF_COST FROM PETRESCUE;

--Write a query that displays the maximum quantity of animals rescued (of any kind).
--The output of this query will be the maximum value of all elements in the column.
SELECT MAX(QUANTITY) FROM PETRESCUE;

-- The query can easily be changed to display the minimum quantity using the MIN function instead.
SELECT MIN(QUANTITY) FROM PETRESCUE;

-- Write a query that displays the average cost of animals rescued.
SELECT AVG(COST) FROM PETRESCUE;

-- Scalar Functions and String Functions

--Write a query that displays the rounded integral cost of each rescue.
--The output of this query will be the value of each element in the column rounded to the specified number of decimal places. Note that
--the second argument is optional and, if omitted, results in rounding to an integer value
SELECT ROUND(COST) FROM PETRESCUE;

-- The query could also be written as:
SELECT ROUND(COST, 0) FROM PETRESCUE;

-- In case the question was to round the value to 2 decimal places, the query would change to:
SELECT ROUND(COST, 2) FROM PETRESCUE;


-- Write a query that displays the length of each animal name.
-- The output of this query will be the length of each element in the column
SELECT LENGTH(ANIMAL) FROM PETRESCUE;

-- Write a query that displays the animal name in each rescue in uppercase.
-- The output of this query will be each element in the column in upper case letters
SELECT UCASE(ANIMAL) FROM PETRESCUE;

-- the user could ask for a lower case representation, and the query would be changed to:
SELECT LCASE(ANIMAL) FROM PETRESCUE;


--Date Functions


-- Write a query that displays the rescue date.
-- The output of this query will be only the DAY part of the date in the column
SELECT DAY(RESCUEDATE) FROM PETRESCUE;

--In case the query was asking for MONTH of rescue, the query would change to:
SELECT MONTH(RESCUEDATE) FROM PETRESCUE;

--In case the query was asking for YEAR of rescue, the query would change to:
SELECT YEAR(RESCUEDATE) FROM PETRESCUE;

-- Animals rescued should see the vet within three days of arrival. Write a query that displays the third day of each rescue.
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE

DATE_ADD(COLUMN_NAME, INTERVAL Number Date_element)

--If the question was to add 2 months to the date, the query would change to:
SELECT DATE_ADD(RESCUEDATE, INTERVAL 2 MONTH) FROM PETRESCUE

--Similarly, we can retrieve a date before the one given in the column by a given number using the function DATE_SUB. By modifying the same example, the following query would provide the date 3 days before the rescue.
SELECT DATE_SUB(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE

--Write a query that displays the length of time the animals have been rescued, for example, the difference between the current date and the rescue date.
SELECT DATEDIFF(CURRENT_DATE, RESCUEDATE) FROM PETRESCUE

--CURRENT_DATE is also an inbuilt function that returns the present date as known to the server.

--To present the output in a YYYY-MM-DD format, another function FROM_DAYS(number_of_days)can be used. This function takes a number of days and returns the required formatted output. The query above would thus be modified to
SELECT FROM_DAYS(DATEDIFF(CURRENT_DATE, RESCUEDATE)) FROM PETRESCUE

--Write a query that displays the average cost of rescuing a single dog. Note that the cost per dog would not be the same in different instances.
SELECT AVG(COST/QUANTITY) FROM PETRESCUE WHERE ANIMAL = 'Dog';

--Write a query that displays the animal name in each rescue in uppercase without duplications.
SELECT DISTINCT UCASE(ANIMAL) FROM PETRESCUE;

--Write a query that displays all the columns from the PETRESCUE table where the animal(s) rescued are cats. Use cat in lowercase in the query.
SELECT * FROM PETRESCUE WHERE LCASE(ANIMAL)="cat";

--Write a query that displays the number of rescues in the 5th month.
SELECT SUM(QUANTITY) FROM PETRESCUE WHERE MONTH(RESCUEDATE)="05";

--The rescue shelter is supposed to find good homes for all animals within 1 year of their rescue. Write a query that displays the ID and the target date.
SELECT ID, DATE_ADD(RESCUEDATE, INTERVAL 1 YEAR) FROM PETRESCUE;


-- Subqueries
--Write SQL queries that demonstrate the necessity of using sub-queries
--Compose sub-queries in the where clause
--Build column expressions (for example, sub-query in place of a column)
--Write table expressions (for example, sub-query in place of a table)

-- SQL script to create fake HR tables
CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL,
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));

  CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL,
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));

 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL,
                            JOB_TITLE VARCHAR(30),
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL,
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));

Fake HR Database instructions:

Load the database
Using the skills acquired in the previous modules, you should first create the database in MySQL. Follow the steps below.

Open the phpMyAdmin interface from the Skills Network Toolbox in Cloud IDE.

Create a blank database named 'HR'. Use the script shared in the link below to create the required tables.
Script_Create_Tables.sql

Download the files in the links below to your local device (if not already done in previous labs)
Departments.csv
Jobs.csv
JobsHistory.csv
Locations.csv
Employees.csv

Use these files in the phpMyAdmin interface as the data for the respective tables in the 'HR' database.

Sub-queries and Nested Selects
Say you are asked to retrieve all employee records whose salary is lower than the average salary. You might use the following query to do this.


SELECT *
FROM EMPLOYEES
WHERE salary < AVG(salary);

However, this query will generate an error stating, "Illegal use of group function." Here, the group function is AVG and cannot be used directly in the condition since it has not been retrieved from the data. Therefore, the condition will use a sub-query to retrieve the average salary information to compare the existing salary. The modified query would become:


SELECT *
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES);

Now, consider executing a query that retrieves all employee records with EMP_ID, SALARY, and maximum salary as MAX_SALARY in every row. For this, the maximum salary must be queried and used as one of the columns. This can be done using the query below.


SELECT EMP_ID, SALARY, (SELECT MAX(SALARY) FROM EMPLOYEES) AS MAX_SALARY
FROM EMPLOYEES;

Now, consider that you wish to extract the first and last names of the oldest employee. Since the oldest employee will be the one with the smallest date of birth, the query can be written as:

SELECT F_NAME, L_NAME
FROM EMPLOYEES
WHERE B_DATE = (SELECT MIN(B_DATE) FROM EMPLOYEES);
Copied!
You may also use sub-queries to create derived tables, which can then be used to query specific information. Say you want to know the average salary of the top 5 earners in the company. You will first have to extract a table of the top five salaries as a table. From that table, you can query the average value of the salary. The query can be written as follows.

SELECT AVG(SALARY)
FROM (SELECT SALARY
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      LIMIT 5) AS SALARY_TABLE;

Note that it is necessary to give an alias to any derived tables.


Write a query to find the average salary of the five least-earning employees.
SELECT AVG(SALARY)
FROM (SELECT SALARY
     FROM EMPLOYEES
     ORDER BY SALARY
     LIMIT 5) AS SALARY_TABLE;

Write a query to find the records of employees older than the average age of all employees.
SELECT *
FROM EMPLOYEES
WHERE YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE,B_DATE))) >
   (SELECT AVG(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE,B_DATE))))
   FROM EMPLOYEES);

From the Job_History table, display the list of Employee IDs, years of service, and average years of service for all entries.
SELECT EMPL_ID, YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, START_DATE))),
   (SELECT AVG(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, START_DATE))))
   FROM JOB_HISTORY)
FROM JOB_HISTORY;

