create database project;
use project;
show databases;

select * from pizza_sales;
-- Total Revenue of pizza sales
select sum(total_price) as Total_Revenue from pizza_sales;

-- Total Orders 
select count(distinct(order_id)) as total_orders from pizza_sales;

-- Average Order Value
select sum(total_price)/count(distinct(order_id)) as Average_order_value from pizza_sales;

-- Total Pizza Solds
select sum(quantity) as total_pizza_solds from pizza_sales;

-- Average pizza's per order
select sum(quantity)/count(distinct(order_id)) as Average_order from pizza_sales;
select cast(sum(quantity)/count(distinct(order_id)) as decimal (10,2)) as Average_order from pizza_sales;

-- Daily trend for total orders
select dayname(order_date) as weekday_name 
, count(distinct(order_id)) from pizza_sales 
group by weekday_name;

-- changing from dd-mm-yyyy to yyyy-mm-dd format
alter table pizza_sales add column orders_date date;
update  pizza_sales set orders_date = STR_TO_DATE(order_date, '%d-%m-%Y');
select * from pizza_sales;

select dayname(orders_date) as weekday_name , count(distinct(order_id)) as total_orders from pizza_sales
group by weekday_name
order by total_orders desc;

-- Monthly trend for total orders
select monthname(orders_date) as month_name , count(distinct(order_id)) as total_orders from pizza_sales
group by month_name order by total_orders desc;

-- Percentage of Sales by Pizza Category 
select pizza_category,sum(total_price)*100/(select sum(total_price) from pizza_sales)
 as percentage_of_sales
from pizza_sales
group by pizza_category;

-- using cast 
select pizza_category,cast(sum(total_price)*100/(select sum(total_price) from pizza_sales ) as decimal(10,2))
 as percentage_of_sales
from pizza_sales
group by pizza_category
order by percentage_of_sales desc;

-- filtering by month
select pizza_category,cast(sum(total_price) as decimal(10,2))as total_sales,cast(sum(total_price)*100/(select sum(total_price)
 from pizza_sales where month(orders_date) = 1) as decimal(10,2))
 as percentage_of_sales
from pizza_sales
where month(orders_date) = 1
--  or 
-- where monthname(orders_date) = 'January'
group by pizza_category;

-- Percentage of Sales by Pizza Size

select pizza_size,cast(sum(total_price) as decimal (10,2)) as total_sales, 
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal(10,2))
as percentage_of_sales from pizza_sales
group by pizza_size
order by percentage_of_sales desc;

-- Top 5 pizzas by total revenue 

select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc limit 5;

-- Bottom 5 pizzas by total revenue
select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc limit 5;

-- Top 5 pizzas by Total Quantity

select pizza_name,sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc limit 5;

-- Bottom 5 pizzas by Total Quantity
select pizza_name,sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity asc limit 5;

-- Top 5 pizzas by Total orders
select pizza_name,count(distinct(order_id)) as total_orders from pizza_sales
group by pizza_name
order by total_orders desc limit 5;

-- Bottom 5 pizzas by Total orders
select pizza_name,count(distinct(order_id)) as total_orders from pizza_sales
group by pizza_name
order by total_orders asc limit 5;
