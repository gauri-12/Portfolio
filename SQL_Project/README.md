# Brazilian Olist E-commerce Data Analysis (SQL & Python)

## Project Overview

This project involves an in-depth analysis of the Brazilian Olist E-commerce Public Dataset, a real-world dataset of orders made on Olist, a Brazilian e-commerce platform. The primary goal of this project is to demonstrate proficiency in SQL for data manipulation, querying, and analysis, along with using Python for data loading and database interaction. The analysis aims to uncover insights into customer behavior, order patterns, product performance, and logistical efficiency within the Olist ecosystem.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Tools and Technologies](#tools-and-technologies)
- [Project Structure](#project-structure)
- [Setup and Installation](#setup-and-installation)
- [Database Creation and Data Loading](#database-creation-and-data-loading)
- [Data Cleaning and Transformation](#data-cleaning-and-transformation)
- [SQL Queries and Analysis](#sql-queries-and-analysis)
- [Key Findings and Conclusions](#key-findings-and-conclusions)
- [Future Work](#future-work)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Dataset

The dataset used in this project is the Olist E-commerce Public Dataset, available on Kaggle. It contains information on 100,000 orders from 2016 to 2018 made at multiple marketplaces in Brazil. The dataset is structured across several tables, including:

* `olist_customers_datase.csv`: Information about customers.
* `olist_geolocation_dataset.csv`: Geolocation data of Brazilian cities.
* `olist_order_items_dataset.csv`: Items included in each order.
* `olist_order_payments_dataset.csv`: Payment details for orders.
* `olist_order_reviews_dataset.csv`: Customer reviews for orders.
* `olist_orders_dataset.csv`: Main order details.
* `olist_products_dataset.csv`: Product information.
* `product_category_name_translation.csv`: Translation of product categories from Portuguese to English.

---

## Tools and Technologies

* **Python:** Used for data loading, database connection, and potentially some initial data wrangling.
    * Libraries: `pandas`, `sqlalchemy`, `psycopg2` (or your chosen database connector, e.g., `mysql-connector-python` for MySQL).
* **SQL (PostgreSQL/MySQL/SQLite):** For database creation, table definition, data manipulation, and complex querying.
* **Jupyter Notebook/Python Scripts:** For executing Python code and documenting the process.
* **DB Browser for SQLite / pgAdmin / MySQL Workbench:** For visual inspection of the database (optional).

---

## Project Structure


* data/                        # Raw dataset files
* ** olist_customers_dataset.csv
* ** ... (all other CSV files)
* notebooks/                   # Jupyter notebooks for data loading, analysis, and exploration
* ** 1_data_loading_and_db_setup.ipynb
* ** 2_sql_analysis_and_queries.ipynb
* ** 3_data_exploration_and_insights.ipynb
* sql/                         # SQL scripts for database schema, views, and complex queries
* ** create_tables.sql
* ** alter_tables.sql
* ** create_views.sql
* ** complex_queries.sql
* README.md                    # Project README file
* requirements.txt             # Python dependencies

---

## Setup and Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/your-repository-name.git](https://github.com/your-username/your-repository-name.git)
    cd your-repository-name
    ```

2.  **Create a virtual environment (recommended):**
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows: `venv\Scripts\activate`
    ```

3.  **Install Python dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Database Setup:**
    * Ensure your chosen SQL database (e.g., PostgreSQL, MySQL, SQLite) is installed and running.
    * If using PostgreSQL or MySQL, create a new database for this project (e.g., `olist_ecommerce`).
    * Update database connection details in your Python scripts (e.g., `1_data_loading_and_db_setup.ipynb`).

---

## Database Creation and Data Loading

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

---

## Data Cleaning and Transformation

While much of the data cleaning was handled during the Python data loading phase (e.g., setting appropriate data types, handling nulls), some transformations were performed directly within the SQL database or as part of the initial Python processing:

* **Data Type Conversions:** Ensuring columns like `order_purchase_timestamp` are stored as datetime objects.
* **Handling Missing Values:** Strategies employed for missing values (e.g., imputation, deletion) in specific columns.
* **Consistency Checks:** Ensuring consistency in categorical data (e.g., product categories, payment types).

---

## SQL Queries and Analysis

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

---

## Key Findings and Conclusions

Based on the exploration and analysis, here are some key conclusions:

* **Payment Type Distribution:** Credit card (cartao de credito) is by far the most popular payment method.
* **Customer Location Focus:** The majority of customers are concentrated in Southeast Brazil.
* **Product Performance:** "**Bed_bath_table**" is the best-performing category in terms of sales, while "**computers_accessories**" has the highest average review score.
* **Seller Insights:** There's a significant disparity in seller performance, with a small percentage of sellers accounting for a large portion of sales.
* **Review Score Impact:** Review scores appear to be influenced by delivery time and product quality.
* **Order Trends:** There's a clear seasonality in orders, with peaks during certain months.
* **Logistics Efficiency:** Delivery times vary significantly by region and freight cost.

---

## Future Work

* **Advanced SQL Techniques:** Explore window functions, common table expressions (CTEs), and recursive queries for deeper insights.
* **Data Visualization:** Integrate with tools like Tableau, Power BI, or Python libraries (Matplotlib, Seaborn) to visualize the findings.
* **Machine Learning:** Develop predictive models (e.g., for customer churn, product recommendations, delivery time prediction).
* **Performance Optimization:** Optimize queries and database schema for better performance with larger datasets.
* **ETL Pipeline:** Automate the data extraction, transformation, and loading process using tools like Apache Airflow.

---

## Contributing

Contributions are welcome! If you have suggestions for improvements, new analyses, or bug fixes, please open an issue or submit a pull request.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

[Your Name/Alias] - [Your Email/LinkedIn Profile]
