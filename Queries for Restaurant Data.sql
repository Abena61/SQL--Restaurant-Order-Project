-- View the menu items on menu table.
Select * from menu_items
order by price desc;

-- Number of items on the menu. total number of items are 32 items 
select count(item_name)
from menu_items;

-- Least and most expensive items on the menu. 3 Seperate Queries
SELECT * FROM menu_items
WHERE price = (SELECT MAX(price) FROM menu_items);


Select * from menu_items
order by price desc;

select * from menu_items where price = (select min(price) from menu_items);

-- How many italian dishes are on the menu? Least expensive dishes are Fetticcone Alfredo and Spaghetti at $14.5 while expensive items is Shrimp Scampi at $19.95
select *
from menu_items
where category = 'italian'
order by price desc;

select * from menu_items 
where category = 'italian' and price = (select max(price) from menu_items where category = 'italian') ;

select * from menu_items 
where category = 'italian' and price = (select min(price) from menu_items where category = 'italian');

-- how many dishes are in each category? What is the avergae dish price within each category?
select category, count(item_name), avg(price)
from menu_items 
group by category 
order by avg(price) desc;

-- View order_details table. What is the date range in the table? Answer- 2023-01-01 to  2023-03-31
select * from  order_details
order by order_id desc;

select max(order_date), min(order_date)  from order_details;

select min(order_date) from order_details;

-- How many orders were made within this date range? 12234 orders where made. How many items were ordered within this date range? 5370
select count(distinct order_id), count(order_id)
from order_details;

-- Which orders had the most number of items?
select order_id, count(item_id) as num_items, item_id
from order_details
group by order_id
order by num_items desc;

-- How many order had more than 12 items?
select count(*) from

(select order_id, count(item_id) AS num_items
from order_details
group by order_id
having count(item_id) > 12
order by order_id
) as num_details;


-- combine the menu_items and order_details tabels into a single table 

SELECT  m.*, o.*
FROM menu_items m
JOIN order_details o ON o.item_id = m.menu_item_id;

-- what were the least and most ordered items? What categories were they in?
Select item_name, category, count(order_details_id) as num_purchases
from order_details od 
Left Join menu_items mi 
on od.item_id = mi.menu_item_id
Group by item_name, category
order by num_purchases;

-- What were the top 5 orders that spent the most money?

Select o.order_id, sum(m.price) as total_spend
from order_details o
left join menu_items m on o.item_id = m.menu_item_id
group by o.order_id 
order by total_spend desc
limit 5;

-- View the details of the highest spend on an order. what insights can you gather? 
Select o.* , m.*, sum(m.price) as total_spend
from order_details o
left join menu_items m on o.item_id = m.menu_item_id
where order_id = 440
;

Select category, count(item_id) as num_items 
from order_details o
left join menu_items m on o.item_id = m.menu_item_id
where order_id = 440
Group by category;

-- View the details of the highest 5 spend on orders. What insights can you gather ? 
Select o.*, m.*,  sum(m.price) as total_spend
from order_details o
left join menu_items m on o.item_id = m.menu_item_id
group by o.order_id 
order by total_spend desc
limit 5;

SELECT 
    order_id, category, COUNT(item_id) AS num_items
FROM
    order_details o
        LEFT JOIN
    menu_items m ON o.item_id = m.menu_item_id
WHERE
    order_id IN (440 , 2075, 1957, 330, 2675)
GROUP BY order_id , category;