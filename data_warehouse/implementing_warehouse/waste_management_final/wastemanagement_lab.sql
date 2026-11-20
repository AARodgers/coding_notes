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

=======================================================

ew DimDate table with this CSV data:
dateid,date,Year,Quarter,QuarterName,Month,Monthname,Day,Weekday,WeekdayName
1,2019-03-09,2019,1,Q1,3,March,9,7,Sunday

create DimDate table:

CREATE TABLE DimDate (
    dateid INT PRIMARY KEY,
    date DATE NOT NULL,
    "Year" INT NOT NULL,
    "Quarter" INT NOT NULL,
    QuarterName VARCHAR(10) NOT NULL,
    Month INT NOT NULL,
    Monthname VARCHAR(20) NOT NULL,
    Day INT NOT NULL,
    Weekday INT NOT NULL,
    WeekdayName VARCHAR(20) NOT NULL
);

New table DimStation with this CSV data:
Stationid,City
19,Sao Paulo

create DimStation table:
CREATE TABLE DimStation (
    Stationid INT PRIMARY KEY,
    City VARCHAR(50) NOT NULL
);

new table DimTruck with this CSV data:
Truckid,TruckType
115,Volvo

create DimTruck table:

CREATE TABLE DimTruck (
    Truckid INT PRIMARY KEY,
    TruckType VARCHAR(50) NOT NULL
);

new table FactTrips with this CSV data:
Tripid,Dateid,Stationid,Truckid,Wastecollected
23475,1,71,133,33.36
create FactTrips table:

CREATE TABLE FactTrips (
    Tripid INT PRIMARY KEY,
    Dateid INT NOT NULL,
    Stationid INT NOT NULL,
    Truckid INT NOT NULL,
    Wastecollected DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Dateid) REFERENCES DimDate(dateid),
    FOREIGN KEY (Stationid) REFERENCES DimStation(Stationid),
    FOREIGN KEY (Truckid) REFERENCES DimTruck(Truckid)
);

Create a grouping sets query using the columns stationid, trucktype, total waste collected.
SELECT
    s.Stationid,
    t.TruckType,
    SUM(f.Wastecollected) AS TotalWasteCollected
FROM
    FactTrips f
INNER JOIN
    DimTruck t ON f.Truckid = t.Truckid
GROUP BY GROUPING SETS (
    (s.Stationid, t.TruckType),
    s.Stationid,
    t.TruckType,
    ()
)
ORDER BY
    s.Stationid,
    t.TruckType;


Create a rollup query using the columns year, city, stationid, and total waste collected.


SELECT
    d.Year,
    s.City,
    f.Stationid,
    SUM(f.Wastecollected) AS TotalWasteCollected
FROM
    FactTrips f
INNER JOIN
    DimDate d ON f.Dateid = d.Dateid
INNER JOIN
    DimStation s ON f.Stationid = s.Stationid
GROUP BY ROLLUP (
    d.Year,
    s.City,
    f.Stationid
)
ORDER BY
    d.Year,
    s.City,
    f.Stationid;



/*How ROLLUP Aggregates This Hierarchy

Unlike GROUPING SETS, ROLLUP generates subtotals strictly from right to left based on the column order inside ROLLUP(...):
1. (Year, City, Stationid): Total waste for each individual station per city and year.
2. (Year, City): Subtotal for each city per year (rolling up all stations in that city).
3. (Year): Subtotal for each year (rolling up all cities in that year).
4. (): Overall grand total across all years, cities, and stations.*/

Create a cube query using the columns year, city, stationid, and average waste collected.

SELECT
    d.Year,
    s.City,
    f.Stationid,
    AVG(f.Wastecollected) AS AverageWasteCollected
FROM
    FactTrips f
INNER JOIN
    DimDate d ON f.Dateid = d.Dateid
INNER JOIN
    DimStation s ON f.Stationid = s.Stationid
GROUP BY CUBE (
    d.Year,
    s.City,
    f.Stationid
)
ORDER BY
    d.Year,
    s.City,
    f.Stationid;

/* To calculate the average waste collected across every possible combination of Year, City, and Stationid, replace ROLLUP with CUBE and SUM with AVG.*/
/*
While ROLLUP only moves hierarchically from right to left (4 grouping combinations), CUBE generates all \(2^3 = 8\) possible combinations of your three columns:
1. (Year, City, Stationid) — Average per station, city, and year
2. (Year, City) — Average per city and year
3. (Year, Stationid) — Average per station and year
4. (City, Stationid) — Average per station and city (across all years)
5. (Year) — Average per year
6. (City) — Average per city (across all years)
7. (Stationid) — Average per station (across all years)
8. () — Overall grand average across the entire table
*/


