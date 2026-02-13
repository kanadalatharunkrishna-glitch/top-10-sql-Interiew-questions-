2. calculate running total/MTD/YTD ??
Answer :-
with cte as (
select o.orderdate,
       sum(od.quantityordered * od.priceEach)  -------------o as a alias order 
from orders as o                                  -------------od as a alias orderdetails
join orderdetails as od
on o.ordernumber = od.ordernumber 
group by o
)
select orderdate , revenue ,
sum(revenue) over(parition by year(orderdate), order by month(orderdate)) as running_total 
from orders;

explnanation :- so there is a 2 tables 
we need to join both the table with common reference and make a
sum(od.quantityordered * od.priceEach)  and we need to join 
and by using this as a CTE , we make a sum with revenue and over 
with year and with month , we do parition with year , so that we get 2020, 2021 ,2023 
and order by monthly 