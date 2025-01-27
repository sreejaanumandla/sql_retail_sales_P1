-- SQL Retail Sales Analysis - P1
create database Sql_P1;

create table retail_sales (
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
--Data Cleaning

SELECT * FROM retail_sales

SELECT * FROM retail_sales 
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

--deleting null values
delete  FROM retail_sales 
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

--How many sales we have?
select count(*) as total_sales from retail_sales

--How many unique customers we have?
select count(distinct customer_id) as total_sales from retail_sales

select count(distinct category) as total_sales from retail_sales

--Data Analysis & Business Key Problems & Solutions

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from retail_sales where sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retail_sales where category = 'Clothing' and  to_char(sale_date,'YYYY-MM') = '2022-11'
and quantiy >=4 

--3.Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as total_sales, count(*) as total_orders
from retail_sales
group by category;

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as average_age from retail_sales where category = 'Beauty';

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales where total_sale> 1000;

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select category, gender, count(transactions_id) as tot_no_trans from retail_sales 
group by category, gender
order by category 

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select * from(
select 
extract(year from sale_date)as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sales,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rnk
from retail_sales 
group by 1,2) cte

where rnk = 1;

--8.Write a SQL query to find the top 5 customers based on the highest total sales **:
select 
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

--9.Write a SQL query to find the number of unique customers who purchased items from each category.:

select category, count(distinct customer_id) as unique_cust 
from retail_sales 
group by category 

--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with cte as (
select *,
 case when extract(hour from sale_time)< 12 then 'Morning'
      when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	  else 'Evening'
	  end as shift
	  from retail_sales
)
select shift, count(transactions_id) as tot_orders from cte
group by shift

--End of project

