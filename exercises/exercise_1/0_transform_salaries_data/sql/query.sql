-- ## 0. Transform salaries data

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
-- &nbsp; g) Think of other transformation that you want to do.