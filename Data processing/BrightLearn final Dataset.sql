--This is what our full table will look like when we add all the things we would like to see
SELECT transaction_id, 
        transaction_date,
        transaction_time,
        transaction_qty,
        store_id,
        store_location,
        product_id,
        unit_price,
        product_category,
        product_type,
        product_detail,
        transaction_qty * unit_price AS revenue,
--from here we are adding the tables that will enhance our data
        DATE_FORMAT(transaction_date, 'EEEE') AS day_name,
        DATE_FORMAT(transaction_date, 'MMMM') AS month_name,
        DATE_FORMAT(transaction_date, 'MM') AS date_of_month,
        DATE_FORMAT(transaction_time, 'HH:MM:SS') AS
        time_frame,
--this is to see the days was weekdays or weekends
CASE 
        WHEN DATE_FORMAT(transaction_date, 'EEEE') IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
        END AS day_classification,
--this is to see the time of the day
CASE 
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') BETWEEN '00:00:00' AND '11:59:59 ' THEN '01.Morning'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') BETWEEN '12:00:00' AND '16:59:59' THEN '02.Afternoon'
        WHEN DATE_FORMAT(transaction_time, 'HH:MM:SS') >= '17:00:00' THEN '03.Evening'
        END AS time_classification,
--this is to show our spending bucket
CASE
        WHEN transaction_qty * unit_price <= 50 THEN '01.Low revenue'
        WHEN transaction_qty * unit_price BETWEEN 51 AND 200 THEN '02.Medium spender'
        WHEN transaction_qty * unit_price BETWEEN 201 AND 300 THEN '03.High spender'
        ELSE 'Big Spender'
        END AS spend_bucket

FROM studies101.brightlearn.bright_coffee_shop_analysis;
