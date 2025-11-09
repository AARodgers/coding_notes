Upload and Export using Datasette

Datasette, an open-source multi-tool for exploring and publishing data.

Upload CSV file onto a table in Datasette.
Export data from Datasette.

First dataset used in this lab comes from the following source: https://dataplatform.cloud.ibm.com/exchange/public/entry/view/5562ced564e776edc5f91e13d48d8309?context=cpdaas. This dataset is published by IBM and contains point data for a sample list of hospitals in the US.

Upload Data into a Datasette by creating a table with url
SELECT * FROM hospitals;
SELECT count(*) FROM hospitals;

Export a Table from Datasette.
------------------------------------------------------------------------
Backup and Restore using PostgreSQL

Use the PostgreSQL Command Line Interface (CLI) to restore a full database from a backup
hen using a combination of the CLI and pgAdmin, which is a Graphical User Interface (GUI) for postgreSQL,
you will make some changes to this database and perform a full backup.
Then delete this database to practice a full restoration in the scenario of an accidental deletion.
Use a database from https://postgrespro.com/education/demodb

Use the PostgreSQL CLI and pgAdmin to:
Restore a full database from a backup
Update a database and perform a full backup
Drop a database and then restore it

Download database:
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql
The file which you downloaded is a full database backup of a month of flight data in Russia.
Now, you can perform a full restoration of the dataset by first opening the PostgreSQL CLI.

RDBMSsestore the data into a new database called demo.
\i flights_RUSSIA_small.sql

After the restoration completes, one way you can check that the database has been restored is with the following command, which lists all the tables in the current database schema.
\dt

Take a look at the contents of that table
SELECT * FROM aircrafts_data;

The aircraft they wish to add is the Airbus A380, which has a range of 15,700 km and aircraft code “380”.
INSERT INTO aircrafts_data(aircraft_code, model, range) VALUES (380, '{"en": "Airbus A380-800"}', 15700);

Confirm that the information was entered into the database correctly, you can read out the aircrafts_data table again using:
SELECT * FROM aircrafts_data;

Backup your Database using pgAdmin
Now that you modified the database (minor modification for demonstration - in reality there would likely be far more additions)
it is good practice to backup your database in case of accidental deletion.

--First exit the PostgreSQL CLI by either entering:
\q
--open the pgAdmin Graphical User Interface b
--click on the Servers tab on the left side of the page. You will be prompted to enter a password


Restore a Full Backup after Accidental Deletion
Suppose you find yourself in a situation where you accidentally dropped the entire database.
Fortunately, you made a full backup of the database in the previous exercise, which you will use to restore the database.
--Right click and press restore

-- “Accidentally” Delete the Database
-- pgAdmin GUI, right click on the demo database and then click the “Delete/Drop” button.
-- right click and delete

Restore the Database using the Full Backup
--use the full backup you created in Exercise 2 to restore the database which was deleted.
-- First, you will need an empty database in which to restore the demo database.
--Create a new database in pgAdmin by right clicking “Databases” then clicking “Create” > “Database
-- Next, to restore the backup you created in Task A into this new database, right click on the database you created
--(For example, restored_demo). Then click on the “Restore…” button.
-- Click on the button containing three dots by the Filename box.
-- Near the bottom left of the window, open the “Format” drop down window and select “All files”.
-- Select the backup you created in Task A (For example, demo_backup), then click the “Select” button near the bottom right of the window.
-- Then click on the “Restore” button at the bottom right of the window to restore the database.
-- now verify that the database was restored properly, including the addition you made to the aircrafts_data table. Open up the PostgreSQL CLI:
\connect restored_demo
-- set the proper search path for your database, enter the following into the CLI:
SELECT pg_catalog.set_config('search_path', 'bookings', false);
-- To see the restored tables in the database, enter:
\dt
-- Recall that you added a new aircraft model (Airbus A380) to the original database. Verify that this addition was successfully backed up and restored by entering the following command:
SELECT * FROM aircrafts_data;
--enter \q to exit this view.
\q

-- Look up user with booking reference for this passenger is 0002D8.
SELECT * FROM tickets WHERE book_ref = '0002D8';

-- correct the spelling by changing the passenger_name to “SANYA KORELEVA”.
UPDATE tickets SET passenger_name = 'SANYA KORELEVA' WHERE book_ref = '0002D8';

-- In the Cloud IDE terminal, enter the following command to create a backup of
--the restored_demo called restored_demo_backup.sql database:
"pg_dump --username=postgres --host=localhost restored_demo > restored_demo_backup.sql"
