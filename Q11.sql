-- Calculate the moving average of order value for each customer over their order history.

select
	orders.order_id as Order_id,
    orders.customer_id as Customer_id,
    orders.order_delivered_customer_date as Order_date,
    payment.payment_value as Order_value,
    ROUND(avg(payment.payment_value) over(
			partition by customer_id 
            order by order_delivered_customer_date, order_id 
			ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) as Moving_Average
    from orders
		Left Join payment
			on orders.order_id = payment.order_id
    where orders.order_delivered_customer_date!='0000-00-00 00:00:00'
	order by
		order_id,
		customer_id;
    