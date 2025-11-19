CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE
    IF NOT EXISTS staging.course_structure AS(
        SELECT
            *
        FROM
            read_csv_auto('data/week.csv')
    );