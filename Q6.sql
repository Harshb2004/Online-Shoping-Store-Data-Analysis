-- Calculate the number of orders per month in 2018.

SELECT 
    MONTHNAME(order_purchase_timestamp) AS Month_name,
    COUNT(order_id) AS no_of_orders
FROM
    orders
WHERE
    YEAR(order_purchase_timestamp) = 2018
GROUP BY month(order_purchase_timestamp),Monthname(order_purchase_timestamp)
order by month(order_purchase_timestamp);