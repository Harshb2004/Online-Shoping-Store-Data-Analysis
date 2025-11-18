-- Find the Total Sales per Category.

SELECT 
    products.product_category, ROUND(SUM(price), 2) AS Sales
FROM
    products
        JOIN
    order_items ON products.product_id = order_items.product_id
GROUP BY product_category
ORDER BY Sales DESC;