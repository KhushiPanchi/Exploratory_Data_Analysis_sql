--Data Segmentation- case when statements are used

/*Segment products into cost ranges and count how
many products fall into each segment*/
with product_segment as 
(
	select
	product_key,
	product_name,
	cost,
	case
		when cost<100 then 'Below 100'
		when cost between 100 and 500 then '100-500'
		when cost between 500 and 1000 then '500-1000'
		else 'above 1000'
	end as cost_range
	from gold.dim_products
)
select 
cost_range,
count(product_key) as total_products
from product_segment
group by cost_range;

/*Group customers into 3 segments based on their
spending behaviour*/
with customer_spending as 
(
select
c.customer_key,
sum(sales_amount) as total_spending,
min(order_date) as first_order,
max(order_date) as last_date,
extract(month from age(max(order_date),min(order_date))) as life_span
from gold.fact_sales as f
left join gold.dim_customers as c
on f.customer_key=c.customer_key
group by c.customer_key
)
select
customer_key,
total_spending,
life_span,
case
	when life_span>=12 and total_spending>5000 then 'VIP'
	when life_span>=12 and total_spending<=5000 then 'Regular'
	else 'New Customer'
end as customer_segment
from customer_spending;
