-- Calculate the Year over Year growth rate of Total Sales.
WITH yearly_sales AS (
    SELECT
        YEAR(o.order_delivered_customer_date) AS year,
        SUM(p.payment_value) AS total_sales
    FROM orders o
    JOIN payment p ON o.order_id = p.order_id
    WHERE o.order_delivered_customer_date > '1000-01-01'
    GROUP BY YEAR(o.order_delivered_customer_date)
),
sales_with_growth AS (
    SELECT
        year,
        total_sales,
        LAG(total_sales) OVER (ORDER BY year) AS previous_year_sales,
        ROUND(
            (total_sales - LAG(total_sales) OVER (ORDER BY year)) 
            / LAG(total_sales) OVER (ORDER BY year) * 100, 2
        ) AS yoy_growth_rate
    FROM yearly_sales
)
SELECT *
FROM sales_with_growth
ORDER BY year;
