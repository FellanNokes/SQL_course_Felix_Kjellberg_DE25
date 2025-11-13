-- join data
select 
  o.order_id, 
  o.order_date,
  o.customer_id,
  o.staff_id,
  o.order_status,
  o.required_date,
  c.customer_id,
  c.first_name as customer_first_name,
  c.last_name as customer_last_name,
  c.phone as customer_phone,
  c.email as customer_email,
  c.street as customer_street,
  c.city as customer_city,
  c.state as customer_state,
  c.zip_code as customer_zip_code,
  oi.product_id as product_id,
  oi.quantity,
  oi.list_price,
  oi.discount,
  p.product_name,
  p.brand_id,
  p.category_id,
  p.model_year,
  ca.category_name,
  b.brand_name,
  s.first_name as staff_first_name,
  s.last_name as staff_last_name,
  s.manager_id 
from staging.orders o
LEFT JOIN staging.customers c ON o.customer_id = c.customer_id
LEFT JOIN staging.orders_items oi ON o.order_id = oi.order_id
LEFT JOIN staging.products p ON oi.product_id = p.product_id
LEFT JOIN staging.categories ca ON p.category_id = ca.category_id
LEFT JOIN staging.brands b ON p.brand_id = b.brand_id
LEFT JOIN staging.staffs s ON o.staff_id = s.staff_id


-- join data
select 
  main.orders.order_id, 
  main.orders.order_date,
  main.orders.customer_id,
  main.orders.staff_id,
  main.orders.order_status,
  main.orders.required_date,
  main.customers.customer_id,
  main.customers.first_name as customer_first_name,
  main.customers.last_name as customer_last_name,
  main.customers.phone as customer_phone,
  main.customers.email as customer_email,
  main.customers.street as customer_street,
  main.customers.city as customer_city,
  main.customers.state as customer_state,
  main.customers.zip_code as customer_zip_code,
  main.order_items.product_id as product_id,
  main.order_items.quantity,
  main.order_items.list_price,
  main.order_items.discount,
  main.products.product_name,
  main.products.brand_id,
  main.products.category_id,
  main.products.model_year,
  main.categories.category_name,
  main.brands.brand_name,
  main.staffs.first_name as staff_first_name,
  main.staffs.last_name as staff_last_name,
  main.staffs.manager_id 
from staging.orders orders
LEFT JOIN staging.customers customers ON orders.customer_id = customers.customer_id
LEFT JOIN staging.orders_items order_items ON orders.order_id = order_items.order_id
LEFT JOIN staging.products products ON order_items.product_id = products.product_id
LEFT JOIN staging.categories categories ON products.category_id = categories.category_id
LEFT JOIN staging.brands brands ON products.brand_id = brands.brand_id
LEFT JOIN staging.staffs staffs ON orders.staff_id = staffs.staff_id