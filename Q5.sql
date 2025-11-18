-- Count the number of Customers from each state.


set @Sr_No = 0;        /* Here we create a user variable, intialize=0*/

select 
@Sr_No:= @Sr_No+1 as Sr_No,
SC.customer_state as State, SC.Total_Customers
from (
select customer_state, count(customer_id) as Total_Customers   /* create a new table of required data for serial number*/
from customer
group by customer_state
order by customer_state) as SC;