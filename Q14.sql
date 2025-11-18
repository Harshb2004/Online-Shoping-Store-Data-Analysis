-- Calculate the retention rate of customer, defined as the percentage of customer who made another purchase within 6 months of their first purchase.

WITH first_orders AS (
    SELECT
        customer_id,
        MIN(order_delivered_customer_date) AS first_order_date
    FROM orders
    WHERE order_delivered_customer_date > '1000-01-01'
    GROUP BY customer_id
),
next_orders AS (
    SELECT
        o.customer_id,
        f.first_order_date,
        MIN(o.order_delivered_customer_date) AS next_order_date
    FROM orders o
    JOIN first_orders f ON o.customer_id = f.customer_id
    WHERE o.order_delivered_customer_date > f.first_order_date
      AND o.order_delivered_customer_date <= DATE_ADD(f.first_order_date, INTERVAL 6 MONTH)
    GROUP BY o.customer_id
)
SELECT
    ROUND(
        (SELECT COUNT(*) FROM next_orders) * 100.0 /
        (SELECT COUNT(DISTINCT customer_id) FROM orders),
        2
    ) AS retention_rate_6_months;
