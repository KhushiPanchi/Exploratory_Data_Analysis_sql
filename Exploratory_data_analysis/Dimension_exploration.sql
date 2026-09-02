--Dimension Exploration

--from table dim_customers
select distinct country from gold.dim_customers;
select distinct marital_status from gold.dim_customers;
select distinct gender from gold.dim_customers;
--from table dim_products
select * from gold.dim_products;
select distinct product_name from gold.dim_products;
select distinct category,subcategory,product_name from gold.dim_products order by category;