# Cheat sheet to connect to a db

# sqlite3.connect()
# Create a new database and open a database connection to allow sqlite3 to work with it. Call  sqlite3.connect()  to create a connection to the database INSTRUCTOR.db in the current working directory, implicitly creating it if it does not exist.
import sqlite3
con = sqlite3.connect("INSTRUCTOR.db")

# Example of connecting to a database in python
data = pandas.read_sql_query(query_statement, connection_variable)
query_statement = "SELECT * FROM INSTRUCTOR"


