create database datawarehouseanalytics;

create schema gold;

CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number varchar(50),
	first_name varchar(50),
	last_name varchar(50),
	country varchar(50),
	marital_status varchar(50),
	gender varchar(50),
	birthdate date,
	create_date date
);

CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number varchar(50) ,
	product_name varchar(50) ,
	category_id varchar(50) ,
	category varchar(50) ,
	subcategory varchar(50) ,
	maintenance varchar(50) ,
	cost int,
	product_line varchar(50),
	start_date date 
);

CREATE TABLE gold.fact_sales(
	order_number varchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity int,
	price int 
);

select count(*) from gold.dim_customers;
select * from gold.dim_customers
limit 10;

select count(*) from gold.dim_products;
select * from gold.dim_products
limit 10;

select count(*) from gold.fact_sales;
select * from gold.fact_sales
limit 10;

--To know all the tables
select * from information_schema.tables;
