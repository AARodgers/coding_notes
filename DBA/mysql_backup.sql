Backup and Restore using MySQL
--Perform a Logical Backup and Restore
-- The World database used in this lab comes from the following source: https://dev.mysql.com/doc/world-setup/en/

In this practice exercise, you will practice performing a logical backup and restore of a database table.

Scenario: You are planning to update and migrate one of the tables from your world database to a new MySQL server. Perform a logical backup of the table city from the database world. The backup table is expected to contain data of Bangladesh. Validate if your created backup is in working state.

Hint (Click Here)
Solution (Click Here)
Fetch the necessary scripts files to the Cloud IDE user session storage using Cloud IDE Terminal.

world_mysql_script.sql


wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql




world_mysql_update_1.sql


wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_update_1.sql




Create a new database with any name like world_P1 using MySQL CLI.


create database world_P1;





use world_P1;




Use world_mysql_script.sql script to complete the world_P1 database creation process.


source world_mysql_script.sql;




Try to retrieve all the records with BGD countrycode from the city table.


SELECT * FROM city WHERE countrycode='BGD';




If you fail, try updating the database using world_mysql_update_1.sql script.


source world_mysql_update_1.sql;





SELECT * FROM city WHERE countrycode='BGD';




Perform a logical backup of the city table.


\q





mysqldump --host=mysql --port=3306 --user=root --password world_P1 city > world_P1_city_mysql_backup.sql




Drop the city table and try to restore it with the backup you created to validate if your created backup is in working state.


mysql --host=mysql --port=3306 --user=root --password --execute="DROP TABLE world_P1.city;"
mysql --host=mysql --port=3306 --user=root --password --execute="SELECT * FROM world_P1.city;"
mysql --host=mysql --port=3306 --user=root --password world_P1 < world_P1_city_mysql_backup.sql
mysql --host=mysql --port=3306 --user=root --password --execute="SELECT * FROM world_P1.city;"
Full Backups and Incremental Backups:
PITR relies on both full backups and incremental backups to provide a comprehensive recovery solution. These two types of backups work together to ensure that you can restore your database to any specific point in time.

Full Backups
A full backup captures the entire database at a specific point in time. It includes all the data, schema, and configurations necessary to restore the database to that state. Full backups serve as the foundation for PITR and are typically performed periodically (e.g., daily or weekly) to ensure that there is a recent baseline from which to start the recovery process.

Incremental Backups
Incremental backups capture only the changes made to the database since the last backup (full or incremental). This approach reduces the amount of data that needs to be backed up, saving time and storage space. In MySQL, binary logs are crucial for incremental backups as they record all database changes.

Binary Logs
Binary logs in MySQL are essential for PITR. They record all database changes (e.g., INSERT, UPDATE, DELETE statements) in a binary format. These logs enable the replay of changes during recovery, allowing you to restore the database to any specific point in time by applying the changes recorded after the last full backup.

How Binary Logs Work
. Enable Binary Logging: Binary logging must be enabled on the MySQL server. This can be done by adding the log_bin directive to the MySQL configuration file (my.cnf) and restarting the MySQL server.

2. Recording Changes: Once binary logging is enabled, MySQL starts recording all changes to the database in binary log files. Each log file is given a sequential number (e.g., mysql-bin.000001, mysql-bin.000002).

3. Managing Log Files: As the number of binary log files increases, it’s important to manage them to prevent disk space issues. MySQL provides options to purge old binary logs that are no longer needed.

4. Point-in-Time Recovery: To perform a point-in-time recovery, you first restore the database from the most recent full backup. Then, you apply the changes recorded in the binary logs to bring the database to the desired state.

Practical Steps for Point-in-Time Backup and Restore:
Let us explore a scenario where you are tasked with taking a point in time backup of the MySQL server that houses a database named world. Within this database, you will encounter tables like cities, countries and languages, each holding data related to cities, countries and languages spoken worldwide.This exercise will build upon the world database created in the previous exercise: Backup and Restore Using MySQL.

Say you have a full logical backup of your whole database in your last mysqldump file as of yesterday evening. However, several changes may have been made (including data loss) since then. Using point-in-time backup and restore, you can get each and every change that occurred since then, so that even after your last logical backup you have a record of all new transactions. Point-in-time backup is the set of binary log files generated subsequent to a logical backup operation of a database. The binary log files contain events that describe database changes such as table creation operations or changes to table data. To restore a database to a point-in-time, you will be using binary log files containing changes of a database for a time interval along with the last logical backup of the database.

Performing Point-in-Time Backup:
Download the required SQL script file in the linux terminal by executing the command below:


wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql




Download the required SQL script file in the linux terminal by executing the command below:


wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_update_A.sql




Download the required SQL script file in the linux terminal by executing the command below:


wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_update_B.sql




Once executed, the above commands will fetch the SQL script file from the internet and save it to the current directory on your local machine.

Pre-requisite: To interact with MySQL databases on your local machine, you need to install and start the MySQL server. To install the MySQL server run the following command:


sudo apt-get install mysql-server




This command will prompt you to enter your password, and once you confirm, it will download and install the MySQL server package along with any necessary dependencies.

Note: In case you encounter errors regarding unreachable packages, execute the command sudo apt update to fetch the most recent information concerning available packages and their versions from the repositories set up on your system. Once done you can then execute the command to install the mysql-server.

Start the MySQL service using the command:


sudo systemctl start mysql




This command is used to start the MySQL service on a system running systemd, which is a system and service manager for Linux.

Here's what each part of the command does:

sudo: This prefix grants temporary administrative privileges to the command that follows it. It allows the user to execute the subsequent command with superuser (root) privileges.

systemctl: This is a command-line utility used to manage systemd, which is a system and service manager for Linux operating systems. It allows users to start, stop, enable, disable, and manage services and other units.

start: This subcommand of systemctl instructs systemd to start the specified service. In this case, mysql refers to the MySQL service.

Next, to access the MySQL CLI(Command Line Interface), you can use the command below in the terminal:


sudo mysql -u root -p




Here's what each part of the command does:

mysql: This is the command used to launch the MySQL command-line interface.

-u root: This option specifies the username to use when connecting to the MySQL server. In this case, it specifies that the root user should be used.

-p: This option prompts the user to enter the password for the specified MySQL user (in this case, the root user). After entering the password, if it's correct, the user gains access to the MySQL CLI with administrative privileges.

Create a new database world using the command below in the terminal:


create database world;




To use the newly created world database of previous exercise, use the command below in the terminal:


use world;




Execute the world mysql script (world_mysql.sql) to complete the world database creation process using the command below in the terminal:


source world_mysql_script.sql;




List all the table names from the world database:


SHOW TABLES;




Retrieve all records from the city table where the countrycode is ‘CAN’:


SELECT * FROM city WHERE countrycode='CAN';




You will observe the returned result set is empty set. This means Canada related records are currently absent from the table. Run the update script (world_mysql_update_A.sql) to insert the records you were looking for.


source world_mysql_update_A.sql;




Redo the previous step to verify the insertion of Canada-related records:


SELECT * FROM city WHERE countrycode='CAN';




Once the operation is completed, we can quit from the MySQL command line interface using the command \q in the terminal.


\q




Next, create a full logical backup of the current state of your whole world database. Use the command below in the terminal (enter your MySQL service session password from the MySQL service session tab if necessary):


sudo mysqldump  --user=root --password --flush-logs --delete-master-logs --databases world > world_mysql_full_backup.sql




Note: The –flush-logs and –delete-master-logs parameters ensure that new binary log files are created after the full backup.

Next, to access the MySQL CLI(Command Line Interface), you can use the command below in the terminal:


sudo mysql -u root -p




To use the already created above world database, use the command below in the terminal:


use world;




List all the table names from the world database:


SHOW TABLES;




Retrieve all records from the city table where the countrycode is ‘CAN’:


SELECT * FROM city WHERE countrycode='CAN';




You will observe the returned result set is empty set. This means Canada related records are currently absent from the table.Run the update script (world_mysql_update_B.sql) to insert the records you were looking for.


source world_mysql_update_B.sql;




Redo the previous step to verify the insertion of Canada-related records:


SELECT * FROM city WHERE countrycode='CAN';




Once the operation is completed, we can quit from the MySQL command line interface using the command \q in the terminal.


\q




Simulate a Database Crash:
Now you will create a scenario where a database crash will be conducted intentionally which will result a significant loss of your world database files.To simulate a database crash and create a scenario for recovery, execute the following commands to stop the MySQL service and remove the database files:

Stop the MySQL service using the following command:


sudo systemctl stop mysql




Here's what each part of the command does:

systemctl: This is a command-line utility used to manage systemd, which is a system and service manager for Linux operating systems. It allows users to start, stop, enable, disable, and manage services and other units.

stop: This subcommand of systemctl instructs systemd to stop the specified service. In this case, mysql refers to the MySQL service.

Remove the world database files using following command:


sudo rm -rf /var/lib/mysql/world




The rm -rf command removes the world directory and all of its contents recursively and forcefully. This includes all the data files, subdirectories, and any other files related to the world database within the MySQL data directory.

Try to retrieve records from any table of the database:


sudo mysql --user=root --password --execute="SELECT * FROM world.city;"




You will face errors since a significant loss of your world database files happened. Now you have to restore the world database along with the updates you made earlier in this exercise running the update script (world_mysql_update_B.sql).

Display the binary logs using the command below in the terminal:


sudo mysql --user=root --password --execute="SHOW BINARY LOGS;"




Write the contents of all binary log files listed above to a single file using the command below in the terminal:


sudo mysqlbinlog /var/lib/mysql/binlog.000003 /var/lib/mysql/binlog.000004 > logfile.sql




Here's what each part of the command does:

Read Binary Log Files: The mysqlbinlog utility reads the specified binary log files (binlog.000003 and binlog.000004).
Convert to SQL Statements: mysqlbinlog converts the binary format of the log files into readable SQL statements. These statements represent the database changes recorded in the logs.
Redirect Output: The SQL statements are redirected and saved into a file named logfile.sql.
Performing Point-in-Time Recovery:
You are ready to perform point-in-time restore. First restore the full logical backup of your whole world database you created earlier in this exercise using the command below in the terminal (enter your MySQL service session password from the MySQL service session tab if necessary):


sudo mysql --user=root --password < world_mysql_full_backup.sql




To verify if you have the updates from the update script (world_mysql_update_B.sql), retrieve all the Canada (countrycode=’CAN’) related records from the city table using the command below in the terminal (enter your MySQL service session password from the MySQL service session tab if necessary):


sudo mysql --user=root --password --execute="SELECT * FROM world.city WHERE countrycode='CAN';"




Now run the logfile you created in step-14 using the command below in the terminal:


sudo mysql --user=root --password < logfile.sql




Redo previous step to verify if you have the updates from the update script (world_mysql_update_B.sql).


sudo mysql --user=root --password --execute="SELECT * FROM world.city WHERE countrycode='CAN';"




Finally through the point-in-time recovery, you have the world database in the same state before you conducted the intentional crash scenario.

================================================================

Performing MySQL Physical Backup and Restoration
A physical backup involves duplicating all the physical storage components, such as files and directories, of a specific table, database, or other objects within a database system. These components include essential elements like data files, configuration files, and log files, capturing the entire storage structure as it exists on the disk.

Compared to logical backups, which involve exporting data in a structured format, physical backups are generally more compact and quicker to execute. This makes them particularly well-suited for scenarios where large or critical databases must be backed up swiftly and efficiently.

Common Techniques for Physical Backups:
This section explores various methods and techniques used for performing physical backups in database systems.

File-based Backups: This technique involves copying database files directly from disk to backup storage. It is a straightforward approach but may require downtime or database locking during backup operations.
This typically includes data files, control files, and archived redo logs.

Example: In an Oracle database environment, a file-based backup might involve copying the data files (.dbf files), control files (controlfile.ctl), and archived redo logs (*.arc) to a backup destination using operating system utilities like cp (copy) or rsync.

Block-level Backups: Block-level backups operate at a lower level, capturing data at the disk block level rather than file level. This technique allows for incremental backups, where only changed blocks are backed up, reducing backup time and storage requirements.

Example: In a PostgreSQL database, block-level backups can be achieved using tools like pg_basebackup or third-party solutions that utilize PostgreSQL’s write-ahead logging (WAL) mechanism to capture changed blocks since the last backup.

Online Backups: Online backups enable database backups to be performed while the database remains operational, minimizing downtime and disruptions to business operations.

Example: In a MySQL database, online backups can be achieved using tools like mysqldump for logical backups or Percona XtraBackup for physical backups. These tools allow backups to be taken without locking tables, ensuring that the database remains accessible to users during the backup process.

Snapshot Backups: Snapshot backups use storage snapshots to create point-in-time copies of the database. This technique provides a consistent view of the database without interrupting ongoing transactions.

This approach is sometimes used in the cloud by taking snapshots of Cloud based storage volumes, and restarting the database on a different VM.

Example: In a Microsoft SQL Server environment, snapshot backups can be created using storage technologies such as Storage Spaces Direct (S2D) or SAN/NAS-based snapshot solutions. These technologies leverage the storage infrastructure to create instant, space-efficient snapshots of database volumes.

Backup Compression: Compressing backup files reduces storage space requirements and improves backup efficiency without sacrificing data integrity.

Example: In a MongoDB database, backup compression can be enabled using built-in compression options in backup utilities like mongodump or by utilizing third-party backup solutions that offer compression features.

Best Practices for Physical Backups:
This section offers recommendations and guidelines for implementing and managing physical backup strategies effectively.

Regular Backup Schedule: Here a regular backup schedule is established based on business requirements and data sensitivity. Consider factors such as data volatility, recovery time objectives (RTO), and recovery point objectives (RPO).

Offsite Storage: Store backup copies in secure, offsite locations to protect against site-wide disasters such as fires, floods, or theft.

Backup Verification: Regularly test backup files so that we can ensure that they are valid files,thus enabling successful restoration. Verification helps identify any issues with backup processes or storage media before they become critical.

Retention Policies: Define retention policies for backup files based on compliance requirements, regulatory standards, and business needs. Retain backups for an appropriate duration to support data recovery and legal obligations.

Encryption: Implement encryption for backup data in transit as well as at rest to safeguard sensitive information from unauthorized access or data breaches.

Monitoring and Alerting: Here, monitoring and alerting mechanisms are set up to track backup performance, storage usage, and potential issues. Proactive monitoring helps identify and address backup failures or anomalies promptly.

An Overview of Key Linux Commands used for Conducting Physical Backup and Restoration of MySQL Database
Let us explore a scenario where you are tasked with taking a complete physical backup of the MySQL server that houses a database named world. Within this database, you will encounter tables like cities, countries and languages, each holding data related to cities, countries and languages spoken worldwide.
The necessary SQL statements related to this data is present in a sql script file world_mysql_script.sql.

You can first download this script in the linux terminal by executing the command below:

1
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql




Once executed, this command will fetch the SQL script file from the internet and save it to the current directory on your local machine.

Pre-requisite: To interact with MySQL databases on your local machine, you need to install and start the MySQL server. To install the MySQL server run the following command:

1
sudo apt-get install mysql-server




This command will prompt you to enter your password, and once you confirm, it will download and install the MySQL server package along with any necessary dependencies.

Note: In case you encounter errors regarding unreachable packages, execute the command sudo apt update to fetch the most recent information concerning available packages and their versions from the repositories set up on your system. Once done you can then execute the command to install the mysql-server.

After the installation start the MySQL service using the command:

1
sudo systemctl start mysql




This command is used to start the MySQL service on a system running systemd, which is a system and service manager for Linux.

Here's what each part of the command does:

sudo: This prefix grants temporary administrative privileges to the command that follows it. It allows the user to execute the subsequent command with superuser (root) privileges.

systemctl: This is a command-line utility used to manage systemd, which is a system and service manager for Linux operating systems. It allows users to start, stop, enable, disable, and manage services and other units.

start: This subcommand of systemctl instructs systemd to start the specified service. In this case, mysql refers to the MySQL service.

Next, to access the MySQL CLI(Command Line Interface), you can use the command below in the terminal:

1
sudo mysql -u root -p




Here's what each part of the command does:

mysql: This is the command used to launch the MySQL command-line interface.

-u root: This option specifies the username to use when connecting to the MySQL server. In this case, it specifies that the root user should be used.

-p: This option prompts the user to enter the password for the specified MySQL user (in this case, the root user). After entering the password, if it's correct, the user gains access to the MySQL CLI with administrative privileges.

Create the database and navigate to the database using the commands below in the terminal:

1
2
create database world;
use world;




Use world_mysql_script.sql script to complete the world database creation process. This script holds the data of the tables cities ,countries and languages.

1
source world_mysql_script.sql;




This command will execute all the SQL commands contained in the script file within the MySQL command-line interface.

Once the operation is completed, we can quit from the MySQL command line interface using the command \q in the terminal.

Before taking the backup we need to stop the MySQL service using the command below:

1
sudo systemctl stop mysql




Here's what each part of the command does:

systemctl: This is a command-line utility used to manage systemd, which is a system and service manager for Linux operating systems. It allows users to start, stop, enable, disable, and manage services and other units.

stop: This subcommand of systemctl instructs systemd to stop the specified service. In this case, mysql refers to the MySQL service.

You can then perform a backup of the complete database using the command below to recursively copy all the directories and subdirectories of the MySQL data directory to the specified backup directory:

1
sudo cp -R /var/lib/mysql /path/to/backup_directory




Here's what each part of the command does:

cp: This is the command used to copy files and directories.

-R: This option is used to specify a recursive copy, meaning it will copy the specified directory and all of its contents, including subdirectories and files.

/var/lib/mysql: MySQL data files, including databases, tables, and other related files are present in this directory.

/path/to/backup_directory: This is the destination directory where the MySQL data directory will be copied. You should replace “/path/to/backup_directory” with the directory which you want the backup to be stored.

To verify the successful creation of the backup in the designated backup directory, execute the following command in the terminal:

1
sudo ls -l /path/to/backup_directory




This will list detailed information about the contents of the specified backup directory and you can view MySQL database related files here.

You can restore the MySQL database from the backup by following the commands below:

1
sudo mv /var/lib/mysql /var/lib/mysql_old




This command will rename the current MySQL data directory /var/lib/mysql to /var/lib/mysql_old

Next, we can recursively copy the contents of the backup directory which we created earlier into the MySQL data directory by using the command below:

1
sudo cp -R /path/to/backup_directory /var/lib/mysql




Note: Please be aware that during the restoration of the backup, you might encounter insufficient space on the device. This can happen if the backup file or the data being restored exceeds the available disk space on the device where MySQL is installed or where the backup is being restored. It’s essential to ensure that there is enough disk space available to accommodate the restoration process to avoid encountering this error.

We can change the ownership of the MySQL data directory and all its contents recursively to the user mysql and the group mysql as below:

1
sudo chown -R mysql:mysql /var/lib/mysql




Here's what each part of the command does:

chown: Stands for change ownership, a command used to change the ownership of files or directories in Linux.

-R: Specifies a recursive operation,including subdirectories and files.

mysql:mysql: Specifies the new owner and group for the directory and its contents. In this case, it sets the user to “mysql” and the group to “mysql”.

/var/lib/mysql: Specifies the directory whose ownership will be changed. This is typically the MySQL data directory.

Once completed you can restart the MySQL service using the command: sudo systemctl start mysql
