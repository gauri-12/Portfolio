/* -------------------------------------- BUSINESS INSIGHTS QUESTIONS  --------------------------------------*/
/*
1. Overall snapshot
2. Overall performance
3. Product portfolio performance
4. Monthly sales trends
5. Top spenders
6. Delivery timeliness
7. Delivery challenges by region 
8. Seller performance
9. Month-over-month trends
10. Product sales 
*/


/* -------------------------------------- QUESTION 1 : OVERALL BUSINESS SNAPSHOT --------------------------------------*/
/* What is the total number of unique orders, unique customers (by customer_unique_id), and unique products available in the dataset? 
What is the earliest and latest order purchase date? */
SELECT COUNT(distinct order_id) as unique_orders,
	min(order_purchase_timestamp) as earliest_order_purchase_date,
    max(order_purchase_timestamp) as latest_order_purchase_date
FROM orders;

/*# unique_orders, earliest_order_purchase_date, latest_order_purchase_date
'99441', '2016-09-04 21:15:19', '2018-10-17 17:30:18'*/


SELECT	COUNT(distinct customer_unique_id) as unique_customers from customers;

/*# unique_customers
'96096'
*/

SELECT  COUNT(distinct product_id) as unique_products FROM products;
/*# unique_products
'32951'
*/


/* -------------------------------------- QUESTION 2 : OVERALL PERFORMANCE --------------------------------------*/
/* 2. What is the average total payment value per order? 
What is the average number of days it takes for an order to be delivered to the customer, and what is the maximum delivery time observed?
*/
select avg(vod.payment_total) as avg_tot_payment, avg(delivery_days) as avg_delivery_days, max(delivery_days) as max_delivery_time
from v_order_details vod;
/*# avg_tot_payment, avg_delivery_days, max_delivery_time
'160.990267', '12.4973', '210'
*/


/* -------------------------------------- QUESTION 3 : PRODUCT PORTFOLIO PERFORMANCE : REVENUE VS SATISFACTION --------------------------------------*/
/* 3. Identify the top 5 product categories by total sales revenue. For these top categories, what is their average customer review score?
*/
select product_category_name_english, sum(price+freight_value) as total_sales_revenue, avg(average_review_score) as avg_customer_review_score
from v_item_details vid
left join v_order_details vod
	on vod.order_id=vid.order_id
group by product_category_name_english
order by total_sales_revenue desc
limit 5;

/* -------------------------------------- QUESTION 4 : MONTHLY SALES TREND --------------------------------------*/
/* 4. Analyze the total sales revenue and the total number of orders on a monthly basis across the entire dataset period. 
Which month had the highest sales, and which had the most orders?
*/

select EXTRACT(YEAR_MONTH FROM order_purchase_timestamp) AS Order_YM, 
	sum(payment_total) as monthly_sales_revenue, 
    count(distinct order_id) as monthly_total_orders
from v_order_details vod
group by Order_YM;


/* -------------------------------------- QUESTION 5 : TOP SPENDERS --------------------------------------*/
/* 5.Identify the top 10% of customers based on their total lifetime spending. 
What is the average order count and average delivery days for customers in this high-value segment?
*/

with cte_customer_details as (
	select customer_id, sum(payment_total) as total_cust_spending, count(order_id) as customer_order_count, avg(delivery_days) as avg_cust_deldays
    from v_order_details
    where payment_total is not null
    group by customer_id
),

cte_percent_rank as(
	select customer_id,total_cust_spending,customer_order_count, avg_cust_deldays, percent_rank() over (order by total_cust_spending desc) as cust_percentage
	from cte_customer_details)


select count(distinct rk.customer_id) as total_customers, avg(customer_order_count) as avg_order_count ,avg(avg_cust_deldays) as avg_delivery_days
from cte_percent_rank rk
where cust_percentage >= 0.9;


/* -------------------------------------- QUESTION 6 : DELIVERY TIMELINESS --------------------------------------*/
/* 6. Categorize orders into 'Early/On-Time' (delivery days ≤ 0 or late_delivery_flag = 0), 
'Slightly Late' (delivery days between 1 and 3, 
or late_delivery_flag = 1 and delivery days ≤ 3), and '
Very Late' (delivery days >3 and late_delivery_flag = 1). 

What is the count and percentage of orders in each category?
*/
with cte_categories as(
	select vod.order_id, delivery_days,late_delivery_flag,
		case 
			when (delivery_days <=7 and late_delivery_flag=1) then 'Slightly late'
            when delivery_days>7 and late_delivery_flag=1 then 'Very late'
            when delivery_days <=0 or late_delivery_flag=0 then 'Early/On-Time'
            else 'Undetermined - Missing data'
            end as delivery_timeline
    from v_order_details vod
)

select delivery_timeline, count(order_id) as total_orders, round((count(order_id)/(select count(*) from v_order_details))*100,2) as pct_orders
from cte_categories
group by delivery_timeline;



/* -------------------------------------- QUESTION 7 : DELIVERY CHALLENGES BY REGION --------------------------------------*/
/* 7. Which customer states have the highest percentage of late deliveries? 
For these states, what is their average freight value, and is there a noticeable correlation?

*/

select customer_state,
    sum(late_delivery_flag) as total_late_deliveries,
    COUNT(distinct vod.order_id) as total_deliveries,
    (sum(late_delivery_flag)/COUNT(distinct vod.order_id))*100 as pct_late_deliveries, 
    AVG(vid.freight_value) AS avg_freight_value
from v_order_details vod
left join v_item_details vid
	on vid.order_id = vod.order_id
group by customer_state
having total_deliveries>50
order by pct_late_deliveries desc;


/* -------------------------------------- QUESTION 8 : SELLER PERFORMANCE --------------------------------------*/
/* 8. Identify the top 10 sellers by total sales revenue and the bottom 10 sellers by average customer review score (minimum 50 orders). 
What are their respective average delivery times and late delivery rates?
*/
with top_10 as (
select seller_id,total_sales_price, avg_seller_review, average_delivery_days, total_late_deliveries
from v_seller_performance
where total_sold>=50 and total_sales_price is not null
order by total_sales_price desc
limit 10),
bottom_10 as (
select seller_id,total_sales_price, avg_seller_review, average_delivery_days, total_late_deliveries
from v_seller_performance
where total_sold>=50 and avg_seller_review is not null
order by avg_seller_review asc
limit 10)

select 'Top 10 by sales' as Category, a.*
from top_10 a
UNION ALL
select 'Bottom 10 by review' as Category,b.*
from bottom_10 b;

/* -------------------------------------- QUESTION 9 : MONTH-OVER-MONTH TRENDS --------------------------------------*/
/* 9. Calculate the month-over-month percentage change in total sales revenue for the entire marketplace. 
Highlight months with the highest growth rates and the most significant declines.
*/

with cte_sales as (
	select EXTRACT(YEAR_MONTH FROM order_purchase_timestamp) AS Order_YM,
		sum(payment_total) as total_sales_revenue
	from v_order_details vod
    group by Order_YM
)

select Order_YM,
total_sales_revenue as current_month_sales,
LAG(total_sales_revenue) over (order by Order_YM) as previous_month_sales,
 ((total_sales_revenue- LAG(total_sales_revenue) over (order by Order_YM))/(NULLIF(LAG(total_sales_revenue) OVER (ORDER BY Order_YM), 0)))*100 as pct_change_growth
from cte_sales
order by Order_YM;


/* -------------------------------------- QUESTION 10 : PRODUCT SALES --------------------------------------*/
/* 10. For each product category, calculate the cumulative total sales revenue over time (ordered by order purchase date). 
Display this cumulative sum alongside the individual order details for that category to show its growth trajectory
*/

with cte_top5_products as (
select product_category_name_english, 
	sum(price+freight_value) as total_sales_revenue
from v_item_details vid
group by product_category_name_english
order by total_sales_revenue desc
limit 5),

filtered_details as (
select product_category_name_english, 
	order_purchase_timestamp, 
	(price+freight_value) as total_sales_val,
    vid.order_id,
    vid.order_item_id
from v_item_details vid
inner join v_order_details vod
	on vod.order_id=vid.order_id
where product_category_name_english in (select product_category_name_english from cte_top5_products)
	and order_purchase_timestamp is not null
    and (price+freight_value) is not null
)

select product_category_name_english, 
	order_purchase_timestamp,
    total_sales_val,
    sum(total_sales_val) over (partition by product_category_name_english order by order_purchase_timestamp, order_id, order_item_id) as cumulative_sum
from filtered_details
order by product_category_name_english, order_purchase_timestamp, order_id, order_item_id;