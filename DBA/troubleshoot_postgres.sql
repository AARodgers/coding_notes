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
1. You will see a file with a name of the form postgresql-YYYY-MM-DD-<numbers>.log. Go ahead and open it.
2. Inspect and familiarize yourself with the logs given for a PostgreSQL server startup. Every time you start the server again, a new .log file will be created in the log folder.

Exercise 3: Test the Performance of the PostgreSQL Server
-- common problems encountered with databases are caused by poor performance, improper configuration, or poor connectivity.
--Server configuration issues, such as inadequate hardware resources or misconfigured settings, can significantly impact performance
-- gain some hands-on experience in studying the performance of the PostgreSQL server and inspecting the logs to identify and resolve slow performance and connection disruptions.
1. In this task, you will first delete the postgresql.conf file and replace it with a new configuration file that has some parameters changed.
2.download a new postgresql.conf configuration file:
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/PostgreSQL/Lab%20-%20Troubleshooting/postgresql.conf
3. Open up the file explorer on Cloud IDE and navigate to postgres > data.
4.Right-click postgresql.conf in this directory and select Delete.
5. In the file explorer, you will see the postgresql.conf file you downloaded in Step 1 sitting in the root directory. Drag it into the postgres > data directory, as shown below.
6. Now go ahead and start up the PostgreSQL server again by selecting the Start button.

Task B: Test the Performance of the Server
-- you will run a few SQL commands and analyze the server’s performance, inspect the error logs, then finally, identify and resolve issues that could be hindering the performance of the database.
1. In the CLI, connect to your database instance
\connect demo
2. To inspect how long each query or command takes, enable the timer with the following command in the CLI:
\timing
3.Let’s start off with a very simple query on the aircrafts_data table. Enter the following into the CLI:
SELECT * FROM aircrafts_data;
--query was on a small table and was quick--only about 1 millisecond.
4. Let’s try something a little more computationally heavy and see how the server handles it. The following command goes through each element in the boarding_passes table and reassigns each value to itself. In other words, it does not change the table but allows you to see how the server handles this task
UPDATE boarding_passes SET ticket_no = ticket_no, flight_id = flight_id, boarding_no = boarding_no, seat_no = seat_no;
-- This heavier command took almost a minute to execute–a fairly long time, but the server was nonetheless able to complete the command. Still, you may want to improve this performance.
5. as the database administrator, you will likely not be the only one who needs to access the database you are working with. Other users will likely need to connect to the database for a wide variety of reasons, including retrieving and inputting data. Let’s simulate additional users connecting to the database. You can do this by opening additional PostgreSQL CLI terminals in Cloud IDE, as each one establishes a new connection to the server. Click PostgreSQL CLI three times, opening three new CLI terminals:
-- will get an error "too many clients"

Exercise 4: Troubleshoot
In the previous exercise, you encountered a problem and the server shut down. Now it’s time to figure out what happened, why it happened, and how to fix it so that it does not happen again.
1.First, let’s check the server logs to see what happened. Open up the Cloud IDE file explorer and navigate to postgres > data > log.

2.Since you restarted the server in the previous exercise, a new log file will have been created for this new session. Open up the most recent one.

3.Inspect the most recent logs, as you encountered the problem in Exercise 3.
4. You should see an error message that says something like FATAL: too many clients
Some of the most common connectivity problems are not being able to connect to the database server, the database server or instance not running properly, and client login credentials being incorrect.​ You can likely rule out the last two, since the login credentials are automatically inputted for us on Cloud IDE and you know that the server instance is running properly, since you are already connected to it on 3 other terminals. This likely means you could be experiencing some problems connecting to the database server when you open the fourth connection. But why is this?

Server configuration issues, such as inadequate hardware resources or misconfigured settings, can significantly impact performance.​ Perhaps this could explain the connection problem as well as the slow performance you saw on the database query in Exercise 3. Let’s take a look at the server configuration and see if you can spot anything.

Using the Cloud IDE file explorer, navigate to postgres > data and open the postgresql.conf configuration file.

5. If you scroll down to line 64 of the file, you will find max_connections = 4.

Task B: Resolve the Issue
6. Change max_connections = 4 to max_connections = 10 and save the file.
7. Restart the PostgreSQL server instance for the changes to take effect by running the following command in your terminal:
pg_ctl -D /path/to/your/data/directory restart
8. Now, try opening a new PostgreSQL CLI terminal and connecting to the database instance again. You should now be able to connect without any issues, as the max_connections parameter has been increased
9. Since the server can now support far more connections than before, it will also need more available memory to support these connections. The shared_buffers configuration parameter sets the amount of memory the database server has at its disposal for shared memory buffers. Scroll down to line 121 to find the shared_buffers parameter.

10. Change shared_buffers = 128MB to shared_buffers = 256MB and save the file.
11. While you’re at it, you can also increase the server performance so that the slow query you executed in Exercise 3 will run more quickly. Increase the work_mem parameter from the minimum 64kB to 4MB.
12.Change the maintenance_work_mem from the minimum 1MB to a more standard 64MB.

Save the changes to postgresql.conf by either navigating to File > Save at the top toolbar or by pressing Ctrl + S (Mac: ⌘ + S).


