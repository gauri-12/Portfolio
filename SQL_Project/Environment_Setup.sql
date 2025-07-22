/* -------------------------------------- STEP 1: CREATE DATABASE  --------------------------------------*/

create database if not exists olist ;
USE olist;

/* -------------------------------------- STEP 2: CREATE EMPTY TABLES  --------------------------------------*/
create table if not exists customers(
customer_id VARCHAR(50) PRIMARY KEY,
customer_unique_id VARCHAR(50) NOT NULL UNIQUE,
customer_zip_code_prefix TINYINT, 
customer_city TEXT ,
customer_state TEXT 
);

create table if not exists orders(
order_id VARCHAR(50) PRIMARY KEY,
customer_id VARCHAR(50) NOT NULL ,
order_status TEXT NOT NULL,
order_purchase_timestamp DATETIME NOT NULL,
order_approved_at DATETIME ,
order_delivered_carrier_date DATETIME ,
order_delivered_customer_date DATETIME ,
order_estimated_delivery_date DATETIME NOT NULL,
delivery_days INT ,#--> to be inserted with values once data is uploaded
late_delivery_flag BINARY, #--> to be inserted with values once data is uploaded
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

create table if not exists order_reviews(
review_id VARCHAR(50) NOT NULL,
order_id VARCHAR(50) NOT NULL ,
review_score TINYINT NOT NULL,
review_comment_title VARCHAR(255),
review_comment_message TEXT,
review_creation_date DATETIME NOT NULL,
review_answer_timestamp DATETIME,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT PK_items PRIMARY KEY (review_id,order_id)
);



create table if not exists products(
product_id VARCHAR(50) PRIMARY KEY,
product_category_name VARCHAR(100),
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g INT,
product_length_cm INT ,
product_height_cm INT ,
product_width_cm INT ,
product_category_name_english VARCHAR(100)#--> to be inserted with values once data is uploaded
);

create table if not exists product_category_name(
product_category_name VARCHAR(100) ,
product_category_name_english VARCHAR(100) 
);


create table if not exists geolocation(
geolocation_zip_code_prefix INT NOT NULL,
geolocation_lat DECIMAL(10,8) NOT NULL,
geolocation_lng DECIMAL(11,8) NOT NULL,
geolocation_city VARCHAR(100) NOT NULL,
geolocation_state VARCHAR(2) NOT NULL
);


create table if not exists order_payments(
order_id VARCHAR(50) NOT NULL,
payment_sequential TINYINT  NOT NULL,
payment_type VARCHAR(50) NOT NULL,
payment_installments TINYINT NOT NULL,
payment_value DECIMAL(10,2) NOT NULL,
CONSTRAINT PK_payments PRIMARY KEY (order_id,payment_sequential),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


create table if not exists sellers(
seller_id VARCHAR(50) PRIMARY KEY,
seller_zip_code_prefix INT NOT NULL,
seller_city VARCHAR(100) NOT NULL,
seller_state VARCHAR(2) NOT NULL
);



create table if not exists order_items(
order_id VARCHAR(50) NOT NULL,
order_item_id INT NOT NULL,
product_id VARCHAR(50) NOT NULL,
seller_id VARCHAR(50) NOT NULL,
shipping_limit_date DATETIME NOT NULL,
price DECIMAL(10,2) NOT NULL,
freight_value DECIMAL(10,2) NOT NULL,
CONSTRAINT PK_items PRIMARY KEY (order_id,order_item_id),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);




/* -------------------------------------- STEP 3: ALTER TABLES BASED ON FINDINGS FROM INPUT DATA  --------------------------------------*/
/*Some issues were found when loading the data into the sql tables. To address this, table is altered to
ensure smooth data uploads */

ALTER TABLE customers
MODIFY COLUMN customer_zip_code_prefix INT;


/* it seems there are duplicates in the customer_unique_id field causing issues while loading the data.
This constraint needs to be removed to ensure smooth data upload */

SHOW INDEXES FROM customers;

ALTER TABLE customers
DROP INDEX customer_unique_id;



/* -------------------------------------- STEP 4: DATA LOAD INSPECTION  --------------------------------------*/
SELECT COUNT(*) AS customer_count FROM customers; #99441
SELECT COUNT(*) AS orders_count  FROM orders; #99441
SELECT COUNT(*) AS order_reviews_count FROM order_reviews; #99224
SELECT COUNT(*) AS products_count FROM products; #32951
SELECT COUNT(*) AS prod_cat_count FROM product_category_name; #71
SELECT COUNT(*) AS payments_count FROM order_payments; #103886
SELECT COUNT(*) AS geolocation_count FROM geolocation; #1000163
SELECT COUNT(*) AS sellers_count FROM sellers; #3095
SELECT COUNT(*) AS order_items_count FROM order_items; #112650

#comparing the outputs above from the numbers seen in the python code, it all aligns. Data successfully uploaded!

/* -------------------------------------- STEP 5: CREATE BACKUP FOR ALL TABLES BEFORE WORKING ON IT  --------------------------------------*/
CREATE TABLE customers_bkup AS
SELECT * FROM customers;

CREATE TABLE orders_bkup AS
SELECT * FROM orders;

CREATE TABLE order_reviews_bkup AS
SELECT * FROM order_reviews;

CREATE TABLE products_bkup AS
SELECT * FROM products;

CREATE TABLE product_category_name_bkup AS
SELECT * FROM product_category_name;

CREATE TABLE geolocation_bkup AS
SELECT * FROM geolocation;

CREATE TABLE order_payments_bkup AS
SELECT * FROM order_payments;

CREATE TABLE sellers_bkup AS
SELECT * FROM sellers;

CREATE TABLE order_items_bkup AS
SELECT * FROM order_items;



/* -------------------------------------- STEP 6: EXPLORE THE TABLES  --------------------------------------*/
select * from customers limit 10; #trim city name. ensure all state codes are capitals and trimmed. 
select distinct customer_state from customers where customer_state != upper(customer_state); #no need to standardize state
select distinct * from customers where (customer_city != trim(customer_city)) or (customer_state != trim(customer_state)); # all records are trimmed. no update necessary


select * from orders limit 10;
select distinct order_status,count(*) from orders group by order_status; #all statuses as expected. nothing out of ordinary                                                                                                        
select distinct * from orders where (order_status != trim(order_status)); # all rorder statuses are trimmed. no update necessary

select * from order_reviews limit 10;
select distinct review_score,count(*) from order_reviews group by review_score; #all scores between 1 and 5

select * from products limit 10; 
select distinct count(product_category_name) from products; #There are 32,341 different product names
select distinct * from products where (product_category_name != trim(product_category_name)); # all product_category_name are trimmed. no update necessary

select * from product_category_name limit 10;
select distinct * from product_category_name where (product_category_name != trim(product_category_name)) or 
(product_category_name_english != trim(product_category_name_english)); # all records are trimmed. no update necessary


select * from geolocation limit 10; #ensure all state codes are capitals.
select distinct geolocation_state, count(*) from geolocation group by geolocation_state; #all states are 2 letter values and capitals
select distinct geolocation_state from geolocation where geolocation_state != upper(geolocation_state); #no need to standardize state
select distinct * from geolocation where (geolocation_state != trim(geolocation_state)) or (geolocation_city!= trim(geolocation_city)); 
# 1 row returned. Trim both the state and the city in the geolocation table


select * from order_payments limit 10; #standardize the payment type
select distinct payment_type, count(*) from order_payments group by payment_type; #boleto and voucher are a separate category here. However, they should be the same
select distinct payment_installments, count(*) from order_payments group by payment_installments order by payment_installments; #maximum time allowed to pay is 2 years
select distinct * from order_payments where (payment_type != trim(payment_type)) ; # all records are trimmed. no update necessary



select * from sellers limit 10; #ensure all state codes are capitals.
select distinct seller_state from sellers; #all caps state codes
select distinct seller_state from sellers where seller_state != upper(seller_state); #no need to standardize state
select distinct * from sellers where (seller_state != trim(seller_state)) or (seller_city != trim(seller_city)); # all records are trimmed. no update necessary


select * from order_items limit 10;





/* -------------------------------------- STEP 7: UPDATE DATATYPES AND STANDARDIZE AS NEEDED  --------------------------------------*/
/* Updates to make: 1. In order_payments table, combine the boleto and voucher payment options into 1.
2.In geolocation table, trim both the state and city values.
*/

    
/* 1. In order_payments table, combine the boleto and voucher payment options into 1.*/    
ALTER TABLE order_payments
ADD COLUMN updated_payment_type VARCHAR(50)
GENERATED always AS (
case when payment_type='boleto' then 'voucher'
else payment_type end )  ;


/*verify update on order_payments*/
select distinct updated_payment_type,payment_type, count(*) 
from order_payments 
group by updated_payment_type,payment_type; 


/* 2.In geolocation table, trim both the state and city values. */
UPDATE geolocation 
SET geolocation_state = TRIM(geolocation_state),
	geolocation_city = TRIM(geolocation_city);
    
/*verify update on geolocation*/
select distinct * from geolocation where (geolocation_state != trim(geolocation_state)) or (geolocation_city!= trim(geolocation_city)); 






/* -------------------------------------- STEP 8: CREATE DERIVED COLUMNS  --------------------------------------*/

/* A. Create the product_category_name_english field in the products table. View the table before column creation*/
select  * from products limit 10;

#calculate field
UPDATE products a
LEFT JOIN product_category_name b
    on a.product_category_name = b.product_category_name
sET a.product_category_name_english=b.product_category_name_english;

#verify update
select  * from products limit 10;



/* B. Create the delivery_days and late_delivery_flag in orders table. View the table before column creation*/
select  * from orders limit 10;

ALTER TABLE orders MODIFY COLUMN late_delivery_flag TINYINT(1);

UPDATE orders
SET delivery_days = DATEDIFF(order_delivered_customer_date,order_purchase_timestamp),
late_delivery_flag = case when date(order_delivered_customer_date)>order_estimated_delivery_date THEN 1 ELSE 0 END;

#verify update
select  * from orders limit 10;
select * from orders where late_delivery_flag !=0;


/* -------------------------------------- STEP 9: CREATE VIEWS  --------------------------------------*/
/* A. Create a view combining orders and the respective customers */
#DROP VIEW v_order_details;
CREATE VIEW v_order_details AS
SELECT o.order_id,
c.customer_id,
c.customer_unique_id,
o.order_status,
o.order_purchase_timestamp,
op.payment_total,
op.payment_types_list,
op.num_payment_installments,
o.order_approved_at,
c.customer_city,
c.customer_state,
c.customer_zip_code_prefix,
o.order_delivered_carrier_date,
o.order_delivered_customer_date,
o.order_estimated_delivery_date,
o.delivery_days,
o.late_delivery_flag ,
r.total_review_score,
r.total_reviews,
r.average_review_score
from orders o
inner join customers c
	on o.customer_id = c.customer_id
left join (
		SELECT order_id, 
        SUM(payment_value) as payment_total,
        MAX(payment_installments) as num_payment_installments,
        GROUP_CONCAT(DISTINCT updated_payment_type ORDER BY payment_type ASC SEPARATOR ', ') AS payment_types_list
		FROM order_payments p
        GROUP BY order_id
        ) as op on op.order_id = o.order_id
        
LEFT JOIN (
	SELECT order_id,SUM(review_score) as total_review_score, COUNT(order_id) as total_reviews, AVG(review_score) as average_review_score 
    FROM order_reviews
    GROUP BY order_id
) AS r ON r.order_id = o.order_id;


#verify view creation
select count(*) from v_order_details;




/* B. Create a view combining order items, reviews and the products */
CREATE VIEW v_item_details AS
SELECT o.order_id,
o.order_item_id,
o.price,
o.product_id,
o.seller_id,
o.freight_value,
p.product_category_name_english,
p.product_height_cm,
p.product_length_cm,
p.product_width_cm,
p.product_weight_g
FROM order_items o
LEFT JOIN products p
	on o.product_id = p.product_id;


#verify view creation
select count(*) from v_item_details;    
    
/* C. Create a view combining seller information with the views created above */
CREATE VIEW v_seller_performance AS
WITH SellerSales as (
	SELECT seller_id,
		SUM(price+ freight_value) as total_sales_price,
        count(*) as total_sold,
		count(distinct oi.order_id) as total_shipped
    FROM order_items oi
    GROUP BY seller_id
),

SellerDelivery as (
	SELECT oi.seller_id,
		AVG(o.delivery_days) as average_delivery_days,
        SUM(late_delivery_flag) AS total_late_deliveries,
        COUNT(distinct o.order_id) as total_deliveries,
        SUM(case when date(o.order_delivered_carrier_date) > date(oi.shipping_limit_date) then 1 else 0 end) as total_shipping_delays
    from order_items oi
    left join orders o
		ON o.order_id=oi.order_id
	GROUP BY oi.seller_id
),

SellerReviews as (
    SELECT oi.seller_id, AVG(vod.average_review_score) AS avg_seller_review -- Get order-level avg review
    FROM order_items oi
    LEFT JOIN v_order_details vod
        ON oi.order_id = vod.order_id
    GROUP BY oi.seller_id
)


SELECT ss.*, sd.average_delivery_days,sd.total_late_deliveries,sd.total_deliveries, sd.total_shipping_delays, sr.avg_seller_review
FROM SellerSales ss
left join SellerDelivery sd on ss.seller_id = sd.seller_id
left join SellerReviews sr on ss.seller_id = sr.seller_id;
 
 
 #verify view creation
select count(*) from v_seller_performance;

