-- identify the top 3 customers who spent the most money for each year.

with left_data as (
	SELECT
		orders.order_id as order_id,
		orders.customer_id as Customer,
		Year(orders.order_delivered_customer_date) AS Order_Year
	FROM
		orders
        left JOIN customer ON orders.customer_id = customer.customer_id
    where 
		orders.order_status = "delivered" and Year(orders.order_delivered_customer_date)!='0' 
        ),
customer_spending as(
	select  
		left_data.Customer, 
		left_data.Order_Year, 
		sum(coalesce(order_items.price,0)) as Total_Spent
    from 
		left_data  
        Left Join order_items on left_data.order_id=order_items.order_id
    group by 
    left_data.Customer, 
    left_data.Order_Year
    ),
Customer_Ranking as (
	select 
		customer_spending.*, ROW_NUMBER() over(PARTITION BY customer_spending.Order_Year ORDER BY customer_spending.Total_Spent DESC) as rank_in_year
        from customer_spending )
SELECT 
   Customer_Ranking.Customer, 
   Customer_Ranking.order_year, 
   Customer_Ranking.Total_Spent
FROM 
    Customer_Ranking
WHERE 
    rank_in_year <= 3
ORDER BY 
    order_year DESC, 
    total_spent DESC;        