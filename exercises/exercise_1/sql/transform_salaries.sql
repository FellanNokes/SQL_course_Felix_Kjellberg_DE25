/* ==================
0. TRANSFORM SALARIES
===================== */

-- For this task you should use the same salaries data as in lecture 04 and 05. Create a new table that should contain the transformed data and call the table cleaned_salaries.

-- &nbsp; a) Transform employment type column based on this table
-- | abbreviation | meaning   |
-- | ------------ | --------- |
-- | CT           | Contract  |
-- | FL           | Freelance |
-- | PT           | Part time |
-- | FT           | Full time |
SELECT
    CASE
        WHEN employment_type = 'CT' THEN 'Contract'
        WHEN employment_type = 'FL' THEN 'Freelance'
        WHEN employment_type = 'PT' THEN 'Part time'
        WHEN employment_type = 'FT' THEN 'Full time'
    END AS employment_type,
    * EXCLUDE (employment_type)
FROM staging.salaries;

UPDATE staging.salaries
SET
    employment_type = CASE
        WHEN employment_type = 'CT' THEN 'Contract'
        WHEN employment_type = 'FL' THEN 'Freelance'
        WHEN employment_type = 'PT' THEN 'Part time'
        WHEN employment_type = 'FT' THEN 'Full time'
    END;
SELECT DISTINCT employment_type
FROM staging.salaries;

-- ┌─────────────────┐
-- │ employment_type │
-- │     varchar     │
-- ├─────────────────┤
-- │ Full time       │
-- │ Freelance       │
-- │ Contract        │
-- │ Part time       │
-- └─────────────────┘

-- &nbsp; b) Do similar for company size, but you have to figure out what the abbreviations could stand for.

SELECT
    CASE
        WHEN company_size = 'S' THEN 'Small'
        WHEN company_size = 'M' THEN 'Medium'
        WHEN company_size = 'L' THEN 'Large'
    END AS company_size,
    * EXCLUDE (company_size)
FROM staging.salaries;

UPDATE staging.salaries
SET 
    company_size = CASE
        WHEN company_size = 'S' THEN 'Small'
        WHEN company_size = 'M' THEN 'Medium'
        WHEN company_size = 'L' THEN 'Large'
    END;

SELECT DISTINCT company_size
FROM staging.salaries;        

-- Results 
-- ┌──────────────┐
-- │ company_size │
-- │   varchar    │
-- ├──────────────┤
-- │ Large        │
-- │ Medium       │
-- │ Small        │
-- └──────────────┘

-- &nbsp; c) Make a salary column with Swedish currency for yearly salary.
SELECT
    salary_in_usd,
    ROUND(salary_in_usd*9.55) AS salary_in_sek
FROM staging.salaries;

ALTER TABLE staging.salaries
ADD COLUMN salary_in_sek DOUBLE;

UPDATE staging.salaries
SET salary_in_sek = ROUND(salary_in_usd*9.55);

-- &nbsp; d) Make a salary column with Swedish currency for monthly salary.
ALTER TABLE staging.salaries
ADD COLUMN monthly_salary_in_sek INT;

UPDATE staging.salaries
SET monthly_salary_in_sek = salary_in_sek/12;

-- &nbsp; e) Make a salary_level column with the following categories: low, medium, high, insanely_high. Decide your thresholds for each category. Make it base on the monthly salary in SEK.
ALTER TABLE staging.salaries
ADD COLUMN salary_level VARCHAR;

UPDATE staging.salaries
SET
    salary_level = CASE
        WHEN monthly_salary_in_sek < 30000 THEN 'low'
        WHEN monthly_salary_in_sek < 60000 THEN 'medium'
        WHEN monthly_salary_in_sek < 120000 THEN 'high'
        WHEN monthly_salary_in_sek >= 120000 THEN 'insanely high'
    END;

SELECT
    employment_type,
    job_title,
    monthly_salary_in_sek,
    salary_level
FROM staging.salaries;

┌─────────────────┬────────────────────────────────────┬───────────────────────┬───────────────┐
│ employment_type │             job_title              │ monthly_salary_in_sek │ salary_level  │
│     varchar     │              varchar               │         int32         │    varchar    │
├─────────────────┼────────────────────────────────────┼───────────────────────┼───────────────┤
│ Full time       │ AI Engineer                        │                161339 │ insanely high │
│ Full time       │ AI Engineer                        │                 73311 │ high          │
│ Full time       │ Data Engineer                      │                103856 │ high          │
│ Full time       │ Data Engineer                      │                 76400 │ high          │
│ Full time       │ Machine Learning Engineer          │                151208 │ insanely high │
│ Full time       │ Machine Learning Engineer          │                127333 │ insanely high │
│ Full time       │ ML Engineer                        │                318333 │ insanely high │
│ Full time       │ ML Engineer                        │                 51729 │ medium        │
│ Full time       │ Data Analyst                       │                 80793 │ high          │
│ Full time       │ Data Analyst                       │                 36500 │ medium        │
│ Full time       │ Data Engineer                      │                137257 │ insanely high │
│ Full time       │ Data Engineer                      │                 91477 │ high          │
│ Full time       │ NLP Engineer                       │                159167 │ insanely high │
│ Full time       │ NLP Engineer                       │                119375 │ high          │
│ Full time       │ Data Scientist                     │                124508 │ insanely high │
│ Full time       │ Data Scientist                     │                 94863 │ high          │
│ Full time       │ Data Analyst                       │                135292 │ insanely high │
│ Full time       │ Data Analyst                       │                103458 │ high          │
│ Full time       │ Applied Scientist                  │                176834 │ insanely high │
│ Full time       │ Applied Scientist                  │                108233 │ high          │
│     ·           │         ·                          │                   ·   │  ·            │
│     ·           │         ·                          │                   ·   │  ·            │
│     ·           │         ·                          │                   ·   │  ·            │
│ Full time       │ Lead Data Analyst                  │                 15606 │ low           │
│ Full time       │ Data Analyst                       │                 59688 │ medium        │
│ Full time       │ Data Analyst                       │                 49342 │ medium        │
│ Full time       │ Data Scientist                     │                 58096 │ medium        │
│ Full time       │ Data Engineer                      │                 36124 │ medium        │
│ Full time       │ Data Science Manager               │                151368 │ insanely high │
│ Full time       │ Data Scientist                     │                 93908 │ high          │
│ Full time       │ Data Scientist                     │                110104 │ high          │
│ Full time       │ Data Engineer                      │                104095 │ high          │
│ Full time       │ Machine Learning Engineer          │                 36304 │ medium        │
│ Full time       │ Director of Data Science           │                133700 │ insanely high │
│ Full time       │ Data Scientist                     │                 94751 │ high          │
│ Full time       │ Applied Machine Learning Scientist │                336638 │ insanely high │
│ Full time       │ Data Engineer                      │                 22577 │ low           │
│ Full time       │ Data Specialist                    │                131312 │ insanely high │
│ Full time       │ Data Scientist                     │                327883 │ insanely high │
│ Full time       │ Principal Data Scientist           │                120171 │ insanely high │
│ Full time       │ Data Scientist                     │                 83562 │ high          │
│ Contract        │ Business Data Analyst              │                 79583 │ high          │
│ Full time       │ Data Science Manager               │                 75338 │ high          │
├─────────────────┴────────────────────────────────────┴───────────────────────┴───────────────┤
│ 16534 rows (40 shown)                                                              4 columns │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
-- &nbsp; f) Choose the following columns to include in your table: experience_level, employment_type, job_title, salary_annual_sek, salary_monthly_sek, remote_ratio, company_size, salary_level
SELECT 
    experience_level,
    employment_type,
    job_title,
    salary_in_sek,
    monthly_salary_in_sek,
    remote_ratio,
    company_size,
    salary_level
FROM staging.salaries;

┌──────────────────┬─────────────────┬────────────────────────────────────┬───────────────┬───────────────────────┬──────────────┬──────────────┬───────────────┐
│ experience_level │ employment_type │             job_title              │ salary_in_sek │ monthly_salary_in_sek │ remote_ratio │ company_size │ salary_level  │
│     varchar      │     varchar     │              varchar               │     int32     │         int32         │    int64     │   varchar    │    varchar    │
├──────────────────┼─────────────────┼────────────────────────────────────┼───────────────┼───────────────────────┼──────────────┼──────────────┼───────────────┤
│ SE               │ Full time       │ AI Engineer                        │       1936072 │                161339 │            0 │ Medium       │ insanely high │
│ SE               │ Full time       │ AI Engineer                        │        879727 │                 73311 │            0 │ Medium       │ high          │
│ SE               │ Full time       │ Data Engineer                      │       1246275 │                103856 │            0 │ Medium       │ high          │
│ SE               │ Full time       │ Data Engineer                      │        916800 │                 76400 │            0 │ Medium       │ high          │
│ SE               │ Full time       │ Machine Learning Engineer          │       1814500 │                151208 │            0 │ Medium       │ insanely high │
│ SE               │ Full time       │ Machine Learning Engineer          │       1528000 │                127333 │            0 │ Medium       │ insanely high │
│ MI               │ Full time       │ ML Engineer                        │       3820000 │                318333 │            0 │ Medium       │ insanely high │
│ MI               │ Full time       │ ML Engineer                        │        620750 │                 51729 │            0 │ Medium       │ medium        │
│ EN               │ Full time       │ Data Analyst                       │        969516 │                 80793 │            0 │ Medium       │ high          │
│ EN               │ Full time       │ Data Analyst                       │        438001 │                 36500 │            0 │ Medium       │ medium        │
│ SE               │ Full time       │ Data Engineer                      │       1647079 │                137257 │            0 │ Medium       │ insanely high │
│ SE               │ Full time       │ Data Engineer                      │       1097725 │                 91477 │            0 │ Medium       │ high          │
│ EX               │ Full time       │ NLP Engineer                       │       1910000 │                159167 │            0 │ Medium       │ insanely high │
│ EX               │ Full time       │ NLP Engineer                       │       1432500 │                119375 │            0 │ Medium       │ high          │
│ MI               │ Full time       │ Data Scientist                     │       1494098 │                124508 │          100 │ Medium       │ insanely high │
│ MI               │ Full time       │ Data Scientist                     │       1138360 │                 94863 │          100 │ Medium       │ high          │
│ SE               │ Full time       │ Data Analyst                       │       1623500 │                135292 │            0 │ Medium       │ insanely high │
│ SE               │ Full time       │ Data Analyst                       │       1241500 │                103458 │            0 │ Medium       │ high          │
│ SE               │ Full time       │ Applied Scientist                  │       2122010 │                176834 │            0 │ Large        │ insanely high │
│ SE               │ Full time       │ Applied Scientist                  │       1298800 │                108233 │            0 │ Large        │ high          │
│ ·                │     ·           │         ·                          │           ·   │                   ·   │            · │   ·          │  ·            │
│ ·                │     ·           │         ·                          │           ·   │                   ·   │            · │   ·          │  ·            │
│ ·                │     ·           │         ·                          │           ·   │                   ·   │            · │   ·          │  ·            │
│ MI               │ Full time       │ Lead Data Analyst                  │        187266 │                 15606 │          100 │ Large        │ low           │
│ MI               │ Full time       │ Data Analyst                       │        716250 │                 59688 │            0 │ Large        │ medium        │
│ MI               │ Full time       │ Data Analyst                       │        592100 │                 49342 │            0 │ Large        │ medium        │
│ MI               │ Full time       │ Data Scientist                     │        697150 │                 58096 │            0 │ Large        │ medium        │
│ MI               │ Full time       │ Data Engineer                      │        433484 │                 36124 │          100 │ Large        │ medium        │
│ SE               │ Full time       │ Data Science Manager               │       1816410 │                151368 │          100 │ Medium       │ insanely high │
│ MI               │ Full time       │ Data Scientist                     │       1126900 │                 93908 │          100 │ Medium       │ high          │
│ MI               │ Full time       │ Data Scientist                     │       1321243 │                110104 │          100 │ Medium       │ high          │
│ MI               │ Full time       │ Data Engineer                      │       1249140 │                104095 │          100 │ Medium       │ high          │
│ SE               │ Full time       │ Machine Learning Engineer          │        435652 │                 36304 │          100 │ Small        │ medium        │
│ SE               │ Full time       │ Director of Data Science           │       1604400 │                133700 │            0 │ Small        │ insanely high │
│ MI               │ Full time       │ Data Scientist                     │       1137013 │                 94751 │          100 │ Medium       │ high          │
│ MI               │ Full time       │ Applied Machine Learning Scientist │       4039650 │                336638 │           50 │ Large        │ insanely high │
│ MI               │ Full time       │ Data Engineer                      │        270924 │                 22577 │           50 │ Large        │ low           │
│ SE               │ Full time       │ Data Specialist                    │       1575750 │                131312 │          100 │ Large        │ insanely high │
│ SE               │ Full time       │ Data Scientist                     │       3934600 │                327883 │          100 │ Large        │ insanely high │
│ MI               │ Full time       │ Principal Data Scientist           │       1442050 │                120171 │          100 │ Large        │ insanely high │
│ EN               │ Full time       │ Data Scientist                     │       1002750 │                 83562 │          100 │ Small        │ high          │
│ EN               │ Contract        │ Business Data Analyst              │        955000 │                 79583 │          100 │ Large        │ high          │
│ SE               │ Full time       │ Data Science Manager               │        904051 │                 75338 │           50 │ Large        │ high          │
├──────────────────┴─────────────────┴────────────────────────────────────┴───────────────┴───────────────────────┴──────────────┴──────────────┴───────────────┤
│ 16534 rows (40 shown)                                                                                                                               8 columns │
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

/* =========================
1. EXPLORE TRANSFORMED TABLE
============================ */
--   a) Count number of Data engineers jobs. For simplicity just go for job_title Data Engineer.
SELECT 
COUNT(*) AS number_data_engineers
FROM staging.salaries
WHERE job_title LIKE 'Data Engineer';
┌───────────────────────┐
│ number_data_engineers │
│         int64         │
├───────────────────────┤
│         3464          │
└───────────────────────┘

--   b) Count number of unique job titles in total.

SELECT 
COUNT(DISTINCT job_title)
FROM staging.salaries;

┌───────────────────────────┐
│ count(DISTINCT job_title) │
│           int64           │
├───────────────────────────┤
│            155            │
└───────────────────────────┘

--   c) Find out how many jobs that goes into each salary level. 
SELECT DISTINCT job_title, salary_level
FROM staging.salaries
ORDER BY
job_title;

┌─────────────────────────────────┬───────────────┐
│            job_title            │ salary_level  │
│             varchar             │    varchar    │
├─────────────────────────────────┼───────────────┤
│ AI Architect                    │ high          │
│ AI Architect                    │ insanely high │
│ AI Developer                    │ high          │
│ AI Developer                    │ medium        │
│ AI Developer                    │ low           │
│ AI Developer                    │ insanely high │
│ AI Engineer                     │ high          │
│ AI Engineer                     │ low           │
│ AI Engineer                     │ medium        │
│ AI Engineer                     │ insanely high │
│ AI Product Manager              │ insanely high │
│ AI Product Manager              │ high          │
│ AI Programmer                   │ low           │
│ AI Programmer                   │ high          │
│ AI Programmer                   │ medium        │
│ AI Research Engineer            │ high          │
│ AI Research Engineer            │ medium        │
│ AI Research Engineer            │ low           │
│ AI Research Engineer            │ insanely high │
│ AI Research Scientist           │ high          │
│         ·                       │  ·            │
│         ·                       │  ·            │
│         ·                       │  ·            │
│ Research Engineer               │ low           │
│ Research Engineer               │ high          │
│ Research Scientist              │ medium        │
│ Research Scientist              │ high          │
│ Research Scientist              │ insanely high │
│ Research Scientist              │ low           │
│ Robotics Engineer               │ insanely high │
│ Robotics Engineer               │ high          │
│ Robotics Engineer               │ medium        │
│ Robotics Software Engineer      │ insanely high │
│ Robotics Software Engineer      │ high          │
│ Sales Data Analyst              │ medium        │
│ Software Data Engineer          │ medium        │
│ Software Data Engineer          │ insanely high │
│ Staff Data Analyst              │ low           │
│ Staff Data Analyst              │ medium        │
│ Staff Data Analyst              │ insanely high │
│ Staff Data Scientist            │ insanely high │
│ Staff Data Scientist            │ high          │
│ Staff Machine Learning Engineer │ insanely high │
├─────────────────────────────────┴───────────────┤
│ 401 rows (40 shown)                   2 columns │
└─────────────────────────────────────────────────┘

--   d) Find out the median and mean salaries for each seniority levels.
SELECT 
    job_title,
    experience_level,
    ROUND(MEDIAN(monthly_salary_in_sek)) AS median_salary,
    ROUND(MEAN(monthly_salary_in_sek)) AS mean_salary,
FROM staging.salaries
GROUP BY
job_title, experience_level
ORDER BY median_salary DESC, job_title, experience_level;

┌────────────────────────────────────┬──────────────────┬───────────────┬─────────────┐
│             job_title              │ experience_level │ median_salary │ mean_salary │
│              varchar               │     varchar      │    double     │   double    │
├────────────────────────────────────┼──────────────────┼───────────────┼─────────────┤
│ AI Architect                       │ MI               │      636667.0 │    636667.0 │
│ Principal Data Scientist           │ EX               │      331067.0 │    331067.0 │
│ Analytics Engineering Manager      │ SE               │      318238.0 │    318238.0 │
│ Data Science Tech Lead             │ SE               │      298438.0 │    298438.0 │
│ Head of Machine Learning           │ EX               │      262625.0 │    238558.0 │
│ Deep Learning Engineer             │ SE               │      233644.0 │    216765.0 │
│ Managing Director Data Science     │ EX               │      222834.0 │    222834.0 │
│ AWS Data Architect                 │ MI               │      205325.0 │    205325.0 │
│ Cloud Data Architect               │ SE               │      198958.0 │    198958.0 │
│ Director of Data Science           │ EX               │      184036.0 │    183577.0 │
│ Data Lead                          │ EX               │      179859.0 │    171370.0 │
│ Applied Machine Learning Engineer  │ EX               │      179062.0 │    179062.0 │
│ Head of Data                       │ EX               │      177471.0 │    174049.0 │
│ Machine Learning Engineer          │ EX               │      175760.0 │    187045.0 │
│ AI Architect                       │ EX               │      171849.0 │    171849.0 │
│ Robotics Software Engineer         │ SE               │      170309.0 │    173094.0 │
│ Data Science                       │ EX               │      170189.0 │    170751.0 │
│ ML Engineer                        │ EX               │      167881.0 │    167881.0 │
│ Computer Vision Engineer           │ SE               │      163146.0 │    158646.0 │
│ Director of Data Science           │ MI               │      162748.0 │    162748.0 │
│            ·                       │ ·                │          ·    │        ·    │
│            ·                       │ ·                │          ·    │        ·    │
│            ·                       │ ·                │          ·    │        ·    │
│            ·                       │ ·                │          ·    │        ·    │
│            ·                       │ ·                │          ·    │        ·    │
│ Applied Machine Learning Scientist │ EN               │       34370.0 │     32443.0 │
│ Applied Machine Learning Scientist │ EN               │       34370.0 │     32443.0 │
│ Applied Data Scientist             │ EN               │       31833.0 │     41340.0 │
│ Applied Data Scientist             │ EN               │       31833.0 │     41340.0 │
│ CRM Data Analyst                   │ SE               │       31833.0 │     31833.0 │
│ Finance Data Analyst               │ EN               │       31833.0 │     31833.0 │
│ CRM Data Analyst                   │ SE               │       31833.0 │     31833.0 │
│ Finance Data Analyst               │ EN               │       31833.0 │     31833.0 │
│ Finance Data Analyst               │ EN               │       31833.0 │     31833.0 │
│ Machine Learning Developer         │ EN               │       31833.0 │     58573.0 │
│ Lead Data Analyst                  │ MI               │       31527.0 │     37001.0 │
│ Machine Learning Developer         │ EN               │       31833.0 │     58573.0 │
│ Lead Data Analyst                  │ MI               │       31527.0 │     37001.0 │
│ Lead Data Analyst                  │ MI               │       31527.0 │     37001.0 │
│ AI Scientist                       │ EN               │       30806.0 │     48476.0 │
│ AI Scientist                       │ EN               │       30806.0 │     48476.0 │
│ Principal Data Architect           │ SE               │       30364.0 │     30364.0 │
│ Principal Data Architect           │ SE               │       30364.0 │     30364.0 │
│ Data Integration Specialist        │ SE               │       29034.0 │     29034.0 │
│ Data Integration Specialist        │ SE               │       29034.0 │     29034.0 │
│ AI Engineer                        │ EN               │       27854.0 │     26803.0 │
│ AI Engineer                        │ EN               │       27854.0 │     26803.0 │
│ Head of Data                       │ MI               │       25085.0 │     25085.0 │
│ AI Programmer                      │ MI               │       23875.0 │     23875.0 │
│ Big Data Engineer                  │ MI               │       21974.0 │     28142.0 │
│ Head of Data                       │ MI               │       25085.0 │     25085.0 │
│ AI Programmer                      │ MI               │       23875.0 │     23875.0 │
│ Big Data Engineer                  │ MI               │       21974.0 │     28142.0 │
│ AI Programmer                      │ MI               │       23875.0 │     23875.0 │
│ Big Data Engineer                  │ MI               │       21974.0 │     28142.0 │
│ Data Analytics Manager             │ EN               │       21488.0 │     21488.0 │
│ AI Research Engineer               │ EN               │       19848.0 │     22867.0 │
│ Data Quality Engineer              │ EN               │       18903.0 │     18903.0 │
│ Data Analytics Engineer            │ EN               │       15917.0 │     15917.0 │
│ Product Data Analyst               │ MI               │       15917.0 │     46800.0 │
│ Data Analyst Lead                  │ EN               │       14325.0 │     14325.0 │
│ Staff Data Analyst                 │ EX               │       11938.0 │     11938.0 │
├────────────────────────────────────┴──────────────────┴───────────────┴─────────────┤
│ 349 rows (40 shown)                                                       4 columns │
└─────────────────────────────────────────────────────────────────────────────────────┘

--   e) Find out the top earning job titles based on their median salaries and how much they earn.

SELECT 
    job_title,
    ROUND(MEDIAN(monthly_salary_in_sek)) AS median_salary,
    ROUND(MEAN(monthly_salary_in_sek)) AS mean_salary,
FROM staging.salaries
GROUP BY
job_title
ORDER BY median_salary DESC, mean_salary DESC;

┌───────────────────────────────────┬───────────────┬─────────────┐
│             job_title             │ median_salary │ mean_salary │
│              varchar              │    double     │   double    │
├───────────────────────────────────┼───────────────┼─────────────┤
│ Analytics Engineering Manager     │      318238.0 │    318238.0 │
│ Data Science Tech Lead            │      298438.0 │    298438.0 │
│ Head of Machine Learning          │      262625.0 │    238558.0 │
│ Managing Director Data Science    │      222834.0 │    222834.0 │
│ AWS Data Architect                │      205325.0 │    205325.0 │
│ Cloud Data Architect              │      198958.0 │    198958.0 │
│ Director of Data Science          │      172696.0 │    174109.0 │
│ Head of Data                      │      171104.0 │    168606.0 │
│ AI Architect                      │      162350.0 │    200989.0 │
│ Prompt Engineer                   │      156788.0 │    163220.0 │
│ Robotics Software Engineer        │      153596.0 │    156481.0 │
│ Applied Scientist                 │      152800.0 │    151196.0 │
│ Data Science Director             │      151208.0 │    141194.0 │
│ Data Science Manager              │      151009.0 │    154361.0 │
│ Director of Business Intelligence │      149219.0 │    149219.0 │
│ Data Infrastructure Engineer      │      148821.0 │    162503.0 │
│ Staff Machine Learning Engineer   │      147229.0 │    147229.0 │
│ Computer Vision Engineer          │      147229.0 │    137422.0 │
│ Principal Data Engineer           │      147229.0 │    126477.0 │
│ Machine Learning Engineer         │      147150.0 │    150113.0 │
│           ·                       │          ·    │        ·    │
│           ·                       │          ·    │        ·    │
│           ·                       │          ·    │        ·    │
│ Applied Data Scientist            │       51555.0 │     77199.0 │
│ Power BI Developer                │       51555.0 │     51555.0 │
│ AI Research Engineer              │       50402.0 │     66025.0 │
│ Data Quality Manager              │       49523.0 │     65937.0 │
│ Finance Data Analyst              │       49259.0 │    112955.0 │
│ AI Programmer                     │       47915.0 │     49375.0 │
│ BI Data Analyst                   │       47750.0 │     54038.0 │
│ BI Data Engineer                  │       47750.0 │     47750.0 │
│ Sales Data Analyst                │       47750.0 │     47750.0 │
│ Admin & Data Analyst              │       43771.0 │     49187.0 │
│ Machine Learning Specialist       │       43771.0 │     43771.0 │
│ Big Data Engineer                 │       43208.0 │     52725.0 │
│ Data DevOps Engineer              │       42962.0 │     52237.0 │
│ Lead Data Analyst                 │       42822.0 │     53383.0 │
│ Quantitative Research Analyst     │       40588.0 │     40588.0 │
│ Insight Analyst                   │       40459.0 │     39864.0 │
│ Compliance Data Analyst           │       35813.0 │     35813.0 │
│ Staff Data Analyst                │       35616.0 │     63601.0 │
│ CRM Data Analyst                  │       31833.0 │     31833.0 │
│ Principal Data Architect          │       30364.0 │     30364.0 │
├───────────────────────────────────┴───────────────┴─────────────┤
│ 155 rows (40 shown)                                   3 columns │
└─────────────────────────────────────────────────────────────────┘

--   f) How many percentage of the jobs are fully remote, 50 percent remote and fully not remote.

SELECT
    COUNT(*) AS amount_jobs,
    COUNT(CASE WHEN remote_ratio = 50 THEN 1 END) * 100.0 / COUNT(*) AS percent_hybrid,
    COUNT(CASE WHEN remote_ratio = 100 THEN 1 END) * 100.0 / COUNT(*) AS percent_remote
FROM staging.salaries;

--   g) Pick out a job title of interest and figure out if company size affects the salary. Make a simple analysis as a comprehensive one requires causality investigations which are much harder to find.

--   h) Feel free to explore other things