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

