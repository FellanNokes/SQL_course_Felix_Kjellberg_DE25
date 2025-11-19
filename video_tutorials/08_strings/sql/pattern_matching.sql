-- LIKE operator in WHERE clause
-- LIKE operator with wildcards to search for a pattern
SELECT
    example,
    lower(trim(example)) as cleaned_example
FROM
    staging.sql_glossary;

-- search for select
SELECT
    example,
    lower(trim(example)) as cleaned_example
FROM
    staging.sql_glossary
WHERE
    cleaned_example LIKE '%select%'; -- wildcard % matches 0 or more chars

-- wildcard _ represents one character
SELECT
    example,
    trim(example) as cleaned_example
FROM
    staging.sql_glossary
WHERE
    cleaned_example LIKE 'S_LECT%'; 

-- regular expression
SELECT
    lower(trim(description)) as cleaned_description
FROM
    staging.sql_glossary
WHERE
    regexp_matches(cleaned_description, '^c');

-- starting with C or S
SELECT
    trim(description) as cleaned_description
FROM
    staging.sql_glossary
WHERE
    regexp_matches(cleaned_description, '^[CS]');

-- \b makes it match exactly select word (e.g. doesnt match selects)
SELECT
    lower(description) as cleaned_description
FROM
    staging.sql_glossary
WHERE
    regexp_matches(cleaned_description, 'select\b');

-- [a-f] matches range of characters
-- ^[a-f] matches starting with characters a - f range of characters
SELECT
    lower(trim(description)) as cleaned_description
FROM
    staging.sql_glossary
WHERE
    regexp_matches(cleaned_description, '^[a-f]');

-- [^a-f] matches any character NOT in range a - f
-- ^[^a-f] starting with characters NOT in range a - f
SELECT
    lower(trim(description)) as cleaned_description
FROM
    staging.sql_glossary
WHERE
    regexp_matches(cleaned_description, '^[^a-f]');

-- g flag need to make it global otherwise only replaces first occurens
SELECT
    description,
    regexp_replace(trim(description), ' +', ' ','g') as cleaned_description
FROM staging.sql_glossary