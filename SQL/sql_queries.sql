
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
