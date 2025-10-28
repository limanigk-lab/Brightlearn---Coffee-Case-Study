--Revenue per transaction 
SELECT transaction_id,
       transaction_qty*unit_price AS revenue
FROM coffee_store_sales;

-- Remember that with the ID's we use the COUNT NOT SUM 
-- This is the total number of sales/transactions made
SELECT COUNT(transaction_id) AS number_of_sales
FROM coffee_store_sales;

--COUNT the number of different shops we have in this data 
SELECT COUNT(DISTINCT store_id) AS number_of_shops
FROM coffee_store_sales;

-- To show us the name of the different store location which is actually 3 different shops
SELECT DISTINCT store_location, store_id
FROM coffee_store_sales;

--How to calculate the revenue by store location 
SELECT store_location,
       SUM(transaction_qty*unit_price) AS revenue
FROM coffee_store_sales
GROUP BY store_location;

-- What time does the shop opens
SELECT MIN(transaction_time) openig_time
FROM coffee_store_sales;

-- What time does the shop close
SELECT MAX(transaction_time) closing_time
FROM coffee_store_sales;


SELECT product_category,
       SUM(transaction_qty*unit_price) AS revenue,
       store_location,
       transaction_date,
       transaction_time,
       DAYNAME(transaction_date) AS day_name, 
       DAYOFMONTH(transaction_date) AS day_of_the_month, 
       MONTHNAME(transaction_date) AS month_name,store_location,
       CASE 
            WHEN day_name NOT IN ('Sat','Sun') THEN 'weekday'
            ELSE 'weekend'
    END AS daytype,
    
       CASE
            WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Aftenoon'
            WHEN transaction_time BETWEEN '16:00:00' AND '20:59:59' THEN 'Evening'
            
        END AS intraday_intervals
FROM coffee_store_sales
GROUP BY product_category,
         store_location,
         transaction_date,
         intraday_intervals,
         transaction_time
ORDER BY revenue DESC; 
