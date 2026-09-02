/*
-------------------------------------------
-----------------------------------
Customer Report
-----------------------------------
Purpose: This report consolidates key customer metrics and behaviours

Highlights:
1.Gather Essential feilds such as names,age,and transaction details.
2.Segment customers into categories (vips,regular,new) and age groups.
3.Aggregates customer-level metrics:
-total orders
-total sales
-total quantity purchased
-total products
-lifespan(in months)
4.Calculates valuable KPIs:
-recency (months since last order)
-average order value
-average monthly spend
---------------------------------------------
*/

/*
BASE QUERY
*/
create view  gold.report_customers as 
(
with base_query as
(
	select
		f.order_number,
		f.product_key,
		f.order_date,
		f.sales_amount,
		f.quantity,
		c.customer_key,
		c.customer_number,
		concat(c.first_name,' ',c.last_name) as customer_name,
		extract(year from age(now(),c.birthdate)) as age
	from
	gold.fact_sales as f
	left join gold.dim_customers as c
	on c.customer_key=f.customer_key
	where f.order_date is not null
)
,customer_aggregation as 
(
	select 
		customer_key,
		customer_number,
		customer_name,
		age,
		count(distinct order_number) as total_orders,
		sum(sales_amount) as total_sales,
		sum(quantity) as total_quantity,
		count(distinct product_key) as total_products,
		max(order_date) as last_order_date,
		extract(month from age(max(order_date),min(order_date))) as life_span
	from base_query
	group by customer_key,customer_number,customer_name,age
)
select
	customer_key,
	customer_number,
	customer_name,
	age,
	case
		when age<20 then 'Under 20'
		when age between 20 and 29 then '20-29'
		when age between 30 and 39 then '30-39'
		when age between 40 and 49 then '40-49'
	else '50 above'
	end as age_group,
	case
		when life_span>=12 and total_sales>5000 then 'VIP'
		when life_span>=12 and total_sales<=5000 then 'Regular'
		else 'New Customer'
    end as customer_segment,
	last_order_date,
	extract(year from age(now(),last_order_date))*12+extract(month from age(now(),last_order_date)) as recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	life_span,
	total_sales/total_orders as avg_order_value,
	case 
	when life_span=0 then total_sales
	else round(total_sales/life_span)
	end as avg_monthly_span
from customer_aggregation
)
