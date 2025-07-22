CREATE TABLE IF NOT EXISTS olist.order_reviews (
        review_id INT PRIMARY KEY,
        order_id VARCHAR(50) NOT NULL,
        review_score VARCHAR(255),
        review_comment_title VARCHAR(255),
        review_comment_message VARCHAR(255),
        review_creation_date VARCHAR(50),
        review_answer_timestamp VARCHAR(50)
);

#accidentally set some incorrect datatypes. Change these
ALTER TABLE order_reviews
MODIFY COLUMN review_id VARCHAR(50),
MODIFY COLUMN review_creation_date DATETIME,
MODIFY COLUMN review_answer_timestamp DATETIME
;

CREATE TABLE IF NOT EXISTS main.customers (
        customer_id VARCHAR(50) NOT NULL,
        customer_unique_id VARCHAR(50) PRIMARY KEY,
        customer_zip_code_prefix INT,
        customer_city VARCHAR(50),
        customer_state VARCHAR(2)
);