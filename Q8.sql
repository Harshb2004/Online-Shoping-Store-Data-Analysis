-- Calculate the percentage of total revenue contributed by each category. (sum(order_items.price)/(select round(sum(order_items.price)),2)*100 as percentage from order_items) as total_sales

SELECT 
    products.product_category,
    ROUND(SUM(order_items.price), 2) AS revenue,
    ROUND(100 * ROUND(SUM(order_items.price), 2) / (SELECT 
                    ROUND(SUM(order_items.price), 2)
                FROM
                    order_items),
            2) AS percentage
FROM
    products
        JOIN
    order_items ON products.product_id = order_items.product_id
GROUP BY product_category
ORDER BY percentage DESC;