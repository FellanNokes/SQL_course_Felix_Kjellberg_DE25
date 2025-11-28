CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS constrainted;

CREATE TABLE IF NOT EXISTS staging.crm_new AS (
    FROM read_csv_auto ('data/crm_new.csv')
);

CREATE TABLE IF NOT EXISTS staging.crm_old AS (
    FROM read_csv_auto ('data/crm_old.csv')
);

CREATE TABLE IF NOT EXISTS constrainted.crm_new AS (
    FROM read_csv_auto ('data/crm_new.csv')
);

CREATE TABLE IF NOT EXISTS constrainted.crm_old AS (
    FROM read_csv_auto ('data/crm_old.csv')
);