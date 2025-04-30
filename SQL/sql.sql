A **LEFT JOIN** in SQL is used to combine rows from two tables based on a related column, returning **all rows from the left table** (the first table in the query), and matching rows from the right table (the second table in the query). If there is no match in the right table, the result will include `NULL` values for the columns from the right table.

---

### **Key Characteristics of a LEFT JOIN**
1. **Preserves All Rows from the Left Table**:
   - The result includes all rows from the left table, regardless of whether there is a matching row in the right table.

2. **Matches Rows from the Right Table**:
   - If a match is found, the corresponding row from the right table is included.
   - If no match is found, `NULL` is returned for columns from the right table.

---

### **Syntax**
```sql
SELECT
    left_table.column1,
    left_table.column2,
    right_table.column3
FROM
    left_table
LEFT JOIN
    right_table
ON
    left_table.common_column = right_table.common_column;
```

- **`left_table`**: The table from which all rows will be preserved.
- **`right_table`**: The table that will provide matching rows (or `NULL` if no match exists).
- **`ON`**: Specifies the condition for matching rows between the two tables.

---

### **Example**

#### **Tables**

**`employees` (Left Table)**:
| employee_id | name      | department_id |
|-------------|-----------|---------------|
| 1           | Alice     | 101           |
| 2           | Bob       | 102           |
| 3           | Charlie   | 103           |

**`departments` (Right Table)**:
| department_id | department_name |
|---------------|-----------------|
| 101           | HR              |
| 102           | IT              |

---

#### **Query**
```sql
SELECT
    employees.name,
    employees.department_id,
    departments.department_name
FROM
    employees
LEFT JOIN
    departments
ON
    employees.department_id = departments.department_id;
```

---

#### **Result**
| name      | department_id | department_name |
|-----------|---------------|-----------------|
| Alice     | 101           | HR              |
| Bob       | 102           | IT              |
| Charlie   | 103           | NULL            |

---

### **Explanation**
1. **Row 1 (`Alice`)**:
   - `department_id = 101` matches a row in the `departments` table (`HR`), so the department name is included.

2. **Row 2 (`Bob`)**:
   - `department_id = 102` matches a row in the `departments` table (`IT`), so the department name is included.

3. **Row 3 (`Charlie`)**:
   - `department_id = 103` does not exist in the `departments` table, so `NULL` is returned for `department_name`.

---

### **Use Cases**
1. **Display All Records from One Table**:
   - Use a LEFT JOIN to include all rows from the left table, even if there are no matching rows in the right table.

2. **Find Missing Matches**:
   - Identify rows in the left table that do not have corresponding matches in the right table by looking for `NULL` values.

3. **Combine Data**:
   - Merge data from two tables while ensuring that no rows from the left table are excluded.

---

### **Comparison: LEFT JOIN vs INNER JOIN**
| Feature         | LEFT JOIN                              | INNER JOIN                             |
|-----------------|---------------------------------------|---------------------------------------|
| **Rows Returned** | All rows from the left table.         | Only rows with matches in both tables. |
| **Unmatched Rows** | Includes rows with `NULL` values for unmatched rows from the right table. | Excludes unmatched rows.               |

---

### **Summary**
A **LEFT JOIN**:
- Combines rows from two tables based on a condition.
- Returns all rows from the left table, even if there is no match in the right table.
- Includes `NULL` for columns from the right table where no match exists.

This is useful for preserving all data from one table while optionally enriching it with data from another table.

----------------------------

Performing **Exploratory Data Analysis (EDA)** on a large table using SQL involves writing queries to understand the structure, distribution, and relationships within the data. Below are SQL commands you can use for various aspects of EDA:

---

### **1. Get the Structure of the Table**
#### Command:
```sql
DESCRIBE table_name; -- MySQL, MariaDB
```
OR
```sql
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'table_name';
```
#### Purpose:
- Lists all columns, their data types, whether they allow `NULL`, and their default values.

---

### **2. Count the Number of Rows**
#### Command:
```sql
SELECT COUNT(*) AS total_rows
FROM table_name;
```
#### Purpose:
- Returns the total number of rows in the table to understand its size.

---

### **3. Count Unique Values in a Column**
#### Command:
```sql
SELECT column_name, COUNT(DISTINCT column_name) AS unique_values
FROM table_name;
```
#### Purpose:
- Identifies how many unique values exist in a column.

---

### **4. Check for Missing Values**
#### Command:
```sql
SELECT column_name, COUNT(*) AS total,
       SUM(CASE WHEN column_name IS NULL THEN 1 ELSE 0 END) AS missing_values
FROM table_name;
```
#### Purpose:
- Counts `NULL` values in a column to identify missing data.

---

### **5. Get Basic Statistics for Numeric Columns**
#### Command:
```sql
SELECT
    MIN(column_name) AS min_value,
    MAX(column_name) AS max_value,
    AVG(column_name) AS avg_value,
    STDDEV(column_name) AS std_dev,
    COUNT(*) AS total_rows
FROM table_name;
```
#### Purpose:
- Provides basic statistics like minimum, maximum, average, and standard deviation for numeric columns.

---

### **6. Group Data and Count Occurrences**
#### Command:
```sql
SELECT column_name, COUNT(*) AS occurrences
FROM table_name
GROUP BY column_name
ORDER BY occurrences DESC;
```
#### Purpose:
- Groups data by a column and counts how many times each value appears.

---

### **7. Check Distribution of a Column**
#### Command:
```sql
SELECT column_name, COUNT(*) AS frequency
FROM table_name
GROUP BY column_name
ORDER BY frequency DESC;
```
#### Purpose:
- Helps understand the distribution of categorical values in the column.

---

### **8. Identify Outliers**
#### Command:
```sql
SELECT column_name
FROM table_name
WHERE column_name < (SELECT AVG(column_name) - 3 * STDDEV(column_name) FROM table_name)
   OR column_name > (SELECT AVG(column_name) + 3 * STDDEV(column_name) FROM table_name);
```
#### Purpose:
- Identifies outliers based on the 3-sigma rule for numeric columns.

---

### **9. Check Relationships Between Columns**
#### Command:
```sql
SELECT column1, column2, COUNT(*) AS occurrences
FROM table_name
GROUP BY column1, column2
ORDER BY occurrences DESC;
```
#### Purpose:
- Looks for relationships between two columns by grouping and counting occurrences.

---

### **10. Analyze Trends Over Time**
#### Command:
```sql
SELECT DATE(column_name) AS date, COUNT(*) AS occurrences
FROM table_name
GROUP BY DATE(column_name)
ORDER BY date;
```
#### Purpose:
- Aggregates data by date to analyze trends over time.

---

### **11. Find Duplicate Rows**
#### Command:
```sql
SELECT column1, column2, COUNT(*)
FROM table_name
GROUP BY column1, column2
HAVING COUNT(*) > 1;
```
#### Purpose:
- Identifies rows where specific columns have duplicate values.

---

### **12. Create a Frequency Table**
#### Command:
```sql
SELECT column_name, COUNT(*) AS frequency
FROM table_name
GROUP BY column_name
ORDER BY frequency DESC;
```
#### Purpose:
- Creates a frequency table to analyze the distribution of categorical values.

---

### **13. Analyze Null Percentage for All Columns**
#### Command:
```sql
SELECT
    column_name,
    SUM(CASE WHEN column_name IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS null_percentage
FROM table_name;
```
#### Purpose:
- Calculates the percentage of `NULL` values in a column.

---

### **14. Find Correlations Between Columns (Numeric)**
#### Command:
```sql
SELECT
    column_x, column_y,
    CORR(column_x, column_y) AS correlation
FROM table_name;
```
#### Purpose:
- Calculates the correlation between two numeric columns (supported in databases like PostgreSQL).

---

### **15. Preview the Data**
#### Command:
```sql
SELECT *
FROM table_name
LIMIT 10; -- Adjust the limit as needed
```
#### Purpose:
- Displays the first few rows of the table for a quick preview of the data.

---

### **16. Check Value Lengths in a Column**
#### Command:
```sql
SELECT column_name, LENGTH(column_name) AS value_length
FROM table_name;
```
#### Purpose:
- Helps identify unusually long or short values in a column.

---

### **17. Analyze the Range of Numeric Data**
#### Command:
```sql
SELECT column_name,
       CASE
           WHEN column_name BETWEEN 0 AND 100 THEN '0-100'
           WHEN column_name BETWEEN 101 AND 200 THEN '101-200'
           ELSE '200+'
       END AS range,
       COUNT(*) AS occurrences
FROM table_name
GROUP BY range;
```
#### Purpose:
- Categorizes numeric values into ranges for analysis.

---

### **Summary**
These SQL commands help perform EDA by:
1. Understanding the structure of the table.
2. Analyzing distributions, missing values, and relationships.
3. Identifying trends, outliers, and duplicates.

Use the commands dynamically based on the specific questions you want to answer about your data!

GROUP BY
 ####################################
### **How `GROUP BY` Works in SQL**

The `GROUP BY` clause in SQL is used to **group rows** that have the same values in specified columns into **aggregates**. It is often used with aggregate functions (like `SUM`, `COUNT`, `AVG`, `MAX`, `MIN`) to perform calculations on each group of data.

---

### **How It Works**
1. **Grouping Rows**:
   - The `GROUP BY` clause collects rows with the same values in the specified column(s) into groups.

2. **Aggregate Functions**:
   - Aggregate functions are applied to each group to calculate summary statistics, such as totals, averages, or counts.

3. **Result**:
   - The result will have one row for each unique group, with the aggregate function applied to that group.

---

### **Syntax**
```sql
SELECT column1, column2, AGGREGATE_FUNCTION(column3)
FROM table_name
GROUP BY column1, column2;
```

- **`column1, column2`**: The columns used to group the rows.
- **`AGGREGATE_FUNCTION(column3)`**: The aggregate function applied to each group (e.g., `SUM`, `COUNT`, `AVG`).

---

### **Example 1: Basic GROUP BY**
#### **Table: Sales**
| Region   | Product   | Sales |
|----------|-----------|-------|
| North    | A         | 100   |
| North    | B         | 200   |
| South    | A         | 150   |
| South    | B         | 300   |
| North    | A         | 50    |

#### **Query**:
```sql
SELECT Region, SUM(Sales) AS TotalSales
FROM Sales
GROUP BY Region;
```

#### **Result**:
| Region   | TotalSales |
|----------|------------|
| North    | 350        |
| South    | 450        |

- The `GROUP BY Region` groups rows by the `Region` column.
- The `SUM(Sales)` calculates the total sales for each region.

---

### **Example 2: GROUP BY Multiple Columns**
You can group by multiple columns to create more granular groups.

#### **Query**:
```sql
SELECT Region, Product, SUM(Sales) AS TotalSales
FROM Sales
GROUP BY Region, Product;
```

#### **Result**:
| Region   | Product   | TotalSales |
|----------|-----------|------------|
| North    | A         | 150        |
| North    | B         | 200        |
| South    | A         | 150        |
| South    | B         | 300        |

- The `GROUP BY Region, Product` groups rows by both `Region` and `Product`.

---

### **Example 3: COUNT with GROUP BY**
You can count the number of rows in each group.

#### **Query**:
```sql
SELECT Product, COUNT(*) AS SalesCount
FROM Sales
GROUP BY Product;
```

#### **Result**:
| Product   | SalesCount |
|-----------|------------|
| A         | 3          |
| B         | 2          |

- The `COUNT(*)` function counts the number of rows in each group.

---

### **Key Points About GROUP BY**
1. **Columns in SELECT**:
   - Every column in the `SELECT` clause must either:
     - Appear in the `GROUP BY` clause, or
     - Be used in an aggregate function.

   #### Example:
   ```sql
   SELECT Region, SUM(Sales)  -- Valid
   FROM Sales
   GROUP BY Region;
   ```

   ```sql
   SELECT Region, Sales  -- Invalid: Sales is not in GROUP BY or an aggregate function
   FROM Sales
   GROUP BY Region;
   ```

2. **Order of Execution**:
   - The `GROUP BY` clause is processed **after** the `WHERE` clause and **before** the `ORDER BY` clause.

   #### Execution Order:
   - `FROM` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `ORDER BY`

3. **`HAVING` Clause**:
   - Use the `HAVING` clause to filter groups after aggregation (similar to `WHERE`, but for groups).

   #### Example:
   ```sql
   SELECT Region, SUM(Sales) AS TotalSales
   FROM Sales
   GROUP BY Region
   HAVING SUM(Sales) > 400;
   ```

   **Result**:
   | Region   | TotalSales |
   |----------|------------|
   | South    | 450        |

   - The `HAVING` clause filters groups where `SUM(Sales)` is greater than 400.

---

### **Common Aggregate Functions Used with GROUP BY**
1. **`SUM()`**: Adds up all values in a group.
2. **`COUNT()`**: Counts the number of rows in a group.
3. **`AVG()`**: Calculates the average value in a group.
4. **`MAX()`**: Finds the maximum value in a group.
5. **`MIN()`**: Finds the minimum value in a group.

---

### **Example: Combining GROUP BY with JOIN**
You can use `GROUP BY` with `JOIN` to aggregate data across multiple tables.

#### **Tables**:
**Orders**:
| OrderID | CustomerID | Amount |
|---------|------------|--------|
| 1       | 101        | 200    |
| 2       | 102        | 150    |
| 3       | 101        | 300    |

**Customers**:
| CustomerID | CustomerName |
|------------|--------------|
| 101        | Alice        |
| 102        | Bob          |

#### **Query**:
```sql
SELECT c.CustomerName, SUM(o.Amount) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerName;
```

#### **Result**:
| CustomerName | TotalAmount |
|--------------|-------------|
| Alice        | 500         |
| Bob          | 150         |

---

### **When to Use GROUP BY**
- To calculate aggregated metrics like totals, averages, or counts.
- To summarize data by categories (e.g., sales by region, orders by customer).
- To filter aggregated results using the `HAVING` clause.

---

GROUP BY end


