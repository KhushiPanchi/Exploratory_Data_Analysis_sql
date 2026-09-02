--Changes over time analysis year basis
select 
	distinct extract(year from order_date) as years,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by extract(year from order_date)
order by extract(year from order_date)
;

--change over time analysis month basis
select 
	to_char(order_date,'Month') as months,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by extract(month from order_date),to_char(order_date,'Month')
order by extract(month from order_date)
;
