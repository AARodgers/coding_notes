--Troubleshooting in PostgreSQL
--  most common problems encountered with databases are caused by poor performance, improper configuration, or poor connectivity

-- After completing this lab, you will be able to:

-- Enable error logging for your PostgreSQL instance.
-- Access server logs for troubleshooting.
-- Diagnose commonly encountered issues caused by poor performance, improper configuration, or poor connectivity.
-- Resolve common issues you may encounter as a database administrator.

1. Start an instance of a PostgreSQL database server. You can use a local installation or a cloud-based service like Amazon RDS, Google Cloud SQL, or Azure Database for PostgreSQL.
2. Connect to your PostgreSQL instance using a client tool such as psql, pgAdmin, or any other PostgreSQL client.
3. The file that you downloaded is a full database backup of a month of flight data in Russia. Now, you can perform a full restoration of the data set by first opening the PostgreSQL CLI.
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql
4. Open a PostgreSQL CLI and connect to your database instance. You can use the following command to connect to your database:
psql -h <hostname> -U <username> -d <database_name>
5. Once you are connected to your database, you can restore the data from the SQL file using the following command:
\i /path/to/flights_RUSSIA_small.sql
6. After the restoration is complete, you can verify that the data has been successfully imported by
running a simple query to check the number of records in the flights table:
SELECT COUNT(*) FROM flights;
7. Now that you have the data imported, you can start troubleshooting any issues you may encounter with the database. Here are some common troubleshooting steps you can take:
8. Verify database was created successfully and is running:
\dt
9.

Exercise 2: Enable Error Logging and Observe Logs
Task A: Enable Server Logging
2.First, to enable error logging on your PostgreSQL server instance, you will need to configure your server to support it. You can do so by using the Cloud IDE file explorer to open postgresql.conf, which stores the configuration parameters that are read upon server startup.
3.You can open the file by first opening the file explorer on Cloud IDE then selecting postgres > data > postgresql.conf.
4. With the configuration file open, scroll down to line 431. Replace logging_collector = off with logging_collector = on and uncomment the parameter by removing the # before the line.
5. Next, scroll down to line 441 and replace log_directory = 'log' with log_directory = '/var/log/postgresql' and uncomment the lin
6. Save the changes to postgresql.conf by either navigating to File > Save at the top toolbar or by pressing Ctrl + S (Mac: ⌘ + S).
7. After saving the changes, you will need to restart your PostgreSQL server instance for the changes to take effect. You can do this by running the following command in your terminal:
pg_ctl -D /path/to/your/data/directory restart
8. Once the server has restarted, go to PostgreSQL CLI
9. Confirm that the configuration parameter was successfully changed and loaded into the PostgreSQL instance by entering the following command into the CLI:
SHOW logging_collector;
10.

Task B: View the Server Logs

