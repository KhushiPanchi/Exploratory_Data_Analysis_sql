--Measures Exploration

--total sales
select sum(sales_amount) as total_sales from gold.fact_sales;
--total items
select sum(quantity) as total_items from gold.fact_sales;
--average selling price
select avg(price) as average_s_p from gold.fact_sales;
--total number of orders
select count(distinct order_number) as total_orders from gold.fact_sales;
--total number of products
select count(distinct product_name) as total_products from gold.dim_products;
--total number of customers
select count(*) as total_customers from gold.dim_customers;
--total customers that has placed order
select count(distinct customer_key) from gold.fact_sales;

--Generate a report that shows all the key metrics of the business
select 'Total Sales' as measure_name,sum(sales_amount) as measure_value from gold.fact_sales
union all
select 'Total Quantity' as measure_name ,sum(quantity) as measure_value from gold.fact_sales
union all
select 'Avg Selling Price' as measure_name,round(avg(price),2) as measure_value from gold.fact_sales
union all
select 'Total orders' as measure_name,count(distinct order_number) as measure_value from gold.fact_sales
union all
select 'Total Products' as measure_name,count(distinct product_name) as measure_value from gold.dim_products
union all
select 'Total customers' as measure_name, count(*) as measure_value from gold.dim_customers;

