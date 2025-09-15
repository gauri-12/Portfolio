# **Brazilian Olist E-commerce Data Analysis (SQL and Python)**

## **Context and Business Motivation**
In today's competitive e-commerce landscape, understanding customer behavior, operational efficiency, and market trends is crucial for strategic growth. This project tackles a real-world business intelligence challenge: integrating and analyzing a comprehensive e-commerce dataset to derive actionable insights. By using SQL and Python, the project transforms raw, multi-source data into a structured and analyzable format.

For e-commerce businesses, having reliable, standardized data enables:
- Customer-Centric Strategy: Identifying customer behavior patterns and repeat customers to improve customer lifetime value.
- Operational Optimization: Analyzing shipping times and order statuses to enhance logistical efficiency and delivery performance.
- Product and Market Insights: Understanding top-selling products and categories to inform inventory management and strategic pricing.
- Revenue Growth: Pinpointing sales and payment trends to optimize revenue streams and business strategy.

Ultimately, this project highlights how effective data wrangling and analysis build the foundation for data-driven strategic planning and sustained business growth.

## **Table of Contents**

- [Context and Business Motivation](#context-and-business-motivation)
- [Dataset](#dataset)
- [Tools and Technologies](#tools-and-technologies)
- [Project Structure](#project-structure)
- [Database Creation and Data Loading](#database-creation-and-data-loading)
- [Data Cleaning and Transformation](#data-cleaning-and-transformation)
- [SQL Queries and Analysis](#sql-queries-and-analysis)
- [Key Findings and Conclusions](#key-findings-and-conclusions)
- [Future Work](#future-work)


## **Dataset**

The dataset used in this project is the Olist E-commerce Public Dataset, available on Kaggle. It contains information on 100,000 orders from 2016 to 2018 made at multiple marketplaces in Brazil. 
The dataset is composed of several tables, including customer, order, product, and review data.
[Data source](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The details regarding the Table structures, datatypes, primary key and foreign keys, etc can be found in the [Data Dictionary](SQL_Project/OLIST_DataDictionary.xlsx)

## **Tools and Technologies**

* **Python:** Used for data loading, database connection, and potentially some initial data wrangling.
    * Libraries: `pandas`, `sqlalchemy`, `os`
* **SQL (MySQL):** For database creation, table definition, data manipulation, and complex querying.
* **Jupyter Notebook/Python Scripts:** For executing Python code and documenting the process.

## **Project Structure**

* Dataset: This folder includes all the files mentioned under Dataset. These 9 csv files form the input to the SQL tables.
* SQL_results
   * QxResult.csv: Where 'x' denotes a question number. These csv files store the results from the queries run for gathering insights.
* Business_Insights.sql: SQL Scripts for data exploration and analysis to derive insights.
* Environment_Setup.sql: SQL Scripts for setting the database schema, updating/ altering the datatypes and constraints and creation of views for ease of analysis.
* OLIST_DataDictionary.xlsx: Data Dictionary outlining the various tables, structure, datatypes and the primary and foreign keys for each table.
* SQL_Import.ipynb: Python script to load the data from CSV files into the SQL Database.
* README.md

## **Database Creation and Data Loading**

This section details how the raw CSV data was loaded into the SQL database.

1.  **Create Database and Tables:**
    * The `sql/create_tables.sql` script contains `CREATE TABLE` statements for all necessary tables, defining appropriate data types and primary/foreign keys.
    * Run this script against your SQL database.
    * *Self-correction/Alteration:* The `sql/alter_tables.sql` script includes `ALTER TABLE` or `UPDATE` statements used to modify table structures or data as needed (e.g., adding new columns, changing data types, handling missing values, or updating incorrect entries).

2.  **Upload Data using Python:**
    * The `notebooks/1_data_loading_and_db_setup.ipynb` notebook demonstrates how to:
        * Read each CSV file into a Pandas DataFrame.
        * Establish a connection to the SQL database using SQLAlchemy.
        * Upload each DataFrame to its corresponding table in the database using `df.to_sql()`.


## **Data Cleaning and Transformation**

While much of the data cleaning was handled during the Python data loading phase (e.g., setting appropriate data types, handling nulls), some transformations were performed directly within the SQL database or as part of the initial Python processing:

* **Data Type Conversions:** Ensuring columns like `order_purchase_timestamp` are stored as datetime objects.
* **Handling Missing Values:** Strategies employed for missing values (e.g., imputation, deletion) in specific columns.
* **Consistency Checks:** Ensuring consistency in categorical data (e.g., product categories, payment types).

## **SQL Queries and Analysis**

This section covers the various SQL queries performed to explore the dataset and answer specific business questions. The queries are organized in the `sql/complex_queries.sql` file and further explained in `notebooks/2_sql_analysis_and_queries.ipynb`.

**Key Analytical Areas:**

* **Customer Analysis:**
    * Total number of unique customers.
    * Geographic distribution of customers.
    * Repeat customer behavior.
* **Order Analysis:**
    * Total orders over time (daily, monthly, yearly trends).
    * Average order value.
    * Most common payment methods.
    * Order status distribution.
* **Product Analysis:**
    * Top-selling products and categories.
    * Average product price per category.
    * Products with the highest/lowest review scores.
* **Seller Analysis:**
    * Top performing sellers by revenue and number of sales.
    * Seller distribution across states.
* **Logistics Analysis:**
    * Average shipping time.
    * Delivery performance by state.
    * Impact of freight value on customer reviews.
* **Review Analysis:**
    * Average review scores.
    * Correlation between review scores and delivery time.
    * Most common negative/positive review comments (if text data is analyzed).

**Example Complex Queries (Illustrative, replace with your actual queries):**

* **Query 1: Monthly Sales Trends and Average Order Value:**
    ```sql
    -- Example: Calculate monthly sales and average order value
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(op.payment_value) AS total_revenue,
        AVG(op.payment_value) AS average_order_value
    FROM
        orders o
    JOIN
        order_payments op ON o.order_id = op.order_id
    GROUP BY
        sales_month
    ORDER BY
        sales_month;
    ```
* **Query 2: Top 10 Product Categories by Revenue:**
    ```sql
    -- Example: Identify top 10 product categories by total revenue
    SELECT
        pct.product_category_name_english,
        SUM(oi.price + oi.freight_value) AS total_category_revenue
    FROM
        order_items oi
    JOIN
        products p ON oi.product_id = p.product_id
    JOIN
        product_category_name_translation pct ON p.product_category_name = pct.product_category_name
    GROUP BY
        pct.product_category_name_english
    ORDER BY
        total_category_revenue DESC
    LIMIT 10;
    ```
* **Query 3: Customer Lifetime Value (CLV) approximation:**
    ```sql
    -- Example: Calculate a basic CLV for customers
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(op.payment_value) AS total_spent
    FROM
        customers c
    JOIN
        orders o ON c.customer_id = o.customer_id
    JOIN
        order_payments op ON o.order_id = op.order_id
    GROUP BY
        c.customer_unique_id
    ORDER BY
        total_spent DESC;
    ```

**Views for Easy Data Analysis:**

The `sql/create_views.sql` script defines several SQL views to simplify complex queries and provide pre-aggregated or joined datasets for easier analysis. Examples include:

* `v_orders_with_customer_info`: Joins order and customer details.
* `v_order_product_details`: Combines order, item, and product information.
* `v_monthly_sales_summary`: Pre-calculates monthly sales metrics.


## **Key Findings and Conclusions**

Based on the exploration and analysis, here are some key conclusions:

* **Payment Type Distribution:** Credit card (cartao de credito) is by far the most popular payment method.
* **Customer Location Focus:** The majority of customers are concentrated in Southeast Brazil.
* **Product Performance:** "**Bed_bath_table**" is the best-performing category in terms of sales, while "**computers_accessories**" has the highest average review score.
* **Seller Insights:** There's a significant disparity in seller performance, with a small percentage of sellers accounting for a large portion of sales.
* **Review Score Impact:** Review scores appear to be influenced by delivery time and product quality.
* **Order Trends:** There's a clear seasonality in orders, with peaks during certain months.
* **Logistics Efficiency:** Delivery times vary significantly by region and freight cost.

## **Future Work**

* **Advanced SQL Techniques:** Explore window functions, common table expressions (CTEs), and recursive queries for deeper insights.
* **Data Visualization:** Integrate with tools like Tableau, Power BI, or Python libraries (Matplotlib, Seaborn) to visualize the findings.
* **Machine Learning:** Develop predictive models (e.g., for customer churn, product recommendations, delivery time prediction).
* **Performance Optimization:** Optimize queries and database schema for better performance with larger datasets.
* **ETL Pipeline:** Automate the data extraction, transformation, and loading process using tools like Apache Airflow.
