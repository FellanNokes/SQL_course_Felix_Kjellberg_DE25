-- do select first to see that we get what we want
-- change the experience level labels
SELECT
    CASE
        WHEN experience_level = 'SE' THEN 'Senior level'
        WHEN experience_level = 'EX' THEN 'Expert level'
        WHEN experience_level = 'MI' THEN 'Mid level'
        WHEN experience_level = 'EN' THEN 'Entry level'
    END AS experience_level,
    * EXCLUDE (experience_level)
FROM
    data_jobs;

-- to persist changes
UPDATE data_jobs
SET
    experience_level = CASE
        WHEN experience_level = 'SE' THEN 'Senior level'
        WHEN experience_level = 'EX' THEN 'Expert level'
        WHEN experience_level = 'MI' THEN 'Mid level'
        WHEN experience_level = 'EN' THEN 'Entry level'
    END

    
SELECT DISTINCT
    experience_level
FROM
    data_jobs