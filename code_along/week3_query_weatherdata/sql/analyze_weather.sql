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
    to_timestamp (sunriseTime) AT TIME ZONE 'Europe/Stockholm' AS sunrise, -- this function transform numeric columns to timestamp
    to_timestamp (sunsetTime) AT TIME ZONE 'Europe/Stockholm' AS sunset,
    sunset - sunrise AS gap
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden';

/*=====
TASK 5
======= */
-- the new year and month columns involves sburtracting a part of timestamp
-- to pick up the date with the largest gap within a month involves the use of aggregation function
-- the gap can be calculated directly with UNIX time
SELECT
    date_part ('year', to_timestamp (sunriseTime)) AS year,
    date_part ('month', to_timestamp (sunriseTime)) AS month,
    to_timestamp (MAX(sunriseTime)),
    to_timestamp (MAX(sunsetTime)),
    ROUND(MAX(sunsetTime - sunriseTime) / 3600, 1) AS gap_hours -- divide by 3600 to show the gap in hours
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden'
GROUP BY
    year,
    month
ORDER BY
    year,
    month;

/*=====
TASK 6
======= */
-- concatenate integer and string
SELECT
    to_timestamp (windGustTime) AT TIME ZONE 'Europe/Stockholm' AS most_windy_timestamp,
    date_part ('hour', most_windy_timestamp) AS most_windy_hour,
    CONCAT (
        'It''s dangerous to use the crance at kl.',
        most_windy_hour
    )
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden'
    -- concatenate string and string
SELECT
    to_timestamp (windGustTime) AT TIME ZONE 'Europe/Stockholm' AS most_windy_timestamp,
    -- strftime(), string format time transforms timestamp to string
    -- use the format like '%H', to design the presentation
    -- strptime(), string parse time, transform string to timestamp
    strftime(most_windy_timestamp, '%H:%M') AS most_windy_hour,
    CONCAT (
        'It''s dangerous to use the crance at kl.',
        most_windy_hour
    )
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden'