/* To generate sql script to run to format data and insert it

First: load the data file into /home/project:

wget -O file_name.csv url

STEP 1:
# in terminal run the command below to create a new python file
nano generate_sql.py

STEP 2: ( BE SURE TO CHANGE CSV NAME AND insert.sql if you want or overwrite the file)
# in nano copy and paste this code to format the data to add () and commas

import csv
with open('DimDate.csv', mode='r') as infile, open('insert.sql', mode='w') as outfile:
    reader = csv.reader(infile)
    header = next(reader)

    # Wrap reserved keywords in double quotes
    cols = ', '.join([f'"{h}"' if h in ['Year', 'Quarter', 'Month', 'Day'] else h for h in header])

    outfile.write(f'INSERT INTO dimdate ({cols}) VALUES\n')

    rows = []
    for row in reader:
        formatted_vals = []
        for val in row:
            # Check if the value is numeric; if not, wrap in single quotes
            try:
                float(val)
                formatted_vals.append(val)
            except ValueError:
                formatted_vals.append(f"'{val}'")
        rows.append(f"    ({', '.join(formatted_vals)})")

    outfile.write(',\n'.join(rows) + ';')
print("SQL file generated successfully as insert.sql!")

(Press Ctrl + O then Enter to save,
and Ctrl + X to exit nano if using nano, or just create generate_sql.py via your file explorer).

STEP 3:
# in terminal run the command below to execute the python script and generate the sql file
python3 generate_sql.py
# Verification: The terminal prints SQL file generated successfully as insert.sql!.

STEP 4:
copy and run sql in query tool
open file and copy data or use cat insert.sql and copy/paste into query tool

INSERT INTO table (dateid, date, "Year", "Quarter", "QuarterName", "Month", "Monthname", "Day", "Weekday", "WeekdayName")
VALUES

INSERT INTO dimproduct (Productid, Producttype) VALUES
    (1001, 'Electronics'),
    (1002, 'Clothing'),
    (1003, 'Furniture'),
    (1004, 'Groceries'),
    (1005, 'Appliances'),
    (1006, 'Beauty'),
    (1007, 'Books'),
    (1008, 'Shoes'),
    (1009, 'Gardening'),
    (1010, 'Sports'),
    (1011, 'Toys'),
    (1012, 'Jewelry'),
    (1013, 'Tools'),
    (1014, 'Kitchenware'),
    (1015, 'Pet Supplies'),
    (1016, 'Art Supplies'),
    (1017, 'Electronics'),
    (1018, 'Clothing'),
    (1019, 'Furniture'),
    (1020, 'Groceries'),
    (1021, 'Appliances'),
    (1022, 'Beauty'),
    (1023, 'Books'),
    (1024, 'Shoes'),
    (1025, 'Gardening');


    INSERT INTO dimcustomersegment (segmentid, "city") VALUES
    (19, 'Sao Paulo'),
    (21, 'Sao Paulo'),
    (31, 'Rio de Janeiro'),
    (32, 'Rio de Janeiro'),
    (40, 'Brasilia'),
    (43, 'Brasilia'),
    (44, 'Rio de Janeiro'),
    (46, 'Brasilia'),
    (47, 'Salvador'),
    (48, 'Salvador'),
    (57, 'Rio de Janeiro'),
    (71, 'Brasilia'),
    (77, 'Brasilia'),
    (81, 'Salvador'),
    (82, 'Salvador'),
    (83, 'Sao Paulo'),
    (84, 'Rio de Janeiro'),
    (86, 'Rio de Janeiro'),
    (97, 'Brasilia');


    INSERT INTO factsales (salesid, dateid, productid, segmentid, price_perunit, quantitysold) VALUES
    ('S1001', 1, 1001, 19, 299.99, 3),
    ('S1002', 2, 1002, 21, 89.99, 10),
    ('S1003', 3, 1003, 31, 1249.99, 2),
    ('S1004', 4, 1004, 32, 5.99, 40),
    ('S1005', 5, 1005, 40, 499.99, 1),
    ('S1006', 6, 1006, 43, 20, 5),
    ('S1007', 7, 1007, 44, 15.99, 12),
    ('S1008', 8, 1008, 46, 120, 7),
    ('S1009', 9, 1009, 47, 30, 15),
    ('S1010', 10, 1010, 48, 65.5, 4),
    ('S1011', 11, 1011, 57, 12.99, 20),
    ('S1012', 12, 1012, 71, 45, 8),
    ('S1013', 13, 1013, 77, 250, 3),
    ('S1014', 14, 1014, 81, 35, 6),
    ('S1015', 15, 1015, 82, 18.5, 9),
    ('S1016', 16, 1001, 83, 299.99, 2),
    ('S1017', 17, 1002, 84, 89.99, 15),
    ('S1018', 18, 1003, 86, 1249.99, 1),
    ('S1019', 19, 1004, 97, 5.99, 35),
    ('S1020', 20, 1005, 19, 499.99, 4),
    ('S1021', 21, 1006, 21, 20, 6),
    ('S1022', 22, 1007, 31, 15.99, 11),
    ('S1023', 23, 1008, 32, 120, 5),
    ('S1024', 24, 1009, 40, 30, 14);

    Create a grouping sets query using the columns productid, producttype, total sales.

SELECT
    p.Productid,
    p.Producttype,
    SUM(f.Price_PerUnit * f.QuantitySold) AS TotalSales
FROM
    FactSales f
INNER JOIN
    DimProduct p ON f.Productid = p.Productid
GROUP BY GROUPING SETS (
    (p.Productid, p.Producttype),
    p.Productid,
    p.Producttype,
    ()
)
ORDER BY
    p.Productid,
    p.Producttype;

In this query:

You're joining FactSales 'f' with DimProduct 'p' on their productid to correlate each sale with its product type.

You're using GROUPING SETS to specify the different levels of aggregation:

– By both Productid and Producttype
– By Productid alone
– By Producttype alone
– And a grand total with (), which doesn't group by any column and hence returns the sum for all sales.

You're calculating TotalSales by multiplying the Price_PerUnit by QuantitySold for each sale.
The ORDER BY clause ensures the results are ordered by productid and then by producttype.

###Create a rollup query using the columns year, city, productid, and total sales.


SELECT
    d.Year,
    cs.City,
    p.Productid,
    SUM(f.Price_PerUnit * f.QuantitySold) AS TotalSales
FROM
    FactSales f
JOIN
    DimDate d ON f.Dateid = d.Dateid
JOIN
    DimProduct p ON f.Productid = p.Productid
JOIN
    DimCustomerSegment cs ON f.Segmentid = cs.Segmentid
GROUP BY ROLLUP (d.Year, cs.City, p.Productid)
ORDER BY
    d.Year DESC,
    cs.City,
    p.Productid;

This query performs the following operations:

Joins FactSales with DimDate on Dateid, DimProduct on Productid, and DimCustomerSegment on Segmentid.
Selects the year from DimDate, the city from DimCustomerSegment, and the product ID from DimProduct.
Calculates total sales by multiplying the price per unit by the quantity sold for each sales entry.
Groups the results using the ROLLUP function to create a grouping set that includes all combinations of year, city, and productid, along with their respective subtotals and a grand total for all sales.
The ORDER BY clause ensures the results are first ordered by year in descending order, then by city and product ID.


Create a cube query using the columns year, city, productid, and average sales.

SELECT
    d.Year,
    cs.City,
    p.Productid,
    AVG(f.Price_PerUnit * f.QuantitySold) AS AverageSales
FROM
    FactSales f
INNER JOIN
    DimDate d ON f.Dateid = d.Dateid
INNER JOIN
    DimProduct p ON f.Productid = p.Productid
INNER JOIN
    DimCustomerSegment cs ON f.Segmentid = cs.Segmentid
GROUP BY CUBE (d.Year, cs.City, p.Productid);

n this query:

The CUBE clause is used in the GROUP BY to create subtotals for all combinations of year, city, and productid in addition to the grand total across all groups.

AVG(f.Price_PerUnit * f.QuantitySold) calculates the average sales, factoring in both the price per unit and the quantity sold.

INNER JOIN is used to join the FactSales table with the dimension tables DimDate, DimProduct, and DimCustomerSegment.



####Create an materialized view named max_sales using the columns city, productid, producttype, and max sales.

CREATE MATERIALIZED VIEW max_sales AS
SELECT
    cs.City,
    p.Productid,
    p.Producttype,
    MAX(f.Price_PerUnit * f.QuantitySold) AS MaxSales
FROM
    FactSales f
JOIN
    DimProduct p ON f.Productid = p.Productid
JOIN
    DimCustomerSegment cs ON f.Segmentid = cs.Segmentid
GROUP BY
    cs.City,
    p.Productid,
    p.Producttype
WITH DATA;

This statement will create the materialized view and populate it with the current data from the joined tables. The WITH DATA clause tells PostgreSQL to fill the view with the query results immediately. If you wanted to create the view without filling it with data, you would use WITH NO DATA.

To update the materialized view with the latest data, you would use the REFRESH MATERIALIZED VIEW command:

REFRESH MATERIALIZED VIEW max_sales;


=================================
New DimDate table with this CSV data:
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
