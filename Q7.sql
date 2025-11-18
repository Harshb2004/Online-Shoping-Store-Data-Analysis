-- Find the average number of product per order grouped by customer city.

select order_count.customer_city,round(avg(product_count),2) as Avg_Product_Count from
(SELECT 
    customer.customer_city,
    orders.order_id,
    COUNT(order_items.product_id) as product_count
FROM
    customer
        JOIN
    orders ON customer.customer_id = orders.customer_id
        JOIN
    order_items ON orders.order_id = order_items.order_id
GROUP BY customer.customer_city,orders.order_id) as order_count
group by customer_city; 

