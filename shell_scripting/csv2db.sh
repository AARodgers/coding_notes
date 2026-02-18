# This script
# Extracts data from /etc/passwd file into a CSV file.

# The csv data file contains the user name, user id and
# home directory of each user account defined in /etc/passwd

# Transforms the text delimiter from ":" to ",".
# Loads the data from the CSV file into a table in PostgreSQL database.

# You need to add lines of code to the script that will xtract user name (field 1), user id (field 3), and home directory path (field 6) from /etc/passwd file using the cut command.

# Extract phase

echo "Extracting data"

# Extract the columns 1 (user name), 2 (user id) and
# 6 (home directory path) from /etc/passwd

# cut -d":" -f1,3,6 /etc/passwd

# Run the script.
bash csv2db.sh

# Verify that the output contains the three fields, that you extracted.

# Change the script to redirect the extracted data into a file named extracted-data.txt

# Replace the cut command at end of the script with the following command.
cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt

# Run script again
bash csv2db.sh

# Run the command below to verify that the file extracted-data.txt is created, and has the content.
cat extracted-data.txt

# The extracted columns are separated by the original “:” delimiter. You need to convert this into a “,” delimited file. Add the below lines at the end of the script and save the file.

# Transform phase
echo "Transforming data"
# read the extracted data and replace the colons with commas.

tr ":" "," < extracted-data.txt  > transformed-data.csv

# Run the script.
bash csv2db.sh

# Run the command below to verify that the file transformed-data.csv is created, and has the content.
cat transformed-data.csv

# To load data from a shell script, you will use the psql client utility in a non-interactive manner. This is done by sending the database commands through a command pipeline to psql with the help of echo command.
# PostgreSQL command to copy data from a CSV file to a table is COPY.

# The basic structure of the command which we will use in our script is,

COPY table_name FROM 'filename' DELIMITERS 'delimiter_character' FORMAT;

# Now, add the lines below to the end of the script ‘csv2db.sh’ and save the file.

# Load phase
echo "Loading data"
# Set the PostgreSQL password environment variable.
# Replace <yourpassword> with your actual PostgreSQL password.
export PGPASSWORD=<yourpassword>;
# Send the instructions to connect to 'template1' and
# copy the file to the table 'users' through command pipeline.
echo "\c template1;\COPY users  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=postgres

# execute final script
bash csv2db.sh

# Now, add the line below to the end of the script 'csv2db.sh' and save the file.
echo "SELECT * FROM users;" | psql --username=postgres --host=postgres template1


####
Practice exercises
Copy the data in the file ‘web-server-access-log.txt.gz’ to the table ‘access_log’ in the PostgreSQL database ‘template1’.

The file is available at the location : https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz

The following are the columns and their data types in the file:

a. timestamp - TIMESTAMP
b. latitude - float
c. longitude - float
d. visitorid - char(37)
e. accessed_from_mobile - boolean
f. browser_code - int
The columns which we need to copy to the table are the first four coumns : timestamp, latitude, longitude and visitorid.

NOTE: The file comes with a header. So use the ‘HEADER’ option in the ‘COPY’ command.

The problem may be solved by completing the following tasks:

Go to the SkillsNetwork Tools menu and start the Postgres SQL server if it is not already running.

Create a table named access_log to store the timestamp, latitude, longitude and visitorid.

Click here for Hint
Click here for Solution
Step 1: Open the Postgres SQL CLI, if it is not already open.

Step 2: At the postgres=# prompt, run the following command to connect to the database ‘template1’.


\c template1;




Step 3: Once you connect to the database, run the command to create the table called ‘access_log’:


CREATE TABLE access_log(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));




Task 3. Create a shell script named cp-access-log.sh and add commands to complete the remaining tasks to extract and copy the data to the database.

Create a shell script to add commands to complete the rest of the tasks.

Click here for Hint
Task 4. Download the access log file.

Add the wget command to the script to download the file.


wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"




Task 5. Unzip the gzip file.

Add the code, to run the gunzip command to unzip the .gz file and extract the .txt file, to the script.


2
# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz




The -f option of gunzip is to overwrite the file if it already exists.

Task 6. Extract required fields from the file.

Extract timestamp, latitude, longitude and visitorid which are the first four fields from the file using the cut command.

The columns in the web-server-access-log.txt file is delimited by ‘#’.

Click here for Hint
Click here for Solution
Step 1: Copy the following lines and add them to the end of the script.

1
2
3
4
5
6
7
8
# Extract phase
echo "Extracting data"
# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude) and
# 4 (visitorid)
cut -d"#" -f1-4 web-server-access-log.txt




Step 2: Save the file.

Step 3: Run the script.


bash cp-access-log.sh





Executed!
Verify that the output contains all the four fields that we extracted.

Task 7. Redirect the extracted output into a file.

Redirect the extracted data into a file named extracted-data.txt

Click here for Hint
Click here for Solution
Step 1: Replace the cut command at end of the script with the following command and save the file.


cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt




Step 2: Run the script.


bash cp-access-log.sh




Step 3: Run the command below to verify that the file extracted-data.txt is created, and has the content.


cat extracted-data.txt




Task 8. Transform the data into CSV format.

The extracted columns are separated by the original “#” delimiter.

We need to convert this into a “,” delimited file.

Click here for Hint
Click here for Solution
Step 1: Add the lines below at the end of the script.

1
2
3
4
5
6
# Transform phase
echo "Transforming data"
# read the extracted data and replace the colons with commas and
# write it to a csv file
tr "#" "," < extracted-data.txt > transformed-data.csv




Step 2: Save the file.

Step 3: Run the script.


bash cp-access-log.sh




Step 4: Run the command below to verify that the file ‘transformed-data.csv’ is created, and has the content.


cat transformed-data.csv




Task 9. Load the data into the table access_log in PostgreSQL

PostgreSQL command to copy data from a CSV file to a table is COPY.

The basic structure of the command is,


COPY table_name FROM 'filename' DELIMITERS 'delimiter_character' FORMAT;




The file comes with a header. So use the ‘HEADER’ option in the ‘COPY’ command.

Invoke this command from the shellscript, by sending it as input to ‘psql’ filter command.

Click here for Hint
Click here for Solution
Step 1: Add the lines below to the end of the script ‘cp-access-log.sh’ and save the file.

1
2
3
4
5
6
7
# Load phase
echo "Loading data"
# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.
echo "\c template1;\COPY access_log  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost




Task 10. Execute the final script.

Run the final script.

Click here for Solution
Run the following command at the terminal:


bash cp-access-log.sh




The completed bash script would be as below.

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".
# The script then extracts the .txt file using gunzip.
# The .txt file contains the timestamp, latitude, longitude
# and visitor id apart from other data.
# Transforms the text delimeter from "#" to "," and saves to a csv file.
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.
# Download the access log file
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"
# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz
# Extract phase
echo "Extracting data"
# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude) and
# 4 (visitorid)
cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt
# Transform phase
echo "Transforming data"
# read the extracted data and replace the colons with commas.
tr "#" "," < extracted-data.txt > transformed-data.csv
# Load phase
echo "Loading data"
# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.
echo "\c template1;\COPY access_log  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost




Task 11. Verify by querying the database.

Click here for Hint
Click here for Solution
Run the command below at Postgres SQL CLI prompt.


SELECT * from access_log;




You should see the records displayed on screen.
