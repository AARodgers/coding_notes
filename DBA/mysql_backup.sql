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
