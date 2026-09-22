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
# Run the commands below to download and extract the schema files.
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Setting%20up%20a%20staging%20area/billing-datawarehouse.tgz

tar -xvzf billing-datawarehouse.tgz
ls *.sql

# create the schema and tables in the billingDW database by running the following command:
psql  -h postgres -U postgres -p 5432 billingDW < star-schema.sql


# load data into dimension tables first
# Step 1: Load data into DimCustomer table
# Run the command below to load the data into DimCustomer table in billingDW database.

# Step 2: Load data into DimMonth table
psql  -h postgres -U postgres -p 5432 billingDW < DimMonth.sql

# load data into fact table
psql  -h postgres -U postgres -p 5432 billingDW < FactBilling.sql


# run a sample query to interact with the data in the data warehouse
# check the number of rows in all the tables in the billingDW database

# Your data warehouse staging area is now ready.

#########################################################

# Practice Exercise:
# create a database named practice and load the data into it.
createdb -h postgres -U postgres -p 5432 practice

# In the practice database, create a schema using star-schema.sql.
psql  -h postgres -U postgres -p 5432 practice < star-schema.sql

# In the practice database, load the data into all tables using the DimMonth.sql, DimCustomer.sql and FactBilling.sql.
psql  -h postgres -U postgres -p 5432 practice < DimMonth.sql
psql  -h postgres -U postgres -p 5432 practice < DimCustomer.sql
psql  -h postgres -U postgres -p 5432 practice < FactBilling.sql

# _Verify that you have correctly loaded the data into the practice database.
psql  -h postgres -U postgres -p 5432 practice < verify.sql

# You finished setting up a staging server for a data warehouse using PostgreSQL. You have created a new database, designed and implemented a database schema, loaded data into tables, and run sample queries to interact with the data.
