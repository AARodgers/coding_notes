/*
process of designing a data warehouse for a cloud service provider.
It focuses on using billing data provided in a CSV file to create a star schema,
including the design of fact and dimension tables. This schema will support complex
queries related to billing, such as average billing per customer, billing by country,
industry, and category, as well as trends over time.
*/
=======================================
Notes on PostgreSQL
PostgreSQL
PostgreSQL, also known as Postgres, is a free, open-source object-relational database management
system known for its reliability and flexibility with relational and non-relational data types.
It can be used through a command line interface (pqsql) or third-party interface such as pgAdmin.

pgAdmin
With pgAdmin, you can connect to your servers, create databases and tables, load and query data,
write procedures and functions, and manage database objects. The interface includes both a Query Tool
to run SQL commands and view their results, as well as an Entity-Relationship Diagram (ERD) tool to
create an ERD for existing or new databases. Upon starting your database server, click the pgAdmin
button to be guided to its web browser. For more information on this tool, please see the DOCUMENTATION.

psql
psql is a command-line tool that allows you to issue a wide range of commands to your chosen database
servers. Upon launching your database server, click the Postgres CLI button to interact with your
started server through this environment. Alternatively, select a New Terminal to directly enter your
commands.

========================================
Exercise 1: Study the schema of the given csv file
In this lab, we will design a data warehouse for a cloud service provider.

The cloud service provider has given us their billing data in the csv file cloud-billing-dataset.csv. This file contains the billing data for the past decade.

Here are the field wise details of the billing data.

Field Name	Details
customerid	Id of the customer
category	Category of the customer. Example: Individual or Company
country	Country of the customer
industry	Which domain/industry the customer belongs to. Example: Legal, Engineering
month	The billed month, stored as YYYY-MM. Example: 2009-01 refers to the month January in the year 2009
billedamount	Amount charged by the cloud services provided for that month in USD
We need to design a data warehouse that can support the queries listed below:

average billing per customer
billing by country
top 10 customers
top 10 countries
billing by industry
billing by category
billing by year
billing by month
billing by quarter
average billing per industry per month
average billing per industry per quarter
average billing per country per quarter
average billing per country per industry per quarter
Here are five rows picked at random from the csv file.

Five rows from csv file

Step 1: Start the postgresql server.

Step 2: Create the database on the data warehouse.

Using the createdb command of the PostgreSQL server, we can directly create the database from the terminal.

Firstly, run the command below to set your PostgreSQL password for authentication. Replace <your_password> with your actual PostgreSQL password, and then execute the command:

export PGPASSWORD=<your_password>

Now, run the command below to create a database named billingDW.

createdb -h postgres -U postgres -p 5432 billingDW

n the above command

-h mentions that the database server is accessible using the hostname “postgres”
-U mentions that we are using the user name postgres to log into the database
-p mentions that the database server is running on port number 5432
You should see an output like this.- NOTHING

Step 3: Download the schema .sql file.

The commands to create the schema are available in the file below.

https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Working%20with%20Facts%20and%20Dimension%20Tables/star-schema.sql

Download the file by running the command below.
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Working%20with%20Facts%20and%20Dimension%20Tables/star-schema.sql

Step 4: Create the schema

Run the command below to create the schema in the under billingDW database.

psql  -h postgres -U postgres -p 5432 billingDW < star-schema.sql

Should see output:
BEGIN
CREATE TABLE
CREATE TABLE
CREATE TABLE
ALTER TABLE
ALTER TABLE
COMMIT

Practice exercises
In this practice exercise, you will analyze the below csv file, which contains data about the daily sales at different stores of an international fashion retailer.



Problem:
Design the schema for the dimension table DimStore.
Field Name	Details
storeid	Primary key - Unique identifier for every store
city	City where the store is located.
country	Country where the store is located.

Problem:
Design the schema for the dimension table DimDate.
Field Name	Details
dateid	Primary Key - Id of the date
day	Day derived from the date field of the original data. Example: 13, 19
weekday	Weekday derived from the date field of the original data. Example: 1, 2, 3, 4, 5, 6, 7. 1 for sunday, 7 for saturday
weekdayname	Weekday name derived from the date field of the original data. Example: Sunday, Monday
year	Year derived from the date field of the original data. Example: 2010
month	Month number derived from the date field of the original data. Example: 1, 2, 3
monthname	Month name derived from the date field of the original data. Example: March
quarter	Quarter number derived from the date field of the original data. Example: 1, 2, 3, 4
quartername	Quarter name derived from the date field of the original data. Example: Q1, Q2, Q3, Q4

Problem:
Design the schema for the fact table FactSales.
Field Name	Details
rowid	Primary key - Unique identifier for every row
storeid	Foreign Key - Id of the store
dateid	Foreign Key - Id of the date
totalsales	Total sales
