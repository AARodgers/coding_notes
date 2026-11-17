/* Practice Implementing a Data Warehouse */

Designing and implementing a data warehouse. You have been hired as a data engineer for a
consumer electronics retail company And the company wants you to create and implement a
data warehouse to analyze its sales performance and inventory management.

designing and implementing a star schema
SQL queries, including grouping sets, rollups, and cubes, essential for
data analysis and reporting
practice in data loading and transformation
use PostgreSQL Database

The company wants to create a data warehouse to analyze its sales performance and inventory management and aim to generate reports, such as:

Total sales revenue per year per city
Total sales revenue per month per city
Total sales revenue per quarter per city
Total sales revenue per year per product category
Total sales revenue per product category per city
Total sales revenue per product category per store
Learning objectives
After completing this lab, you will be able to:

Develop dimension and fact tables to organize and structure data effectively for analysis
Employ SQL queries to create and load data into dimension and fact tables
Create materialized views to optimize query performance

Exercise 1: Design a data warehouse
Sales ID	Product Type	Price Per Unit	Quantity Sold	City	Date
001	Electronics	$299.99	30	New York	2024-04-01
002	Apparel	$49.99	50	Los Angeles	2024-04-01
003	Furniture	$399.99	10	Chicago	2024-04-02
004	Electronics	$199.99	20	Houston	2024-04-02
005	Groceries	$2.99	100	Miami	2024-04-03
Task 1: Design the dimension table MyDimDateTask 1 - Design the dimension table MyDimDate
Write down the fields in the MyDimDate table in any text editor, one field per line. The company is looking at a granularity of day, which means they would like to have the ability to generate the report on a yearly, monthly, daily, and weekday basis.
Here is a partial list of fields to serve as an example:

dateid
month
monthname
…

Solution
Fields in MyDimDate table:

dateid
year
month
monthname
day
weekday
weekdayname
The table will have a unique identifier (dateid) for each date entry. Other fields such as year, month, monthname, day, weekday, and weekdayname will provide detailed information about each date, allowing for flexible reporting options based on different time intervals.

Task 2: Design the dimension table MyDimProduct
Write down the fields in the MyDimProduct table in any text editor, one field per line.

Solution:
In this task, you will design the dimension table MyDimProduct to store product-related information.

Fields in MyDimProduct table:

productid
productname
The table will have a unique identifier (productid) for each product entry. The field productname will store the name or description of the product. This table will facilitate analysis and reporting based on different products sold.

Task 3: Design the dimension table MyDimCustomerSegment
Write down the fields in the MyDimCustomerSegment table in any text editor, one field per line.

Solution:
In this task, you will design the dimension table MyDimCustomerSegment to store customer segment-related information.

Fields in DimCustomerSegment table:

segmentid
segmentname
Task 4: Design the fact table MyFactSales
Write down the fields in the MyFactSales table in any text editor, one field per line.

Solution:
In this task, you will design the fact table MyFactSales to store sales-related information.

Fields in FactSales table:

salesid
productid
quantitysold
priceperunit
segmentid
dateid
The fact table FactSales will store information about each sales transaction, including the unique identifier (salesid), product identifier (productid), quantity sold (quantitysold), price per unit (priceperunit), customer segment identifier (segmentid) and date identifier (dateid). This table will serve as the central repository for sales data and enable analysis and reporting on various dimensions.

Exercise 2: Create schema for data warehouse on PostgreSQL
Open pgAdmin and create a database named Practice, then create the following tables.

Task 5: Create the dimension table MyDimDate
Create the MyDimDate table.

Take a screenshot of the SQL statement you used to create the table MyDimDate.

CREATE TABLE MyDimDate (
    dateid INT PRIMARY KEY,
    year INT,
    month INT,
    monthname VARCHAR(20),
    day INT,
    weekday INT,
    weekdayname VARCHAR(20)
);
