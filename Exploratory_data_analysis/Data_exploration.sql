--date exploration

--from table dim_customers
select * from gold.dim_customers;
select max(birthdate),min(birthdate) from gold.dim_customers;
select extract(year from age(current_date,max(birthdate))) as age_of_the_latest_customer from gold.dim_customers;
select extract(year from age(current_date,min(birthdate))) as age_of_the_oldest_customer from gold.dim_customers;

--from table dim_products
select * from gold.dim_products;
select min(start_date) as first_product_date from gold.dim_products;

--from table fact_sales
select * from gold.fact_sales;
select age(max(order_date),min(order_date)) from gold.fact_sales;