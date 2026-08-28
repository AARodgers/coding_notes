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
