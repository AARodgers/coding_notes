# Launch a PostgreSQL server instance,
# utilize the pgAdmin graphical user interface (GUI) for database operations,
# execute essential tasks like creating a database, designing tables, and loading data

# Process of setting up a 'Production' database and populating it with data following a star schema design

# The production database contains:
# DimCustomer
# DimMonth
# FactBilling
# (star schema)

# Create production related database and tables in a PostgreSQL instance.
# Populate the production data warehouse by loading the tables from Scripts.

# Task A: launch a PostgreSQL server instance
# Put in password
# create new database (right click, create new), name: production

# Task B: create tables in the production database
# in the open file, drop sql file:
CREATE TABLE "DimCustomer"(customerid integer NOT NULL PRIMARY KEY,category varchar(10) NOT NULL,country varchar(40) NOT NULL,industry varchar(40) NOT NULL);


CREATE TABLE "DimMonth"(monthid integer NOT NULL PRIMARY KEY,year integer NOT NULL,month integer NOT NULL,monthname varchar(10) NOT NULL,quarter integer NOT NULL,quartername varchar(2) NOT NULL);


CREATE TABLE "FactBilling"(billid integer not null primary key,customerid integer NOT NULL,monthid integer NOT NULL,billedamount integer NOT NULL,
FOREIGN KEY (customerid) REFERENCES "DimCustomer" (customerid),FOREIGN KEY (monthid) REFERENCES "DimMonth" (monthid));


