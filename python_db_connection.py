# Preventing Resource Leaks:
# Always Close Connections:

# Best Practice: Always close database connections in a finally block to ensure they are closed even if an exception occurs.
import mysql.connector

try:
    conn = mysql.connector.connect(user='user', password='password', host='localhost', database='database')
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM table_name")
    results = cursor.fetchall()
    for row in results:
        print(row)
except mysql.connector.Error as err:
    print(f"Error: {err}")
finally:
    if cursor:
        cursor.close()
    if conn:
        conn.close()


# Use Context Managers:

# Best Practice: Use context managers (with statements) to automatically manage resources.
# Example:
import mysql.connector

with mysql.connector.connect(user='user', password='password', host='localhost', database='database') as conn:
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM table_name")
        results = cursor.fetchall()
        for row in results:
            print(row)

# Connection Pooling:

# Best Practice: Use connection pooling to manage database connections efficiently.
from mysql.connector import pooling

dbconfig = {
    "database": "database",
    "user": "user",
    "password": "password",
    "host": "localhost"
}

pool = pooling.MySQLConnectionPool(pool_name="mypool", pool_size=3, **dbconfig)

try:
    conn = pool.get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM table_name")
    results = cursor.fetchall()
    for row in results:
        print(row)
except mysql.connector.Error as err:
    print(f"Error: {err}")
finally:
    if cursor:
        cursor.close()
    if conn:
        conn.close()

#Proper Error Handling:

# Best Practice: Implement robust error handling to ensure resources are released even when exceptions occur.
# Example
import mysql.connector

try:
    conn = mysql.connector.connect(user='user', password='password', host='localhost', database='database')
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM table_name")
    results = cursor.fetchall()
    for row in results:
        print(row)
except mysql.connector.Error as err:
    print(f"Error: {err}")
finally:
    if cursor:
        cursor.close()
    if conn:
        conn.close()

#### SQL Cheat Sheet: Accessing Databases using Python

# SQLite
connect()
sqlite3.connect() 	Create a new database and open a database connection to allow sqlite3 to work with it. Call  sqlite3.connect()  to create a connection to the database INSTRUCTOR.db in the current working directory, implicitly creating it if it does not exist.
import sqlite3
con = sqlite3.connect("INSTRUCTOR.db")

cursor()
con.cursor()
To execute SQL statements and fetch results from SQL queries, use a database cursor. Call  con.cursor()  to create the Cursor.
cursor_obj = con.cursor()

execute()
cursor_obj.execute()
The  execute  method in Python's SQLite library allows to perform SQL commands, including retrieving data from a table using a query like "Select * from table_name." When you execute this command, the result is obtained as a collection of table data stored in an object, typically in the form of a list of lists.
cursor_obj.execute('''insert into INSTRUCTOR values (1, 'Rav', 'Ahuja', 'TORONTO', 'CA')''')

fetchall()
cursor_obj.fetchall()
The  fetchall()  method in Python retrieves all the rows from the result set of a query and presents them as a list of tuples.
statement = '''SELECT * FROM INSTRUCTOR'''
cursor_obj.execute(statement)
output_all = cursor_obj.fetchall()
for row_all in output_all:
    print(row_all)

fetchmany()
cursor_obj.fetchmany()
The  fetchmany()  method retrieves the subsequent group of rows from the result set of a query rather than just a single row. To fetch a few rows from the table, use fetchmany(numberofrows) and mention how many rows you want to fetch.
statement = '''SELECT * FROM INSTRUCTOR'''
cursor_obj.execute(statement)
output_many = cursor_obj.fetchmany(2)
for row_many in output_many:
    print(row_many)

read_sql_query()
read_sql_query()
 read_sql_query()  is a function provided by the Pandas library in Python, and it is not specific to MySQL. It is a generic function used for executing SQL queries on various database systems, including MySQL, and retrieving the results as a Pandas DataFrame.
df = pd.read_sql_query("select * from instructor;", conn)

shape
dataframe.shape
It provides a tuple indicating the shape of a DataFrame or Series, represented as (number of rows, number of columns).
df.shape

close()
con.close()
con.close()  is a method used to close the connection to a MySQL database. When called, it terminates the connection, releasing any associated resources and ensuring the connection is no longer active. This is important for managing database connections efficiently and preventing resource leaks in your MySQL database interactions.
con.close()

CREATE TABLE
CREATE TABLE table_name ( column1 datatype constraints, column2 datatype constraints, ... );
The  CREATE TABLE  statement is used to define and create a new table within a database. It specifies the table's name, the structure of its columns (including data types and constraints), and any additional properties such as indexes. This statement essentially sets up the blueprint for organizing and storing data in a structured format within the database.
CREATE TABLE INTERNATIONAL_STUDENT_TEST_SCORES ( <br>
country VARCHAR(50),  <br>
first_name VARCHAR(50), <br>
last_name VARCHAR(50),  <br>
test_score INT
);

barplot()
seaborn.barplot(x="x-axis_variable", y="y-axis_variable", data=data)
 seaborn.barplot()  is a function in the Seaborn Python data visualization library used to create a bar plot, also known as a bar chart. It is particularly used to display the relationship between a categorical variable and a numeric variable by showing the average value for each category.
import seaborn
seaborn.barplot(x='Test_Score',y='Frequency', data=dataframe)

read_csv()
df = pd.read_csv('file_path.csv')
 read_csv()  is a function in Python's Pandas library used for reading data from a Comma-Separated Values (CSV) file and loading it into a Pandas DataFrame. It's a common method for working with tabular data stored in CSV format
import pandas
df = pandas.read_csv('https://data.cityofchicago.org/resource/jcxq-k9xf.csv')

to_sql()
df.to_sql('table_name', index=False)
df.to_sql()  is a method in Pandas, a Python data manipulation library used to write the contents of a DataFrame to a SQL database. It allows to take data from a DataFrame and store it structurally within a SQL database table.
import pandas
df = pandas.read_csv('https://data.cityofchicago.org/resource/jcxq-k9xf.csv')
df.to_sql("chicago_socioeconomic_data", con, if_exists='replace', index=False,method="multi")

read_sql()
df = pd.read_sql(sql_query, conn)
read_sql()  is a function provided by the Pandas library in Python for executing SQL queries and retrieving the results into a DataFrame from an SQL database. It's a convenient way to integrate SQL database interactions into your data analysis workflows.
selectQuery = "select * from INSTRUCTOR"
df = pandas.read_sql(selectQuery, conn)


