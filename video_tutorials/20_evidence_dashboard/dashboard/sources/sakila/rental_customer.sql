SELECT
    p.amount,
    p.payment_date,
    r.rental_date,
    r.return_date,
    s.store_id,
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer,
FROM 
    staging.payment p
    LEFT JOIN staging.rental r ON p.rental_id = r.rental_id
    LEFT JOIN staging.customer c ON c.customer_id = p.customer_id
    LEFT JOIN staging.store s ON s.store_id = c.store_id;
