CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.order_items AS (
    FROM read_csv_auto('data/order_items.csv')
);

CREATE TABLE IF NOT EXISTS staging.products AS (
    FROM read_csv_auto('data/products.csv')
);