-- COUNT THE NUMBER OF ORDERS PLACED IN 2017.

SELECT 
    COUNT(order_id)
FROM
    orders
WHERE
    YEAR(order_purchase_timestamp) = 2017;