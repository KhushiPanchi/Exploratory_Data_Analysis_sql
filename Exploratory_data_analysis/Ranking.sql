-------------------
--Ranking
------------------

--Which 5 products generate the highest revenue
select
p.product_name,
sum(s.sales_amount) as revenue
from gold.fact_sales as s
left join 
gold.dim_products as p
on p.product_key=s.product_key
group by p.product_name
order by revenue desc
limit 5;

--5 worst performing products in term of sales
select
p.product_name,
sum(s.sales_amount) as revenue
from gold.fact_sales as s
left join 
gold.dim_products as p
on p.product_key=s.product_key
group by p.product_name
order by revenue 
limit 5;