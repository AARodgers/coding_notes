# conducting thorough data quality checks in a data warehousing environment
# using a Python-based framework within a PostgreSQL database to validate data integrity
# automated data quality checks,

-- Check Null values
-- Check Duplicate values
-- Check Min Max
-- Check Invalid values
-- Generate a report on data quality

# 1. Start Postgres server
# 2. open new terminal window
3. download staging area setup script
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/8ZUkKar_boDbhNgMiwGAWg/setupstagingarea.sh

4. run to setup staging area
bash setupstagingarea.sh

5. download testing framework
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/dataqualitychecks.py

wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/HB0XK4MDrGwigMmVPmPoeQ/dbconnect.py

wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/mytests.py

wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/saTxV8y9Kt-e8Zxe29M0TA/generate-data-quality-report.py

ls

6. install python driver for PostgreSQL database
python3 -m pip install psycopg2

7. update password in dbconnect.py

import os
import psycopg2
pgpassword = "<replace this with your postgres password>"
conn = None
try:
    conn = psycopg2.connect(
        user = "postgres",
        password = pgpassword,
        host = "postgres",
        port = "5432",
        database = "postgres")
except Exception as e:
    print("Error connecting to data warehouse")
    print(e)
else:
    print("Successfully connected to warehouse")
finally:
    if conn:
        conn.close()
        print("Connection closed")


# generate_data_quality_report.py

import os
import psycopg2
import pandas as pd
from tabulate import tabulate

import mytests
# import the data quality checks
from dataqualitychecks import check_for_nulls
from dataqualitychecks import check_for_min_max
from dataqualitychecks import check_for_valid_values
from dataqualitychecks import check_for_duplicates
from dataqualitychecks import run_data_quality_check

# connect to database
pgpassword = "<replace this with your postgres password>"
conn = psycopg2.connect(
		user = "postgres",
	    password = pgpassword,
	    host = "postgres",
	    port = "5432",
	    database = "billingDW")

print("Connected to data warehouse")

#Start of data quality checks
results = []
tests = {key:value for key,value in mytests.__dict__.items() if key.startswith('test')}
for testname,test in tests.items():
    test['conn'] = conn
    results.append(run_data_quality_check(**test))

#print(results)
df=pd.DataFrame(results)
df.index+=1
df.columns = ['Test Name', 'Table','Column','Test Passed']
print(tabulate(df,headers='keys',tablefmt='psql'))
#End of data quality checks
conn.close()
print("Disconnected from data warehouse")

8. Check:

if the Postgresql python driver is installed properly.
if Postgresql server is up and running.
if our micro framework can connect to the database.

python3 dbconnect.py
# The command also disconnects from the server with a message Connection closed.


9. install pandas
python3 -m pip install pandas tabulate


10. Run the command below to generate a sample data quality report.


python3 generate-data-quality-report.py

11. explore data quality reports: mytests.py
from dataqualitychecks import check_for_nulls
from dataqualitychecks import check_for_min_max
from dataqualitychecks import check_for_valid_values
from dataqualitychecks import check_for_duplicates


test1={
	"testname":"Check for nulls",
	"test":check_for_nulls,
	"column": "monthid",
	"table": "DimMonth"
}


test2={
	"testname":"Check for min and max",
	"test":check_for_min_max,
	"column": "month",
	"table": "DimMonth",
	"minimum":1,
	"maximum":12
}


test3={
	"testname":"Check for valid values",
	"test":check_for_valid_values,
	"column": "category",
	"table": "DimCustomer",
	"valid_values":{'Individual','Company'}
}


test4={
	"testname":"Check for duplicates",
	"test":check_for_duplicates,
	"column": "monthid",
	"table": "DimMonth"
}

/*
The file mytests.py contains all the data quality tests.

It provides a quick and easy way to author and run new data quality tests.

The testing framework provides the following tests:

check_for_nulls - this test will check for nulls in a column
check_for_min_max - this test will check if the values in a column are with a range of min and max values
check_for_valid_values - this test will check for any invalid values in a column
check_for_duplicates - this test will check for duplicates in a column
Each test can be authored by mentioning a minimum of 4 parameters.

testname - The human readable name of the test for reporting purposes
test - The actual test name that the testing micro framework provides
table - The table name on which the test is to be performed
column - The table name on which the test is to be performed
*/


All tests must be named as test following by a unique number to identify the test.

Give an easy to understand description for testname
mention check_for_nulls for test
mention the column name on which you wish to check for nulls
mention the table name where this column exists
Let us now create a new check_for_nulls test and run it.

The test below checks if there are any null values in the column year in the table DimMonth.

The test fails if nulls exist.

Copy and paste the code below at the end of mytests.py file.

test5={
    "testname":"Check for nulls",
    "test":check_for_nulls,
    "column": "year",
    "table": "DimMonth"
}

generate the new data quality report.

python3 generate-data-quality-report.py


test6={
    "testname":"Check for min and max",
    "test":check_for_min_max,
    "column": "quarter",
    "table": "DimMonth",
    "minimum":1,
    "maximum":4
}

In addition to the usual fields, you have two more fields here.

minimum is the lowest valid value for this column. (Example 1 in case of month number)
maximum is the highest valid value for this column. (Example 12 in case of month number)
Let us now create a new check_for_min_max test and run it.

The test below checks for minimum of 1 and maximum of 4 in the column quarter in the table DimMonth.

The test fails if there any values less than minimum or more than maximum.

Copy and paste the code below at the end of mytests.py file.

Let us now see what a check_for_valid_values test looks like.

Here is a sample check_for_valid_values test:

test3={
    "testname":"Check for valid values",
    "test":check_for_valid_values,
    "column": "category",
    "table": "DimCustomer",
    "valid_values":{'Individual','Company'}
}

In addition to the usual fields, you have an additional field here.

use the field valid_values to mention what are the valid values for this column.
Let us now create a new check_for_valid_values test and run it.

The test below checks for valid values in the column quartername in the table DimMonth.

The valid values are Q1,Q2,Q3,Q4

The test fails if there any values less than minimum or more than maximum.

Copy and paste the code below at the end of mytests.py file.

test7={
    "testname":"Check for valid values",
    "test":check_for_valid_values,
    "column": "quartername",
    "table": "DimMonth",
    "valid_values":{'Q1','Q2','Q3','Q4'}
}

Let us now create a new check_for_duplicates test and run it.

The test below checks for any duplicate values in the column customerid in the table DimCustomer.

The test fails if duplicates exist.

test8={
    "testname":"Check for duplicates",
    "test":check_for_duplicates,
    "column": "customerid",
    "table": "DimCustomer"
}


