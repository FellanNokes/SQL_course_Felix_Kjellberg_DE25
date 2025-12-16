SELECT email FROM (
SELECT email
FROM staging.crm_new
UNION
SELECT email
FROM staging.crm_old
)
WHERE email NOT LIKE '%@%' OR email NOT LIKE '%.%';

SELECT region FROM (
    SELECT region
    FROM staging.crm_new
    UNION
    SELECT region
    FROM staging.crm_old
)
WHERE region NOT LIKE 'US' AND region NOT LIKE 'EU';

SELECT status FROM (
    SELECT status
    FROM staging.crm_new
    UNION
    SELECT status
    FROM staging.crm_old
)
WHERE status NOT LIKE 'active' OR region NOT LIKE 'inactive';