
#count of rows in the table FactBilling
select count(*) from public."FactBilling";

# Using the PostgreSQL tool, create a simple Materialized views named avg_customer_bill with fields customerid and averagebillamount.
CREATE MATERIALIZED VIEW avg_customer_bill AS
SELECT customerid, AVG(billedamount) AS averagebillamount
FROM public."FactBilling"
GROUP BY customerid;

# Refresh the newly created Materialized views
REFRESH MATERIALIZED VIEW avg_customer_bill;

# Using the newly created Materialized views find the customers whose average billing is more than 11000
select * from avg_customer_bill where averagebillamount > 11000;

-------------------------------------------------------

-- Grouping sets, rollups, and cubes for data aggregation and summarization
-- implement and utilize Materialized Query Tables (Materialized views) for efficient data querying
-- GROUPING SETS, CUBE, and ROLLUP allow us to easily create subtotals and grand totals in a variety of ways. All these operators are used along with the GROUP BY operator.

GROUPING SETS operator allows us to group data in a number of different ways in a single SELECT statement.

The ROLLUP operator is used to create subtotals and grand totals for a set of columns. The summarized totals are created based on the columns passed to the ROLLUP operator.

The CUBE operator produces subtotals and grand totals. In addition, it produces subtotals and grand totals for every permutation of the columns provided to the CUBE operator.

-- create a grouping set for three columns labeled year, category, and sum of billedamount
select year,category, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by grouping sets(year,category);


--create a rollup using the three columns year, category and sum of billedamount
select year,category, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by rollup(year,category)
order by year, category;

--create a cube using the three columns labeled year, category, and sum of billedamount,
select year,category, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by cube(year,category)
order by year, category;

--create an Materialized views named countrystats
CREATE MATERIALIZED VIEW countrystats (country, year, totalbilledamount) AS
(select country, year, sum(billedamount)
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by country,year);

-- Materialized views is essentially the result of the below query, which gives you the year, quartername and the sum of billed amount grouped by year and quartername.
select year, quartername, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by grouping sets(year, quartername);

--populate/refresh the Materialized views countrystats
REFRESH MATERIALIZED VIEW countrystats;

--command above populates the Materialized views with relevant data.

-- Once an Materialized views is refreshed, you can query it.

--Execute the sql statement below to query the Materialized views countrystats.
select * from countrystats;

--Create a grouping set for the columns year, quartername, sum(billedamount
select year, quartername, sum(billedamount) as totalbilledamount
from "FactBilling"
left join "DimCustomer"
on "FactBilling".customerid = "DimCustomer".customerid
left join "DimMonth"
on "FactBilling".monthid="DimMonth".monthid
group by grouping sets(year, quartername);

-- Create a rollup for the columns country, category, sum(billedamount).

SELECT country, category, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer"
ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth"
ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY ROLLUP(country, category)
ORDER BY country, category;

--Create a cube for the columns year,country, category, sum(billedamount)
SELECT year, country, category, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer"
ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth"
ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY CUBE(year, country, category);

--Create an Materialized views named average_billamount with columns year, quarter, category, country, average_bill_amount.
CREATE MATERIALIZED VIEW average_billamount (year,quarter,category,country, average_bill_amount) AS
    (select   year,quarter,category,country, avg(billedamount) as average_bill_amount
    from "FactBilling"
    left join  "DimCustomer"
    on "FactBilling".customerid =  "DimCustomer".customerid
    left join "DimMonth"
    on "FactBilling".monthid="DimMonth".monthid
    group by year,quarter,category,country
    );


==============

    Create a grouping sets query using the columns productid, producttype, total sales.
    # Result of grouping sets: will give you a sales summary table with subtotals and a grand total (instead of making seperate queries)
    # Specifically it gives you:
        - sales for each specific product type ( ex. electronics, furniture, etc.)
        - sales for each specific product id ( ex. 1001, 1002, etc.)
        - the grand total of all sales across all product types and product ids.
    # Normally, a standard GROUP BY only gives you one level of summary at a time (like just by product type).
    # GROUPING SETS lets the database stack multiple summary levels into a single table—putting blank or NULL values in
    # the columns that aren't being broken down on a given row to show it's a subtotal or total.
    # In short: it answers "How much did we sell?" at multiple zoom levels—by product, by category, and overall—at the same time.
    # NOTE: a NULL for productid means it's a subtotal for that product type, and a NULL for both productid and producttype means it's the grand total.


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



########## Create a rollup query using the columns year, city, productid, and total sales. #########
# Answers the questions: , it answers:
"What are our sales broken down by year, then city, then product—and what are the subtotals by city-year,
subtotals by year, and grand total along the way?"

# Result:
Specifically, with ROLLUP(year, city, productid), SQL creates a strict top-to-bottom hierarchy (unlike GROUPING SETS, which lets you pick arbitrary combinations):

Year + City + Product: Total sales for a specific product, in a specific city, in a specific year.

Year + City subtotal: Total sales across all products for a given city and year (productid is NULL).

Year subtotal: Total sales across all cities and products for a given year (city and productid are both NULL).

Grand total: Total sales across all years, cities, and products combined (year, city, and productid are all NULL).

# Why ROLLUP instead of GROUPING SETS? Because ROLLUP is designed for hierarchical aggregations, which is exactly what we want here: a clear top-down summary from year to city to product.
ROLLUP (a, b, c) assumes an ordered drill-down/roll-up path (a → b → c), giving (a, b, c), (a, b), (a), and (). It won't give you standalone subtotals like "just by city across all years" unless you use GROUPING SETS or CUBE.

It is ideal when your reporting hierarchy naturally flows in sequence—such as Time → Geography → Product.

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


############### Create a cube query using the columns year, city, productid, and average sales. ##########################

# Answers the questions: With CUBE(year, city, productid) and AVG(...), the query calculates average sales across every
possible combination of those three dimensions—including all subtotals and the overall average—in a single result set.

Questions This Query AnswersBecause CUBE generates all $2^3 = 8$ combinations of (year, city, productid), it answers questions from any
angle without forcing a strict order:All three together: What is the average sale for a specific product, in a specific city, during a
specific year?Two-dimension subtotals:Average sale by year and city (across all products)Average sale by year and product (across all cities)
Average sale by city and product (across all years)One-dimension subtotals:Average sale by year aloneAverage sale by city aloneAverage sale
by product aloneOverall average: What is the average sale across all years, cities, and products combined?(Note on AVG vs. SUM: Since it
computes averages rather than sums, a subtotal row is the average of the underlying sales rows in that slice—not simply the average of the 
smaller subtotals shown above it.)

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

=====================
