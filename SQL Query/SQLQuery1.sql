CREATE DATABASE RetailDB
GO


USE RetailDB
GO

EXEC sp_rename 'cleaned_transactions', 'raw_transactions';

SELECT COUNT(*) AS rows_count FROM raw_transactions;
SELECT TOP 10 * FROM raw_transactions;



------ VIEWS

-- monthly sales
CREATE VIEW vw_monthly_sales AS
SELECT 
    FORMAT(transaction_date,'yyyy-MM') AS month,
    SUM(total_spent) AS total_revenue,
    COUNT(transaction_id) AS transactions_count
FROM raw_transactions
GROUP BY FORMAT(transaction_date,'yyyy-MM');

-- check
select * from vw_monthly_sales


-- Top customers
create view vw_top_customers as 
select 
    customer_id,
    sum(total_spent) as total_spent,
    count(transaction_id) as orders_count
from raw_transactions
group by customer_id

-- check
select * from vw_top_customers


-- Product performance
create view vw_product_performance as
select 
    category,
    item,
    SUM(total_spent) as total_revenue,
    sum(quantity) as total_units_sold
from raw_transactions
group by category, item;

-- check
select * from vw_product_performance

-- Payment Method Analysis
CREATE VIEW vw_payment_methods as
select 
    payment_method,
    COUNT(transaction_id) AS transactions_count,
    SUM(total_spent) AS total_revenue
FROM raw_transactions
GROUP BY payment_method;

-- check
SELECT * FROM vw_payment_methods



-- Location Performance

Create view vw_location_performance as
SELECT 
    location,
    COUNT(transaction_id) AS transactions_count,
    SUM(total_spent) AS total_revenue
from raw_transactions
group by location;

-- check
select * from vw_location_performance


SELECT name FROM sys.views;
