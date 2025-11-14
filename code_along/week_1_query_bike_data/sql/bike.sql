-- cell 2
SELECT
    o.order_id,
    o.customer_id,
    oi.item_id,
    oi.product_id,
    oi.quantity,
FROM staging.orders o
LEFT JOIN staging.order_items oi ON o.order_id = oi.order_id;

-- cell 3