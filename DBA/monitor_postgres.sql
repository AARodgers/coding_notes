-- monitor and optimize your database in PostgreSQL
-- After completing this lab, you will be able to:

-- Monitor the performance of your database with the command line interface and pgAdmin.
-- Identify optimal data types for your database.
-- Optimize your database via the command line with best practices.

-- Use a database from https://postgrespro.com/education/demodb distributed under the PostgreSQL licence.
-- It stores a month of data about airline flights in Russia

-- create our database with the help of a SQL file

-- 1. Download database:
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql

--2. Open a PostresSQL terminal by running the following command in your terminal:
psql -U postgres

-- 3. Import the data by executing sql script: ( when you see demo=# it means you switched to a new database)
\i /path/to/flights_RUSSIA_small.sql

-- 4. Display tables in the database:
\dt

-- monitor current server and database activity in PostgreSQL

--5. Look at server activity( information comes from the pg_stat_activity, one of the built-in statistics provided by PostgreSQL.
SELECT pid, usename, datname, state, state_change FROM pg_stat_activity;

-- Column	Description
-- pid	Process ID
-- usename	Name of user logged in
-- datname	Name of database
-- state	Current state, with two common values being: active (executing a query) and idle (waiting for new command)
-- state_change	Time when the state was last changed

-- currently 7 active connections to the server, with two of them being connected to databases that you’re familiar with.

--6. say you wanted to see all the aforementioned columns, in addition to the actual text of the query that was last executed
SELECT pid, usename, datname, state, state_change, query FROM pg_stat_activity;

--7. Filter for only active connections:
SELECT pid, usename, datname, state, state_change, query FROM pg_stat_activity
WHERE state = 'active';

## Database activity
-- 8. Look at database activity:
SELECT datname, tup_inserted, tup_updated, tup_deleted FROM pg_stat_database;

-- This query will retrieve the following:

-- Column	Description
-- datname	Name of database
-- tup_inserted	Number of rows inserted by queries in this database
-- tup_updated	Number of rows updated by queries in this database
-- tup_deleted	Number of rows deleted by queries in this database

-- This information comes from the pg_stat_database, one of the statistics provided by PostgreSQL.

-- say you wanted to see the number or rows fetched and returned by this database.
SELECT datname, tup_fetched, tup_returned FROM pg_stat_database;
-- The number of rows fetched is the number of rows that were returned. The number of rows returned is the number of rows that were read and scanned by the query.
-- Notice how the rows returned tend to be greater than the rows fetched. If you consider how tables are read, this makes sense because not all the rows scanned may be the ones that are returned.

-- What if you only wanted to see the database details (rows inserted, updated, deleted, returned and fetched) for demo?

SELECT datname, tup_inserted, tup_updated, tup_deleted, tup_fetched, tup_returned FROM pg_stat_database
WHERE datname = 'demo';

## Monitor with pgAdmin
Chart	Description
Server/Database sessions	Displays the total sessions that are running. For servers, this is similar to the pg_stat_activity, and for databases, this is similar to the pg_stat_database.
Transactions per second	Displays the commits, rollbacks, and transactions taking place.
Tuples in	Displays the number of tuples (rows) that have been inserted, updated, and deleted, similar to the tup_inserted, tup_updated, and tup_deleted columns from pg_stat_database.
Tuples out	Displays the number of tuples (rows) that have been fetched (returned as output) or returned (read or scanned). This is similar to tup_fetched and tup_returned from pg_stat_database.
Server activity	Displays the sessions, locks, prepared transactions, and configuration for the server. In the Sessions tab, it offers a look at the breakdown of the sessions that are currently active on the server, similar to the view provided by pg_stat_activity. To check for any new processes, you can select the refresh button at the top-right corner.

-- run a query on the database! To do that, navigate to the menu bar and select Tools > Query Tool
SELECT * FROM bookings;

-- Extensions, which can enhance your PostgreSQL experience, can be helpful in monitoring your database. One such extension is pg_stat_statements, which gives you an aggregated view of query statistics.
-- To enable the extension, enter the following command:
CREATE EXTENSION pg_stat_statements;
-- This will enable the pg_stat_statements extension, which will start to track the statistics for your database.
-- Now, let’s edit the PostgreSQL configuration file to include the extension you just added:
ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';
-- For the changes to take effect, you will have to restart your database.
--You can do that by typing exit in the terminal to stop your current session. Close the terminal and return to the PostgreSQL
--  restart your session
-- Once your session has started, open the PostgreSQL CLI.

-- You’ll need to reconnect to the demo database:
\connect demo
-- You can see if this extension has been loaded by checking both the installed extensions and the shared_preload_libraries.
-- check the installed extensions:
\dx
-- check the shared_preload_libraries with:
show shared_preload_libraries;
-- Since the results returned by pg_stat_statements can be quite long, let’s turn on expanded table formatting with the following command:
\x
-- You can turn it off by repeating the \x command.
-- say you wanted to retrieve the database ID, the query, and total time that it took to execute the statement (in milliseconds).
SELECT dbid, query, total_exec_time FROM pg_stat_statements;

-- What if you wanted to check which datbase name matches the database ID?
SELECT oid, datname FROM pg_database;

-- It’s important to note that adding these extensions can increase your server load, which may affect performance. If you need to drop the extension, you can achieve that with the following command:
DROP EXTENSION pg_stat_statements;

-- If you check the current extensions with \dx, you’ll also see that pg_stat_statements no longer appears.

-- You should also reset the shared_preload_libraries in the configuration file:
ALTER SYSTEM RESET shared_preload_libraries;

-- After this, you’ll need to exit the terminal and restart the PostgreSQL CLI to see the changes reflected in show shared_preload_libraries;.

## Optimize Your Database
-- Data optimization is the maximization of the speed and efficiency of retrieving data from your database
-- Similar to MySQL, there are optimal data types and maintenance (otherwise known as “vacuuming”) that can be applied to optimize databases.
-- list tables
\dt
-- vNow that you know which tables are in the database, select the first one, aircrafts_data and see what data you can pull from it. How can you select all of its data?
SELECT * FROM aircrafts_data;
-- For the purposes of this lab, we’ll create a hypothetical situation that will potentially require changing the data types of columns to optimize them.
-- Let’s say that aircraft_code is always set to three characters, model will always be in a JSON format and range has a maximum value of 12,000 and minimum value of 1,000.
-- what would be the best data types for each column?
aircraft_code: char(3), since you know that the aircraft code will always be fixed to three characters.
model: json, which is a special data type that PostgreSQL supports.
range: smallint, since the range of its numbers falls between -32,768 to 32,767.

-- check the current data types
\d aircrafts_data

-- Notice that most of the columns in this table have been optimized for our sample scenario, except for the range. This may be because the range was unknown in the original database.

-- For this lab, let’s take the opportunity to optimize that column for your hypothetical situation. You can do this by changing the data type of the column.

-- Please note that in this lab you’ll first need to drop a view, which is another way our data can be presented, in order to change the column’s data type. Otherwise, you will encounter an error. This is a special case for this database because you loaded a SQL file that included commands to create views. In your own database, you may not need to drop a view.

-- To drop the aircrafts view, use the following command:

DROP VIEW aircrafts;

-- To change the column’s data type, you’ll use the following command:
ALTER TABLE aircrafts_data ALTER COLUMN range TYPE smallint;

-- check the table’s columns and data types again!
\d aircrafts_data


## Vacuum Your Databases
--  vacuuming means to clean out your databases by reclaiming any storage from “dead tuples”, otherwise known as rows that have been deleted but have not been cleaned out.
-- the autovacuum feature is automatically enabled, meaning that PostgreSQL will automate the vacuum maintenance process for you.
show autovacuum;
-- (will see)
 autovacuum
------------
 on
(1 row)
-- is enabled
-- As you can see, autovacuum is enabled.

-- Since autovacuum is enabled, let’s check to see when your database was last vacuumed.

-- To do that, you can use the pg_stat_user_tables, which displays statistics about each table that is a user table (instead of a system table) in the database.
-- The columns that are returned are the same ones listed in pg_stat_all_tables documentation.

-- you wanted to check the table (by name), the estimated number of dead rows that it has, the last time it was autovacuumed, and how many times it has been autovacuumed?
SELECT relname, n_dead_tup, last_autoanalyze, autovacuum_count FROM pg_stat_user_tables;
-- will see
     relname     | n_dead_tup |       last_autoanalyze        | autovacuum_count
-----------------+------------+-------------------------------+------------------
 bookings        |          0 | 2026-02-07 09:40:41.935091-07 |                1
 flights         |          0 | 2026-02-07 09:40:37.948987-07 |                1
 seats           |          0 | 2026-02-07 09:40:37.988034-07 |                1
 aircrafts_data  |          0 |                               |                0
 airports_data   |          0 | 2026-02-07 09:40:37.968437-07 |                0
 ticket_flights  |          0 | 2026-02-07 09:40:35.021821-07 |                1
 tickets         |          0 | 2026-02-07 09:40:41.785711-07 |                1
 boarding_passes |          0 | 2026-02-07 09:40:37.660414-07 |                1

 -- Notice that you currently don’t have any “dead tuples” (deleted rows that haven’t yet been cleaned out) and so far, these tables have been autovacuumed once. This makes sense given that the database was just created and based on the logs, autovacuumed then.


