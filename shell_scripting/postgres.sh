# Postgres database
# 1. Start a postgres server
# 2. Open postgres CLI

### Create a table
# In this exercise we will create a table called users in the PostgreSQL database using PostgresSQL CLI. This table will hold the user account information.

# The table users will have the following columns:

# uname

# uid

# home

# You will connect to template1 database which is already available by default. To connect to this database, run the following command at the ‘postgres=#’ prompt.

\c template1

# You will get the following message.

# You are now connected to database "template1" as user "postgres".

# Also, your prompt will change to ‘template1=#’.

# Run the following statement at the ‘template1=#’ prompt to create the table.

create table users(username varchar(50),userid int,homedirectory varchar(100));

# If the table is created successfully, you will get the message below.

# CREATE TABLE

### Loading data into a PostgreSQL table.
# In this exercise, you will create a shell script which does the following.

# Extract the user name, user id, and home directory path of each user account defined in the /etc/passwd file.
# Save the data into a comma separated (CSV) format.
# Load the data in the csv file into a table in PostgreSQL database.

# 1. Open new terminal

# 2.In the terminal, run the following command to create a new shell script named csv2db.sh.
touch csv2db.sh

# 3. Open the file in the editor. Copy and paste the following lines into the newly created file.
# I used button in practice file


