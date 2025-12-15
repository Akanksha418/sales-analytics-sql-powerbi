# Madhav E-Commerce Sales Analysis

## Project Overview
This project is an end-to-end **E-commerce Sales Analytics** solution built using **MySQL and Power BI**.  
The goal of the project is to design a clean relational database, perform data cleaning and transformation, 
and generate business insights using SQL queries that directly power an interactive Power BI dashboard.

---

## Tech Stack
- **Database:** MySQL  
- **Visualization:** Power BI  
- **Data Source:** CSV files (Orders & Order Details)  

---

## Dataset Description
The project uses two datasets:
- **Orders:** Contains order-level information such as order date, customer name, state, and city.
- **Order Details:** Contains transaction-level data including amount, profit, quantity, category, sub-category, and payment mode.

---

## Database Design
The database follows a **relational model**:
### Tables
- **orders**
  - order_id (Primary Key)
  - order_date
  - customer_name
  - state
  - city
- **order_details**
  - order_id (Foreign Key)
  - amount
  - profit
  - quantity
  - category
  - sub_category
  - payment_mode

### Relationships
- One-to-many relationship between `orders` and `order_details`
- Enforced using **Primary Key – Foreign Key constraints**

---

## Data Preparation & Cleaning
- Imported raw CSV files into MySQL
- Renamed columns to follow SQL naming standards
- Converted order date from text format to proper `DATE` datatype
- Validated data integrity using joins and checks
- Handled loss-making and duplicate records

---

## Key SQL Analysis Performed
- Total sales, profit, quantity, and average order value (AOV)
- State-wise and customer-wise sales analysis
- Category and sub-category performance
- Monthly profit trends
- Payment mode distribution
- Loss-making orders and data quality checks
- JOIN-based analytics between orders and order details

---

## Power BI Dashboard
The Power BI dashboard visualizes:
- KPI cards (Sales, Profit, Quantity, AOV)
- State-wise sales distribution
- Category-wise quantity contribution
- Monthly profit trends
- Top customers by sales
- Payment mode analysis
- Sub-category profit analysis

Each visual in the dashboard is backed by an equivalent **SQL query**.

Below is the interactive Power BI dashboard built on top of the MySQL analysis:
![Power BI Dashboard](images/dashboard.png)

---

## Business Insights
- Maharashtra contributes the highest sales
- Clothing category drives the highest quantity
- Cash on Delivery (COD) is the most used payment mode
- Printers are the most profitable sub-category
- Certain sub-categories consistently generate losses

---

##  Repository Structure
madhav-ecommerce-sales-analysis/
│
├── sql/
│ └── sales_prj.sql
│
├── powerbi/
│ └── MADHAV E-COMMERCE SALES DASHBOARD.pbix
│
├── data/
│ ├── Orders.csv
│ └── Details.csv
│
└── README.md


---

## How to Use
1. Create the database using the SQL script
2. Import the CSV files into MySQL
3. Run the SQL queries for analysis
4. Connect Power BI to MySQL or use the provided `.pbix` file
5. Explore insights through the dashboard

---

## Key Learnings
- Relational database design and normalization
- Writing business-driven SQL queries
- Using joins, aggregations, and date functions
- Connecting SQL analytics to Power BI dashboards
- Translating raw data into actionable insights

---

## Contact
If you have feedback or suggestions, feel free to connect on GitHub or LinkedIn.

