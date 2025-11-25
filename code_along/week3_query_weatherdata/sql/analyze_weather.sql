/* =========
TASK 2
========= */
DESC staging.weather;

DESC
SELECT
    sunriseTime,
    sunsetTime,
    temperatureHighTime,
    temperatureLowTime,
    windGustTime,
    precipIntensityMaxTime
FROM
    staging.weather;

-- show the UNIX values of these columns
-- the values are the numbers of seconds counted from a refernce time point (1970-01-01 00:00:00)
/* ========
TASK 3
======== */
-- each row in the dataset contains weather data for each combination of Country/Region, Province/State and date (time cloumn)
-- IMPORTANT: it's important to understand which coluns can be used to uniquely identify each row
-- use aggregation function together with group by 
SELECT
    "Country/Region" AS Country,
    "Province/State" AS State,
    COUNT(*) AS nr_records,
FROM
    staging.weather
GROUP BY
    Country,
    State
ORDER BY
    Country;

/* ========
TASK 4
======== */
SELECT
    to_timestamp (sunriseTime) AS sunrise, -- this function transform numeric columns to timestamp
    to_timestamp (sunsetTime) AS sunset,
    sunset - sunrise AS gap
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden';