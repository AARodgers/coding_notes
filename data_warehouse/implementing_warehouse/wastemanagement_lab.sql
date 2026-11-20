Lab: assist a waste management company in Brazil in managing and analyzing their solid waste collection data.
The lab involves multiple stages, from designing and creating a star schema for the data warehouse, loading data,
writing complex SQL queries for data aggregation, and creating materialized view for query optimization.


You are a data engineer hired by a solid waste management company. It collects and recycles solid waste across major cities in the country of Brazil. They operate hundreds of trucks of different types to collect and transport solid waste. The company would like to create a data warehouse so that it can create reports like:

Total waste collected per year per city
Total waste collected per month per city
Total waste collected per quarter per city
Total waste collected per year per trucktype
Total waste collected per trucktype per city
Total waste collected per trucktype per station per city
You will use your data warehousing skills to design and implement a data warehouse for the company.

Learning objectives
After completing this lab, you will be able to:

Design a data warehouse.
Load data into the data warehouse.
Create a materialized view.

Tables in star schema:

MyDimDate

date_id
date
year
quater
quarter_name
month
month_name
day
weekday
weekday_name

MyDimWaste

waste_id
waste_type


MyDimZone

collection_zone
city
zone_id


MyFactTrips

trip_id
date_id
zone_id
waste_id
waste_collected_in_tons

Create MyDimDate table:

CREATE TABLE MyDimDate (
    date_id INT PRIMARY KEY,
    date DATE,
    year INT,
    quarter INT,
    quarter_name VARCHAR(20),
    month INT,
    month_name VARCHAR(20),
    day INT,
    weekday INT,
    weekday_name VARCHAR(20)
);

Create MyDimWaste table:

CREATE TABLE MyDimWaste (
    waste_id INT PRIMARY KEY,
    waste_type VARCHAR(50)
);

Create MyDimZone table:

CREATE TABLE MyDimZone (
    zone_id INT PRIMARY KEY,
    collection_zone VARCHAR(50),
    city VARCHAR(50)
);

Create MyFactTrips table:

CREATE TABLE MyFactTrips (
    trip_id INT PRIMARY KEY,
    date_id INT,
    zone_id INT,
    waste_id INT,
    waste_collected_in_tons DECIMAL(10, 2),
    FOREIGN KEY (date_id) REFERENCES MyDimDate(date_id),
    FOREIGN KEY (zone_id) REFERENCES MyDimZone(zone_id),
    FOREIGN KEY (waste_id) REFERENCES MyDimWaste(waste_id)
);
