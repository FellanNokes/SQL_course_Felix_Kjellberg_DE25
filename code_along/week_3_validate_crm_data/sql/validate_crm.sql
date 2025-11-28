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