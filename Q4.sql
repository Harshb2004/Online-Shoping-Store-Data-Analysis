-- Calculate the percentage of orders that were paid on installments.

SELECT 
    ROUND(100 * (AVG(CASE
                WHEN payment_installments > 1 THEN 1
                ELSE 0
            END)),
            2) AS intallment_percentage
FROM
    payment;
