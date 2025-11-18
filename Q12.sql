-- Calculate the cumulative sales per month for each year.

	select 
		Year(orders.order_delivered_customer_date) as Order_Year,
		month(orders.order_delivered_customer_date) as Order_Month_Num,
		monthname(orders.order_delivered_customer_date) as Order_Month,
		sum(payment.payment_value) as Monthly_Sales,
        sum(sum(payment.payment_value)) over(
		Order by 
			Year(orders.order_delivered_customer_date) DESC,
			month(orders.order_delivered_customer_date) ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as Cumulative_Sales
		from
			orders 
			left join payment
			on orders.order_id = payment.order_id
			where Year(orders.order_delivered_customer_date) !='0' and monthname(orders.order_delivered_customer_date) != '0'
		group by
			Year(orders.order_delivered_customer_date), 
			monthname(orders.order_delivered_customer_date),
			month(orders.order_delivered_customer_date)
		order by 
			Order_Year DESC,
			Order_Month_Num ASC;
           







        
        
        
        