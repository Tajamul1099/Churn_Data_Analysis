create database CUSTOMER_CHURN_DB;
use CUSTOMER_CHURN_DB;
SHOW TABLES;
select *
from customer_churn;

select COUNT(*)
FROM customer_churn;

select count(*) 
from customer_churn
where churn = 'yes';

#Churn_Rate
select 
round(
sum(case when churn ='yes' then 1 else 0 end)*100/count(*),2)as Churn_Rate
from customer_churn;

#Average Monthly Charges
select avg(Monthly_charges)
from customer_churn;

#Average Tenure.
select avg(Tenure_Months)
from customer_churn;

#Churn by contract type
select contract_type,count(*) as customers
from customer_churn
group by contract_type;

#Churn Internet Service
select Internet_service,count(*)
from customer_churn
group by Internet_service;

#Churn by State
select state,count(*)
from customer_churn
where churn = 'yes'
group by state
order by 2 desc;

#Payment method wise customers
select payment_method,count(*)
from customer_churn
group by payment_method;

#Subscription type wise customers.
select subscription_type,count(*)
from customer_churn
group by subscription_type;

#Highest revenue states
select state,
round(sum(total_charges),2) as state_charges
from customer_churn
group by state
order by 2 desc;

#Average charges by contract
select contract_type,
avg(monthly_charges)
from customer_churn
group by contract_type;

#senior citizen churn
select senior_citizen,count(*)
from customer_churn
where churn='yes'
group by senior_citizen;

#Top 10 high value customers
select customer_name,customer_value
from customer_churn
order by customer_value desc
limit 10;

#customer without tech support
select *
from customer_churn
where tech_support = 'no';