SELECT * FROM retail.retail_sales;

SELECT COUNT(*) from retail_sales; 

-- Data Cleaning
select * from retail_sales
where
	transactions_id is NUll
    or
    sale_date is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or 
    category is null
    or
    quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
-- Data Exploration

-- How many total sales from retail?
select count(*) as total_sales from retail_sales;

-- How many unique customers in retail purchase?
select count(distinct customer_id) as total_customers from retail_sales;

-- How many category we have in retail purchase?
select distinct category from retail_sales;

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of 5 Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- A-1:
select * from retail_sales where sale_date="2022-11-05";

-- A-2
select 
*
from retail_sales
where
	category="Clothing"
    and
    convert(sale_date , date ) like '2022-11-05'
    and
    quantity>=4;


-- A-3
select 
	category,
	sum(total_sale) as net_sale,
    count(*) as total_order from retail_sales
group by category;

-- A-4
select
	round(avg(age),2) as avg_age
from retail_sales
where category = "Beauty";

-- A-5
select * from retail_sales
where total_sale = 1000;

-- A-6
select 
	category,
    gender,
    count(transactions_id) as total_transactions
from retail_sales
group by
	category,
    gender
order by category;

-- A-7
with a as(select 
	year(sale_date) as year,
    month(sale_date) as month,
    round(avg(total_sale),2) as avg_sale,
    rank() over(partition by year(sale_date) order by round(avg(total_sale),2)desc) as R
from retail_sales
group by year,month)

select year,month, avg_sale from a
where r=1;

-- A-8
select
	customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- A-9
select 
	category,
    count(distinct customer_id) as unique_customers
from retail_sales
group by category;

-- A-10
with hourly_time as(
select *,
	case
		when hour(sale_time)<12 then "Morning"
        when hour(sale_time)between 12 and 17 then "Afternoon"
        else "Evening"
	end as shift
from retail_sales)

select 
	shift,
    count(transactions_id) as total_orders
from hourly_time
group by shift;
	
-- End of Project


