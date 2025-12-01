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

# the following output showing all the tables that are part of the bookings schema in the demo database

####################################################################
# Exercise : Create New Roles and Grant them Relevant Privileges

# In PostgreSQL, users, groups, and roles are all the same entity, with the difference being that users can log in by default.
# In this exercise, you will create two new roles: read_only and read_write, then grant them the relevant privileges.
# To begin, ensure that you have the PostgreSQL Command Line Interface open and connected to the demo database, as such:

# Create a read_only role and grant it privileges

# To create a new role named read_only, enter the following command into the CLI:
CREATE ROLE read_only;

# First, this role needs the privilege to connect to the demo database itself. To grant this privilege, enter the following command into the CLI:
GRANT CONNECT ON DATABASE demo TO read_only;

# Next, the role needs to be able to use the schema in use in this database. In our example, this is the bookings schema. Grant the privilege for the read_only role to use the schema by entering the following:
GRANT USAGE ON SCHEMA bookings TO read_only;


GRANT SELECT ON ALL TABLES IN SCHEMA bookings TO read_only;

# This allows the read_only role to execute the SELECT command on all tables in the bookings schema.

# Task B: Create a read_write role and grant it privileges
# Similarly, create a new role called read_write with the following command in the PostgreSQL CLI:
CREATE ROLE read_write;


GRANT CONNECT ON DATABASE demo TO read_write;

# Give the role the privileges to use the bookings schema that is used in the demo database with the following:

GRANT USAGE ON SCHEMA bookings TO read_write;

# So far the commands for the read_write role have been essentially the same as for the read_only role. However, the read_write role should have the privileges to not only access the contents of the database, but also to create, delete, and modify entries. The corresponding commands for these actions are SELECT, INSERT, DELETE, and UPDATE, respectively. Grant this role these privileges by entering the following command into the CLI:


GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA bookings TO read_write;

=========================================================
Exercise 2: Add a New User and Assign them a Relevant Role
# In this exercise, you will create a new user for the database and assign them the one of the roles you created in Exercise . This method streamlines the process of adding new users to the database since you don’t have to go through the process of granting custom privileges to each one. Instead, you can assign them a role and the user inherits the privileges of that role.


# Suppose you wish to add a new user, user_a, for use by an information and help desk at an airport. In this case, assume that there is no need for this user to modify the contents of the database. As you may have guessed, the appropriate role to assign is the read_only role.

# To create a new user named user_a, enter the following command into the PostgreSQL CLI:


CREATE USER user_a WITH PASSWORD 'user_a_password';


# In practice, you would enter a secure password in place of ‘user_a_password’, which will be used to access the database through this user.

# Next, assign user_a the read_only role by executing the following command in the CLI:


GRANT read_only TO user_a;

# You can list all the roles and users by typing the following command:

\du

# You will see the following output:
demo=# \du
                                     List of roles
 Role name  |                         Attributes                         |  Member of
------------+------------------------------------------------------------+-------------
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 read_only  | Cannot login                                               | {}
 read_write | Cannot login                                               | {}
 user_a     |                                                            | {read_only}

##########################################################################

# Exercise 3: Revoke and Deny Access
# In this exercise, you will learn how to revoke a user’s privilege to access specific tables in a database.

# Suppose there is no need for the information and help desk at the airport to access information stored in the aircrafts_data table. In this exercise, you will revoke the SELECT privilege on the aircrafts_data table in the demo database from user_a.

# You can use the REVOKE command in the Command Line Interface to remove specific privileges from a role or user in PostgreSQL. Enter the following command into the PostgreSQL CLI to remove the privileges to access the aircrafts_data table from user_a:


REVOKE SELECT ON aircrafts_data FROM user_a;

# Now suppose user_a is transferred departments within the airport and no longer needs to be able to access the demo database at all. You can remove all their SELECT privileges by simply revoking the read_only role you assigned to them earlier. You can do this by entering the following command in the CLI:

REVOKE read_only FROM user_a;


# Now you can check all the users and their roles again to see that the read_only role was successfully revoked from user_a by entering the following command again:

\du

# You will see the following output:
 Role name  |                         Attributes                         | Member of
------------+------------------------------------------------------------+-----------
 postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 read_only  | Cannot login                                               | {}
 read_write | Cannot login                                               | {}
 user_a     |                                                            | {}
