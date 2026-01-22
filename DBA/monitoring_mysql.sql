-- Lab: Monitor and optimize your database in MySQL

-- Maintain the health and performance of your database with phpMyAdmin
-- Identify the difference between an unoptimized and optimized database
-- Optimize your database with phpMyAdmin by applying best practices

-- source: https://dev.mysql.com/doc/world-setup/en/ under CC BY 4.0 License with Copyright 2021 - Statistics Finland.

-- get data:
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql

-- initiate mysql  ???
-- not sure how to do this step via terminal

-- create database world
CREATE DATABASE world;

-- use the newly created database, world
USE world;

-- In order to complete the database creation process, we’ll want to execute the MySQL script containing
-- the data that we downloaded. This file will create tables and insert data into those tables.
SOURCE world_mysql_script.sql;

-- want to execute the MySQL script containing the data that we downloaded.
--This file will create tables and insert data into those tables.
SOURCE world_mysql_script.sql;

-- What tables do we have?
SHOW TABLES;


