-- After completing this reading, you will be able to:

-- Understand the Role of SQLite in Datasette
-- Create and Manage Data Tables
-- Implement Views for Simplified Data Access
-- Optimize Query Performance with Indexes
-- Datasette is a versatile tool designed for exploring and publishing SQLite databases.
-- It enables users to create intuitive web interfaces for SQLite databases, facilitating
-- easy data browsing and querying without the need for additional programming.

-- Key Concepts
-- SQLite: SQLite is a lightweight, disk-based database engine that operates without a separate server process.
-- Its simplicity and ease of setup make it ideal for local applications and development environments.

-- Views: Views are virtual tables derived from SQL query results. Views simplify complex queries,
-- facilitate query reuse, and present data in specific formats without altering the underlying tables.

-- Indexes: Indexes are database objects that enhance data retrieval speed. By creating a separate
-- data structure, indexes enable the database engine to locate rows more efficiently than performing a
-- full table scan.

-- Real-World Scenario: Managing an E-commerce Inventory
-- Scenario: Imagine you are managing an e-commerce platform that sells a variety of products.
-- Your goal is to create a database to track inventory, including product details and sales information.
-- You want to optimize the database to quickly access and analyze data.

-- Example: E-commerce Inventory Management
-- 1. Create a Data Table:

-- Create a table to store product information, including product ID, name, category, price, and stock quantity.

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT,
    price REAL NOT NULL,
    stock_quantity INTEGER NOT NULL
);
-- 2. Insert Sample Data:
INSERT INTO products (name, category, price, stock_quantity) VALUES
('Smartphone', 'Electronics', 699.99, 150),
('Laptop', 'Electronics', 999.99, 85),
('Sneakers', 'Footwear', 89.99, 200),
('Running Shoes', 'Footwear', 129.99, 120),
('Blender', 'Home Appliances', 49.99, 60);
-- 3. Create a View for Simplified Data Access:
--Create a view to easily access products that are low in stock (e.g., less than 100 units).
CREATE VIEW low_stock_products AS
SELECT name, category, price, stock_quantity
FROM products
WHERE stock_quantity < 100;

--To query products with low stock, we can the below given sample query:
SELECT * FROM low_stock_products;
-- This view provides a quick way to identify products that need restocking without
--querying the main products table directly.

-- 4. Create an Index to Optimize Query Performance:
-- Before creating an index you can measure the query time without an index, by using the following query:

-- Record the start time
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS start_time;

-- Run the query
SELECT * FROM products WHERE category = 'Footwear';

-- Record the end time
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS end_time;

--Now you can create an index to improve query performance for searches by product category.

CREATE INDEX idx_category ON products (category);

-- To find all products in the Footwearcategory we can use the query given below:
-- Record the start time
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS start_time;

-- Run the query
SELECT * FROM products WHERE category = 'Footwear';

-- Record the end time
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS end_time;

--The index on the category column helps speed up this query, making it more efficient,
--especially with a large inventory. The query execution is faster since the index allows SQLite to
--quickly find the relevant rows, avoiding a full table scan.
--You have learned how to use SQLite in Datasette to create tables, implement views, and
--optimize queries with indexes. These tools enhance data management and improve query performance,
--making it easier to handle and analyze e-commerce inventory efficiently.
