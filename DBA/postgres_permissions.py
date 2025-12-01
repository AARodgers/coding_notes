# Objectives

# Create roles in a database and grant them select permissions
# Create new users in the database and assign them the appropriate role
# Revoke and deny access to the database from a user

# use a database from https://postgrespro.com/education/demodb

# Download database
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql
# The file which you downloaded is a full database backup of a month of flight data in Russia. Now, you can perform a full restoration of the dataset by first opening the PostgreSQL CLI.

# In the PostgreSQL CLI, type in the command \i <file_name>. In your case, the filename will be the name of the file you downloaded, flights_RUSSIA_small.sql. This will restore the data into a new database called demo.
# Need to get to the PostgreSQL CLI first. You can do this by typing the following command in your terminal:
# psql -U postgres
# (prompt should look like this; postgres=#)
# Then, in the PostgreSQL CLI, run the following command:
\i flights_RUSSIA_small.sql

#Verify that the database was properly created by entering the following command:
\dt

# Should see:
demo-# \dt
               List of relations
  Schema  |      Name       | Type  |  Owner
----------+-----------------+-------+----------
 bookings | aircrafts_data  | table | postgres
 bookings | airports_data   | table | postgres
 bookings | boarding_passes | table | postgres
 bookings | bookings        | table | postgres
 bookings | flights         | table | postgres
 bookings | seats           | table | postgres
 bookings | ticket_flights  | table | postgres
 bookings | tickets         | table | postgres


