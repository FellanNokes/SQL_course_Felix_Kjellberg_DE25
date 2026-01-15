CREATE SCHEMA IF NOT EXISTS test_schema;

CREATE TABLE IF NOT EXISTS
    test_schema.test_table (
        column_1 SERIAL ,
        column_2 INTEGER,
        column_3 INTEGER NOT NULL 
    );

INSERT INTO test_schema.test_table (column_2, column_3)
VALUES (2,3);