
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
