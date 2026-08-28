/* =========================================
STEP 1: Create a table for crypto tokens
This table stores basic tokenomics data
========================================= */
CREATE TABLE crypto_tokens (
    token_id INTEGER PRIMARY KEY,
    token_name TEXT,
    symbol TEXT,
    price_usd REAL,
    market_cap REAL,
    circulating_supply REAL,
    max_supply REAL,
    daily_volume REAL
)

/* =========================================
STEP 2: Insert dummy crypto data
These are fake but realistic values
========================================= */
INSERT INTO crypto_tokens VALUES
(1, 'Bitcoin', 'BTC', 43000, 850000000000, 19500000, 21000000, 25000000000),
(2, 'Ethereum', 'ETH', 2300, 280000000000, 120000000, NULL, 18000000000),
(3, 'Solana', 'SOL', 95, 42000000000, 430000000, 550000000, 3500000000),
(4, 'Cardano', 'ADA', 0.55, 19000000000, 35000000000, 45000000000, 800000000),
(5, 'Polygon', 'MATIC', 0.85, 8000000000, 9300000000, 10000000000, 600000000)

/* =========================================
STEP 3: Basic SELECT
View all crypto data
========================================= */
SELECT *
FROM crypto_tokens

/* =========================================
STEP 4: SELECT specific columns
Used to limit returned data
========================================= */
SELECT token_name, symbol, price_usd, market_cap
FROM crypto_tokens

/* =========================================
STEP 5: WHERE clause
Filter tokens with market cap above 50B
========================================= */
SELECT token_name, market_cap
FROM crypto_tokens
WHERE market_cap > 50000000000

/* =========================================
STEP 6: ORDER BY
Sort tokens by market cap descending
========================================= */
SELECT token_name, market_cap
FROM crypto_tokens
ORDER BY market_cap DESC

/* =========================================
STEP 7: Calculated column
Volume to market cap ratio
========================================= */
SELECT
    token_name,
    daily_volume,
    market_cap,
    daily_volume / market_cap AS volume_marketcap_ratio
FROM crypto_tokens

/* =========================================
STEP 8: CASE statement
Classify tokens by size
========================================= */
SELECT
    token_name,
    market_cap,
    CASE
        WHEN market_cap >= 100000000000 THEN 'Large Cap'
        WHEN market_cap >= 10000000000 THEN 'Mid Cap'
        ELSE 'Small Cap'
    END AS market_cap_category
FROM crypto_tokens

/* =========================================
STEP 9: Aggregate functions
Average price and total market cap
========================================= */
SELECT
    AVG(price_usd) AS avg_price,
    SUM(market_cap) AS total_market_cap
FROM crypto_tokens

/* =========================================
STEP 10: GROUP BY
Average price by market cap category
========================================= */
SELECT
    CASE
        WHEN market_cap >= 100000000000 THEN 'Large Cap'
        WHEN market_cap >= 10000000000 THEN 'Mid Cap'
        ELSE 'Small Cap'
    END AS category,
    AVG(price_usd) AS avg_price
FROM crypto_tokens
GROUP BY category


/* =========================================
Week 4 Homework in SQLiteStudio:
• Create a table for storing crypto price and volume data
• Insert at least 5 rows of historical BTC or ETH price data
Write in Your Homework Document:
• SQL commands you used to create the table and insert data
• A sample query retrieving the highest price in your dataset

========================================= */

/* =========================================
Create a table for storing crypto price and volume data
========================================= */
CREATE TABLE crypto_price_history (
    record_id INTEGER PRIMARY KEY,
    token_symbol TEXT NOT NULL,
    price_date TEXT NOT NULL,
    close_price_usd REAL NOT NULL,
    daily_volume_usd REAL NOT NULL
);

/* =========================================
Insert 5 rows of historical BTC price and volume data
========================================= */
INSERT INTO crypto_price_history (token_symbol, price_date, close_price_usd, daily_volume_usd)
VALUES
    ('BTC', '2024-01-01', 42000.00, 18000000000),
    ('BTC', '2024-01-02', 43500.00, 19500000000),
    ('BTC', '2024-01-03', 44800.00, 21000000000),
    ('BTC', '2024-01-04', 46200.00, 22500000000),
    ('BTC', '2024-01-05', 47000.00, 24000000000);

/* =========================================
Sample query: retrieve the highest price in the dataset
========================================= */
SELECT MAX(close_price_usd) AS highest_price
FROM crypto_price_history;


/* =========================================
Putting code into SQLiteStudio:
========================================= */
To run SQL code in SQLiteStudio, you first need a database set up in the app to hold and execute your queries.

---

### Step 1: Create or Connect to a Database

If you do not already have a database file loaded in SQLiteStudio:

1. Click **Database** in the top menu bar, then click **Add a database** (or press **`Ctrl + O`** / **`Cmd + O`**).
2. Next to the **File** field, click the folder icon to choose where to save your new database file (e.g., name it `my_database.db`).
3. Click **OK**. Your new database will now appear in the **Databases** list on the left pane.

---

### Step 2: Open the SQL Editor

1. Open the SQL Editor by clicking **Tools** in the top menu and selecting **Open SQL editor** (or press **`Ctrl + E`** / **`Cmd + E`**).
2. Look at the **Database drop-down menu** at the top of the SQL Editor tab. Make sure your target database (e.g., `my_database`) is selected in the list.

---

### Step 3: Paste and Execute Your Code

1. Copy your SQL code and paste it directly into the top main text field of the SQL Editor.
2. Click the **Execute Query** button on the editor toolbar (it looks like a **Blue/Green Play Triangle** ▶), or press **`F9`**.

---

### Step 4: View Your Results

* **For `SELECT` queries:** Your requested data will appear in the **Results / Grid View** tab in the middle pane below your code.
* **For `CREATE TABLE` or `INSERT` queries:** Check the **Status** log at the bottom to verify the query executed successfully without errors.
* **To check updated tables:** Double-click any table name in the left **Databases** sidebar to open it, then switch to its **Data** tab to see your records visually.
