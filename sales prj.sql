/*
Project: Madhav E-Commerce Sales Analysis
Tech: MySQL, Power BI
Description:
- Designed relational schema (orders & order_details)
- Cleaned and transformed raw CSV data
- Performed sales, profit, customer, and trend analysis
- Queries mapped directly to Power BI dashboard visuals
*/

CREATE database sales_db;
use sales_db;

CREATE TABLE orders (
    `Order ID` VARCHAR(20),
    `Order Date` VARCHAR(20),
    Customer VARCHAR(100),
    State VARCHAR(50),
    City VARCHAR(50)
);

SELECT COUNT(*) FROM orders;
SELECT * FROM orders LIMIT 5;

-- Rename columns to follow SQL naming standards
-- Spaces in column names cause problems in queries and joins
ALTER TABLE orders
CHANGE `Order ID` order_id VARCHAR(20),      -- Unique order identifier
CHANGE `Order Date` order_date VARCHAR(20),  -- Order date (currently text)
CHANGE Customer customer_name VARCHAR(100);  -- Customer name

-- Add new DATE column
ALTER TABLE orders
ADD order_date_new DATE;

-- Convert text date (dd-mm-yyyy) to DATE
SET SQL_SAFE_UPDATES = 0;
UPDATE orders
SET order_date_new = STR_TO_DATE(order_date, '%d-%m-%Y');

-- Remove old text date column
ALTER TABLE orders
DROP order_date;

-- Rename DATE column
ALTER TABLE orders
CHANGE order_date_new order_date DATE;

-- Check converted dates
SELECT order_date FROM orders LIMIT 5;

CREATE TABLE order_details (
    order_id VARCHAR(20),
    amount INT,
    profit INT,
    quantity INT,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    payment_mode VARCHAR(20)
);

SELECT COUNT(*) FROM order_details;
SELECT * FROM order_details LIMIT 5;

-- Add primary key to uniquely identify each order
ALTER TABLE orders
ADD PRIMARY KEY (order_id);

-- Add foreign key to link order_details with orders table
ALTER TABLE order_details
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- KPI CARDS
-- Sum of Amount (438K)
SELECT SUM(amount) FROM order_details;
-- (438K)

-- Sum of Profit 
SELECT SUM(profit) FROM order_details;
-- (37K)

-- Sum of Quantity 
SELECT SUM(quantity) FROM order_details;
-- (5615)

--  Average Order Value
SELECT SUM(amount) / COUNT(DISTINCT order_id) AS avg_order_value
FROM order_details;
-- (121K) 

-- Sum of Amount by State
SELECT o.state, SUM(d.amount) AS total_sales
FROM orders o
JOIN order_details d
ON o.order_id = d.order_id
GROUP BY o.state;

-- Sum of Quantity by Category
SELECT category, SUM(quantity)
FROM order_details
GROUP BY category;

-- month-wise profit
SELECT MONTHNAME(o.order_date), SUM(d.profit)
FROM orders o
JOIN order_details d
ON o.order_id = d.order_id
GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY MONTH(o.order_date);

-- Sum of Amount by Customer Name
SELECT o.customer_name, SUM(d.amount)
FROM orders o
JOIN order_details d
ON o.order_id = d.order_id
GROUP BY o.customer_name
ORDER BY SUM(d.amount) DESC;

-- Top 5 customers 
SELECT o.customer_name, SUM(d.amount)
FROM orders o
JOIN order_details d
ON o.order_id = d.order_id
GROUP BY o.customer_name
ORDER BY SUM(d.amount) DESC
LIMIT 5;

-- Sum of Quantity by Payment Mode
SELECT payment_mode, SUM(quantity)
FROM order_details
GROUP BY payment_mode;

-- Sum of Profit by Sub-Category
SELECT sub_category, SUM(profit)
FROM order_details
GROUP BY sub_category
ORDER BY SUM(profit) DESC;

-- Shows data integrity
SELECT d.order_id
FROM order_details d
LEFT JOIN orders o
ON d.order_id = o.order_id
WHERE o.order_id IS NULL;

-- loss-making products
SELECT *
FROM order_details
WHERE profit < 0;

-- Duplicate order check
SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


