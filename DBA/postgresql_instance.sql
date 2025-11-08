-- PostgreSQL server instance, both through the command line interface (CLI) and by editing the configuration files. Furthermore, you will learn to navigate and query the PostgreSQL system catalog, which is a series of tables that store metadata about objects in the database
-- Customize the configuration parameters of your PostgreSQL server instance
--Query the system catalog to retrieve metadata about database objects

-- you will use a database from https://postgrespro.com/education/demodb distributed under the PostgreSQL licence. It stores a month of data about airline flights in Russia and is organized according to the following schema:

--1. start by connecting to the database using the psql CLI. You can do this by entering the following command in your terminal:
psql -h your_host -U your_username -d your_database;
--2. download database:
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql
--3. perform a full restoration of the data set by first opening the PostgreSQL CLI.
--In the terminal, enter the following command to open the PostgreSQL CLI:
psql -h your_host -U your_username -d your_database;
--4. Once you are in the PostgreSQL CLI, you can execute the following command to This will restore the data into a new database called demo.
\i /path/to/your/flights_RUSSIA_small.sql;
--5.verify that the database was properly created by entering the following command:
\dt

--------------------------------------------------------------
--Configure Your PostgreSQL Server Instance

--file named postgresql.conf that contains the configuration parameters for the server
-- manually modify this postgresql.conf file and restart the server for the changes to take effect,
--you can also edit some configuration parameters directly from the command line interface (CLI).

--look at the current setting of the wal_level parameter. You can do so by entering the following
--command into the CLI:
SHOW wal_level;
--wal_level parameter dictates how much information is written to the write-ahead log (WAL), which can be
--used for continuous archiving

--ALTER SYSTEM command is a way to modify the global defaults of a PostgreSQL instance without having to
--manually edit the configuration file
-- change the wal_level parameter to logical
ALTER SYSTEM SET wal_level = 'logical';
--some configuration parameters require a server restart before any changes take effect - the wal_level is one such parameter.
-- When you executed the ALTER SYSTEM command in Step 2 of this exercise, a new file named postgres.auto.conf was created
-----------------------------------------------------------------

------------------------------------------------
Navigate the System Catalog
-- he system catalog stores schema metadata, such as information about tables and columns and
--internal bookkeeping information
-- In PostgreSQL, the system catalogs are regular tables in which you can add columns and insert and update values.
-- n directly modifying the system catalogs, you can cause severe problems in your system, so it is
--generally recommended to avoid doing so.
-- Instead, the system catalogs are updated automatically when performing other SQL commands
-- For example, if you run a CREATE DATABASE command, a new database is created on the disk and a new row
--is automatically inserted into the pg_database system catalog table, storing metadata about that database.

--connect to the database
\connect demo

--explore some of the system catalog tables in PostgreSQL.
-- query of pg_tables, which is a system catalog containing metadata about each table in the database.
SELECT * FROM pg_tables WHERE schemaname = 'bookings';

-- to exit
:/q in the command prompt.
--This will exit the current session and return you to the "demo=#" prompt.

-- To enable row security on the boarding_passes table
ALTER TABLE boarding_passes ENABLE ROW LEVEL SECURITY;
-- learn more: https://www.postgresql.org/docs/9.5/ddl-rowsecurity.html


