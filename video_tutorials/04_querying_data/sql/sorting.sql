-- acending order by default
SELECT
    *
FROM
    data_jobs
ORDER BY
    salary_in_usd;

-- descending order
SELECT
    *
FROM
    data_jobs
ORDER BY
    salary_in_usd DESC;

-- sort by salary_in_usd DESC and employee_residence 
SELECT
    *
FROM
    data_jobs
ORDER BY
    salary_in_usd DESC,
    employee_residence ASC;