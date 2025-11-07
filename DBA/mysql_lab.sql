-- use the MySQL Command Line Interface (CLI) to carry out a variety of functions related to selecting
--and understanding some of the alternative storage engines available in MySQL. You will then continue on to explore the system tables in MySQL which contain meta data about the objects in the server.

--Create tables using alternative storage engines.
--Query MySQL system tables to retrieve meta data about objects in the database.

--Create a new database world:
CREATE DATABASE world;

--To use the newly created world database, use the command below in the terminal:
USE world;

--Execute the world mysql script (world_mysql.sql) to complete the world database creation process:
SOURCE /path/to/your/world_mysql.sql;

-- list all the table names from the world database,
SHOW TABLES;

-- Storage Engines are components that handle SQL operations for different table types. The default and most general purpose storage engine in MySQL is InnoDB. When you create a new table in MySQL using the CREATE TABLE command in the Command Line Interface, it creates a InnoDB table by default. This is the most widely useful one and is recommended for most general applications except for a few specialized cases.

-- As detailed in the MySQL documentation, MySQL is built with a pluggable storage engine architecture that allows storage engines to be easily loaded into and unloaded from a running MySQL server.

-- To see a list of the Storage Engines supported on your MySQL server, enter the following command into the MySQL Command Line Interface:

SHOW ENGINES;

--create a new table with a storage engine other than the default InnoDB database, we specify the storage engine we wish to use inside the CREATE TABLE command. Let’s create a new table called “test_csv” using the CSV engine by entering the following command into the CLI:
CREATE TABLE csv_test (i INT NOT NULL, c CHAR(10) NOT NULL) ENGINE = CSV;

--confirm that the table was successfully created with the following comma
SHOW TABLES;

--add some sample data into our table. We will add three entries with the following command:
INSERT INTO csv_test VALUES(1,'data one'),(2,'data two'),(2,'data three');

--look at the new values you entered with the CLI:
SELECT * FROM csv_test;

--Grant System Table category. They contain information about the user accounts and the privileges granted to them.
SHOW DATABASES;

--connect to the mysql data by entering:
USE mysql;

-- look at all the tables in the database by entering the following in the CLI:
SHOW TABLES;

--user table contains user accounts, global privileges, and other nonprivilege columns.
--look at just the first column which lists the names of the users in the database
SELECT User FROM user;

--add a new user to the database and see if the change is reflected in the user table.
CREATE USER test_user;

-- INFORMATION_SCHEMA is a database found inside every MySQL server. It contains meta data about the MySQL server such as the name of a database or table, the data type of a column, or access privileges
-- information_schema database, there exists a table called COLUMNS which contains meta data about the columns for all tables and views in the server. One of the columns in this table contains the names of all the other columns in every table. Let’s go ahead and look at the names of the columns in the country table in the world database by entering the following command in the CLI
SELECT COLUMN_NAME FROM COLUMNS WHERE TABLE_NAME = 'country';

-- run the following command in the CLI to view the storage engine type for the ‘country’, ‘city’, ‘countrylanguage’, and finally the ‘csv_test’ table you created:
SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES
WHERE table_name = 'country' OR table_name = 'city'
OR table_name = 'countrylanguage' OR table_name = 'csv_test';

-- TABLES table in the information_schema database contains information on the the size of a given table in bytes. This information is stored in two columns: data_length and index_length which stores the size of the data in the table and the size of the index file for that table, respectively. Therefore, the total size of the table is the sum of the values in these two columns. This value would be given in bytes, however, if you wish to use a more convenient unit, the sum can be converted to kB by dividing by 1024. You can find the size of the tables (in kB) you queried in the previous step with the following command in the CLI:
SELECT table_name, (data_length + index_length)/1024 FROM INFORMATION_SCHEMA.TABLES
WHERE table_name = 'country' OR table_name = 'city'
OR table_name = 'countrylanguage' OR table_name = 'csv_test';

--
-- create a new table using the non-default MyISAM storage engine. You will then apply what you learned about MySQL System Tables to fetch metadata about your newly created table.
-- connect to the world database using the CLI:
USE world;

-- Create a new table called MyISAM_test that uses the MYISAM storage engine.
CREATE TABLE MyISAM_test (i INT NOT NULL, c CHAR(10) NOT NULL) ENGINE = MYISAM;

-- query a table in the information_schema database, but before that, you’ll have to connect to the database first. Use the CLI to connect to the information_schema database.

USE information_schema;

-- query the TABLES table in the information_schema database to display the table_name and engine columns of all tables that have table_schema = 'world'
SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = 'world';

