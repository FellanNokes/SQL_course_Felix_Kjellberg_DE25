/*TASK 2 */
SELECT DISTINCT
product_id
FROM staging.products
ORDER BY product_id DESC;

SELECT
COUNT(DISTINCT product_id) AS number_products
FROM staging.order_items;


SELECT oi.product_id
FROM staging.products p
JOIN staging.orders_items oi
ON oi.product_id = p.product_id;

SELECT oi.product_id
FROM staging.products p
INNER JOIN staging.orders_items oi
ON oi.product_id = p.product_id;

SELECT oi.product_id
FROM staging.products p
LEFT JOIN staging.orders_items oi
ON oi.product_id = p.product_id;