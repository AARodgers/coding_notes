-- Objectives:
-- Use the EXPLAIN statement to check the performance of your query
-- Add indexes to improve the performance of your query
-- Apply other best practices such as using the UNION ALL clause to improve query performance

--  source: https://dev.mysql.com/doc/employee/en/ under the CC BY-SA 3.0 License

-- To download employee database:
-- wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/employeesdb.zip

-- Unzip file
-- unzip employeesdb.zip

-- change directories so that we’re able to access the files in the newly created employeesdb folder.
-- cd employeesdb

-- Have to put the database into your MySQL instance ( need to start on first):

-- switch to mysql CLI or prompt and go to the db you will be using:
-- use employees;

-- show the table in the db
-- show tables;

-- EXPLAIN statement, which provides information about how MySQL executes your statement, will offer you
--insight about the number of rows your query is planning on looking through. This statement can be helpful
--when your query is running slow. For example, is it running slow because it’s scanning the entire table each time?

-- try a query selecting all data from employees table
-- SELECT * FROM employees;

-- We can use EXPLAIN to see how many rows were scanned:
--EXPLAIN SELECT * FROM employees;

-- look at existing indexes on employees table
SHOW INDEX FROM employees;

-- see all the information about employees who were hired on or after January 1, 2000.
SELECT * FROM employees WHERE hire_date >= '2000-01-01';

-- see how many rows were scanned
EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';

-- By adding an index to the hire_date column, we’ll be able to reduce the query’s
--need to search through every entry of the table, instead only searching through what it needs.
-- add an index with the following:
CREATE INDEX hire_date_index ON employees(hire_date);
-- The CREATE INDEX command creates an index called hire_date_index on the table employees on
--column hire_date.

-- check your index, you can use the SHOW INDEX command:
SHOW INDEX FROM employees;
-- Now you can see that we have both the emp_no index and hire_date index.

-- Once more, let’s select all the employees who were hired on or after January 1, 2000.
SELECT * FROM employees WHERE hire_date >= '2000-01-01';

-- Under Extra, you can also see that it has been explicitly stated that the index was used,
--that index being hire_date_index based on the possible_keys column.

--  if you want to remove the index, enter the following into the Terminal:
DROP INDEX hire_date_index ON employees;
-- This will remove the hire_date_index on the employees table.
--You can check with the SHOW INDEX command to confirm:
SHOW INDEX FROM employees;

--you might want to run a query using the OR operator with LIKE statements.
--In this case, using a UNION ALL clause can
--improve the speed of your query, particularly if the columns on both sides of the OR operator are indexed.
-- try a query like this:
SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
-- This query searches for first names or last names that start with “C”. It returned 28,970 rows,
--taking about 0.20 seconds.


-- Now, let’s see how many rows were scanned:
EXPLAIN SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
-- see that almost all the rows are being scanned, so let’s add indexes to both the
--first_name and last_name columns.

-- Try adding an index to both the first_name and last_name columns.
CREATE INDEX first_name_index ON employees(first_name);
CREATE INDEX last_name_index ON employees(last_name);

-- re-run the query
SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

-- use the UNION ALL clause to improve the performance of this query.
SELECT * FROM employees WHERE first_name LIKE 'C%' UNION ALL SELECT * FROM employees WHERE last_name LIKE 'C%';

-- this query only takes 0.11 seconds to execute, running faster than when we used the OR operator.
-- check how many rows were scanned:
EXPLAIN SELECT * FROM employees WHERE first_name LIKE 'C%' UNION ALL SELECT * FROM employees WHERE last_name LIKE 'C%';
-- Notice that the number of rows scanned has decreased significantly.
-- EXPLAIN statement reveals, there were two SELECT operations performed, with the total number of
--rows scanned sitting at 54,790. This is less than the original query that scanned the entire table and,
--as a result, the query performs faster.

--  if you choose to perform a leading wildcard search with an index, the entire table will still be scanned.
--You can see this yourself with the following query:
SELECT * FROM employees WHERE first_name LIKE '%C';
-- With this query, we want to find all the employees whose first names end with “C”.
-- When checking with the EXPLAIN and SHOW INDEX statements, we can see that although we have an index on first_name, the index is not used and results in a search of the entire table.

--Under the EXPLAIN statement’s possible_keys column, we can see that this index has not been used
--as the entry is NULL.

-- On the other hand, indexes do work with trailing wildcards, as seen with the following query that
--finds all employees whose first names begin with “C”:
SELECT * FROM employees WHERE first_name LIKE 'C%';

-- best practice to only select the columns that you need. For example, if you wanted to see the
--names and hire dates of the various employees, you could show that with the following query:
SELECT * FROM employees;

-- however, only wanted to see the names and hire dates, then we should select those columns:

-- however, only wanted to see the names and hire dates, then we should select those columns:
SELECT first_name, last_name, hire_date FROM employees;

-- 
