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

-- Use the CLI to query the pg_tables to display metadata about the tables belonging to the bookings schema
--and confirm that the row security for the boarding_passes was successfully enabled.
SELECT * FROM pg_tables WHERE schemaname = 'bookings';

-- There’s also a system catalog called pg_settings that stores data about configuration parameters of the PostgreSQL server.
SELECT name, setting, short_desc FROM pg_settings WHERE name = 'wal_level';
-- This will display the name, current setting, and a short description of the wal_level parameter.
--pg_tables contains much more data about a given parameter than is available from the SHOW statement
-- learn more: https://www.postgresql.org/docs/10/view-pg-settings.html

--change the name of the aircrafts_data to aircraft_fleet.
-- try changing the name of the table by directly editing the pg_tables table from the system catalogs.
-- DON'T DO THIS BELOW!!
--SQL command to update a table from the system catalog directly results in an error. This is a good safeguard for you as a database administrator since as discussed earlier in the lab, changing individual
--values in a system catalog directly can severely mess up your database. Let’s try a different approach.
--UPDATE pg_tables SET tablename = 'aircraft_fleet' WHERE tablename = 'aircrafts_data';

--to properly change the name of the aircrafts_data, enter the following command in the CLI:
ALTER TABLE aircrafts_data RENAME TO aircraft_fleet;
--To confirm that the table was successfully renamed, query pg_tables from the system catalog by
--schemaname ‘bookings’ to display the tablename column.
SELECT tablename FROM pg_tables WHERE schemaname = 'bookings';

-----------------------------------
Notes:
An instance is a logical boundary for a database or set of databases where you organize database objects and set configuration parameters.

Common database objects are items that exist within the database such as tables, constraints, indexes, keys, views, aliases, triggers, events, and log files.

Different RDBMSs use different names for their system objects. Most use the terms system schema, system tables, catalog, or directory.

Database storage is managed through logical database objects and physical storage.
