# Setting up and managing a staging server for a data warehouse, specifically using PostgreSQL
# how to design and implement a database schema, load data into tables, and run sample queries to interact with the data


# 1. Create a new database for the data warehouse
# Open a new terminal
# create a database named billingDW:
createdb -h postgres -U postgres -p 5432 billingDW
-h mentions that the database server is accessible using the hostname “postgres”
-U mentions that we are using the user name postgres to log into the database
-p mentions that the database server is running on port number 5432


# 2. Create datawarehouse schema and tables
