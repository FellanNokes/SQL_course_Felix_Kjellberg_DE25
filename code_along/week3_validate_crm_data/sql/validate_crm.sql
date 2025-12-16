/* ========
TASK 2
=========== */

-- when like operator works regex is not needed
-- find invalid emails
-- use LIKE operator with wilcards for the old data
SELECT * FROM staging.crm_old
WHERE email NOT LIKE '%@%.%';


-- use REGEXP function for the new data 
-- because the above query cannot deal with the new data
SELECT * FROM staging.crm_new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+');

-- combine all three conditions
SELECT * FROM staging.crm_new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')
OR NOT region IN('EU', 'US') 
OR NOT status IN('active', 'inactive');

/* TASK 3 */
CREATE SCHEMA IF NOT EXISTS constrained;

CREATE TABLE IF NOT EXISTS constrained.crm_old(
    customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK (email LIKE '%@%.%'),
    region VARCHAR CHECK (region IN('EU', 'US')),
    status VARCHAR CHECK (status IN('active', 'inactive'))
);

CREATE TABLE IF NOT EXISTS constrained.crm_new(
    customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK (regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')),
    region VARCHAR CHECK (region IN('EU', 'US')),
    status VARCHAR CHECK (status IN('active', 'inactive'))
);


INSERT INTO constrained.crm_new
SELECT *
FROM staging.crm_new
WHERE regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')
AND region IN('EU', 'US') 
AND status IN('active', 'inactive');

INSERT INTO constrained.crm_old(
SELECT *
FROM staging.crm_old
WHERE regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')
AND region IN('EU', 'US') 
AND status IN('active', 'inactive'));

/* TASK 4 */

SELECT customer_id
FROM staging.crm_new
EXCEPT
SELECT customer_id
FROM staging.crm_old

SELECT customer_id
FROM staging.crm_new
INTERSECT
SELECT customer_id
FROM staging.crm_old

/* TASK 5 */
-- TODO: add comment column where the issue is stated

-- subquery 1: customers only in the old system
(SELECT *
FROM staging.crm_old
EXCEPT
SELECT *
FROM staging.crm_new)
UNION
-- subquery 2: customers only in the new system
(SELECT *
FROM staging.crm_new
EXCEPT
SELECT *
FROM staging.crm_old)
UNION
--subquery 3: customer violating in old crm system
(SELECT * FROM staging.crm_old
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')
OR NOT region IN('EU', 'US') 
OR NOT status IN('active', 'inactive')
)
UNION 
-- subquery 4: customer violating constraint in new crm system
(SELECT * FROM staging.crm_new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')
OR NOT region IN('EU', 'US') 
OR NOT status IN('active', 'inactive')
);