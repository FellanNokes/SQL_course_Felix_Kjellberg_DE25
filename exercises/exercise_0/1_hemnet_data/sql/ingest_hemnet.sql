CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.hemnet AS(
    SELECT * 
    FROM read_csv_auto('data/hemnet_data_clean.csv')
);