-- IN Operator for list filtering
SELECT DISTINCT
    COUNT(*)
FROM
    data_jobs
WHERE
    company_size IN ('M', 'S');

-- FILTER CLAUSE
SELECT
    COUNT(*) AS total_jobs,
    COUNT(*) FILTER (remote_ratio = 100) AS remote_jobs,
    ROUND(remote_jobs/total_jobs*100) AS percent_remote_jobs
FROM
    data_jobs;

-- OFFSET filtering 

SELECT * FROM data_jobs OFFSET 6;