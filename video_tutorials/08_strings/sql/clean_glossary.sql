CREATE SCHEMA IF NOT EXISTS refined;

CREATE TABLE
    IF NOT EXISTS refined.sql_glossary AS (
        SELECT
            upper(trim(sql_word)) AS sql_word,
            regexp_replace (trim(description), ' +', ' ', 'g') as description,
            regexp_replace (trim(example), ' +', ' ', 'g') as example
        FROM
            staging.sql_glossary
    );