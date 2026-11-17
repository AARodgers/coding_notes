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

Exercise 3 - Load data into the data warehouse
In this exercise, you will load the data into the tables.

After the initial schema design, you were informed that data could not be collected in the format initially planned due to operational issues. This means that the previous tables (MyDimDate, MyDimProduct, MyDimCustomerSegment, MyFactSales) in the Practice database and their associated attributes are no longer applicable to the current design. The company has now provided data in CSV files according to the new design.

You will need to load the data provided by the company in CSV format. First, create a new database named PracProj. Then, create the tables DimDate, DimProduct, DimCustomerSegment, and FactSales as per the new schema. Follow the instructions in the lab to run the new scripts and load the data from the CSV files into the appropriate tables.

Task 9: Load data into the dimension table DimDate
Download the data from https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/-omGFpVSWBIZKFSCxUkBwg/DimDate.csv.

Load this data into DimDate table.

Take a screenshot of the first 5 rows in the table DimDate.

Name the screenshot 9-DimDate.jpg. (Images can be saved with either the .jpg or .png extension.)

Solution:
Step 1: Open pgAdmin. Then create database PracProj and connect to PracProj database.

Step 2: Create the DimDate table

1
2
3
4
5
6
7
8
9
10
11
12
CREATE TABLE DimDate (
    Dateid INT PRIMARY KEY,
    date DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    QuarterName VARCHAR(2) NOT NULL,
    Month INT NOT NULL,
    Monthname VARCHAR(255) NOT NULL,
    Day INT NOT NULL,
    Weekday INT NOT NULL,
    WeekdayName VARCHAR(255) NOT NULL
);

Copied!

Wrap Toggled!
Step 3: Use the import tool in pgAdmin to load your CSV file into the table

Navigate to the DimDate table in pgAdmin, right-click it, select Import/Export.
DWF11.png

Choose Import, to select your CSV file, click on the open file.
DWF12.png

Next a new page pops up called Select File, click on the three dot select Upload option.
DWF13.png

Once the file is successfully loaded, click on the X icon on the right hand side of the page. Then select the file from the list and click the Select tab to add the file for import.

Note: Ensure that you upload the files to this path: /var/lib/pgadmin/
Also, ensure that the file you have selected will have the Filename as /var/lib/pgadmin/DimDate.csv.(No special words like None: or /home should be added).
DWF14.png

Click on the Options tab, toggle the Header option and then select Ok.
DWF15.png

Once the data added successfully will get the pop up message as Process Completed.

DWF17.png

Step 4: Run this query to select the first 5 rows.

SELECT * FROM DimDate LIMIT 5;

After running the SELECT query, the first 5 rows of your DimDate table will be displayed in the query output panel.
DWF18.png

Step 5: Take the screenshot.

Take a screenshot of this panel with the results. You can use the snipping tool on Windows, Shift+Command+4 on Mac, or the equivalent on your operating system.

Task 10: Load data into the dimension table DimProduct
Download the data from https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/Y-76u4An3zb5R6HxxFPabA/DimProduct.csv.

Load this data into DimProduct table.
Take a screenshot of the first 5 rows in the table DimProduct.
Name the screenshot 10-DimProduct.jpg. (Images can be saved with either the .jpg or .png extension.)

Solution:
Step 1: Create the DimProduct table

1
2
3
4
CREATE TABLE DimProduct (
    Productid INT PRIMARY KEY,
    Producttype VARCHAR(255) NOT NULL
);

Copied!

Wrap Toggled!
Step 2: Use the import tool in pgAdmin to load your CSV file into the table (Refer to Task 9 -> Solution for DimDate -> Step 3 for the detail)

Navigate to the DimProduct table in pgAdmin, right-click it, select Import/Export.
Choose Import, select your CSV file, and follow the prompts to import the data.
Step 3: Run this query to select the first 5 rows

SELECT * FROM DimProduct LIMIT 5;

After running the SELECT query, the first 5 rows of your DimProduct table will be displayed in the query output panel.

Step 4: Take the screenshot.

Take a screenshot of this panel with the results. You can use the snipping tool on Windows, Shift+Command+4 on Mac, or the equivalent on your operating system.

Task 11: Load data into the dimension table DimCustomerSegment
Download the data from https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/h_dnxb8yzQyVjeb8oYnm8A/DimCustomerSegment.csv.

Load this data into DimCustomerSegment table.

Take a screenshot of the first 5 rows in the table DimCustomerSegment.

Name the screenshot 11-DimCustomerSegment.jpg. (Images can be saved with either the .jpg or .png extension.)

Solution:
Step 1: Create the DimCustomerSegment table

1
2
3
4
CREATE TABLE DimCustomerSegment (
    Segmentid INT PRIMARY KEY,
    City VARCHAR(255) NOT NULL
);

Copied!

Wrap Toggled!
Step 2: Use the import tool in pgAdmin to load your CSV file into the table (Refer to Task 9 -> Solution for DimDate -> Step 3 for the detail)

Navigate to the DimCustomerSegment table in pgAdmin, right-click it, select Import/Export.
Choose Import, select your CSV file, and follow the prompts to import the data.
Step 3: Run this query to select the first 5 rows

SELECT * FROM DimCustomerSegment LIMIT 5;

After running the SELECT query, the first 5 rows of your DimCustomerSegment table will be displayed in the query output panel.

Step 4: Take the screenshot.

Take a screenshot of this panel with the results. You can use the snipping tool on Windows, Shift+Command+4 on Mac, or the equivalent on your operating system.

Task 12: Load data into the fact table FactSales
Download the data from https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/a8kTjzvpdqzOp46ODatyAA/FactSales.csv

Load this data into FactSales table.

Take a screenshot of the first 5 rows in the table FactSales.

Name the screenshot 12-FactSales.jpg. (Images can be saved with either the .jpg or .png extension.)

Solution:
Step 1: Create the FactSales table

1
2
3
4
5
6
7
8
9
10
11
CREATE TABLE FactSales (
    Salesid VARCHAR(255) PRIMARY KEY,
    Dateid INT NOT NULL,
    Productid INT NOT NULL,
    Segmentid INT NOT NULL,
    Price_PerUnit DECIMAL(10, 2) NOT NULL,
    QuantitySold INT NOT NULL,
    FOREIGN KEY (Dateid) REFERENCES DimDate(Dateid),
    FOREIGN KEY (Productid) REFERENCES DimProduct(Productid),
    FOREIGN KEY (Segmentid) REFERENCES DimCustomerSegment(Segmentid)
);

Copied!

Wrap Toggled!
Step 2: Use the import tool in pgAdmin to load your CSV file into the table(Refer to Task 9 -> Solution for DimDate -> Step 3 for the detail)

Navigate to the FactSales table in pgAdmin, right-click it, select Import/Export.
Choose Import, select your CSV file, and follow the prompts to import the data.
Step 3: Run this query to select the first 5 rows

SELECT * FROM FactSales LIMIT 5;

After running the SELECT query, the first 5 rows of your FactSales table will be displayed in the query output panel.

Step 4: Take the screenshot.

Take a screenshot of this panel with the results. You can use the snipping tool on Windows, Shift+Command+4 on Mac, or the equivalent on your operating system.

