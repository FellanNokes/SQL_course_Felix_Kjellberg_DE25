-- b) Make a wildcard selection to checkout the data (use the asterisk symbol)
SELECT * FROM staging.hemnet
--  c) Find out how many rows there are in the table

--  d) Describe the table that you have ingested to see the columns and data types.

--  e) Find out the 5 most expensive homes sold.
SELECT * FROM staging.hemnet
ORDER BY final_price DESC
LIMIT 5;


--  f) Find out the 5 cheapest homes sold.
SELECT * FROM staging.hemnet
ORDER BY final_price
LIMIT 5;

--  g) Find out statistics on minimum, mean, median and maximum prices of homes sold.
SELECT 
    ROUND(AVG(final_price)) AS average_price,
    ROUND(MEDIAN(final_price)) AS median_price,
    ROUND(MIN(final_price)) AS min_price,
    ROUND(MAX(final_price)) AS max_price
FROM staging.hemnet;

--  h) Find out statistics on minimum, mean, median and maximum prices of price per area.
SELECT 
    commune,
    ROUND(AVG(price_per_area)) AS average_price,
    ROUND(MEDIAN(price_per_area)) AS median_price,
    ROUND(MIN(price_per_area)) AS min_price,
    ROUND(MAX(price_per_area)) AS max_price
FROM staging.hemnet
GROUP BY commune
ORDER BY average_price;

--  i) How many unique communes are represented in the dataset.
SELECT DISTINCT COUNT(commune)
FROM staging.hemnet;

--  j) How many percentage of homes cost more than 10 million?
SELECT
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE final_price > 10000000) 
        / COUNT(*),
    2) AS percent_above_ten_million
FROM staging.hemnet;

--  k) Feel free to explore anything else you find interesting in this dataset.