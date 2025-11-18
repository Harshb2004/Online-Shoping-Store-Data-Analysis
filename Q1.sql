-- List All the unique Cities where Customters are located.

Select 
	Row_number() over(order by customer_city) as Sr_No, 
    customer_city as CITY 
from (
    select distinct (customer_city) from customer) 
    as Unique_Cities;