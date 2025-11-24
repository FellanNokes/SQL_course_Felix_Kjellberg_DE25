DESC staging.sweden_holidays;

FROM
    staging.sweden_holidays;

-- addition and subtraction
SELECT
    date,
    date + interval 5 day as plus_5_days,
    typeof (plus_5_days) AS plus_5_days_type,
    date - interval 5 day as minus_5_days
FROM
    staging.sweden_holidays;

-- DATE functions
SELECT
    today ();

SELECT
    today () AS today,
    date - today AS time_to_holiday,
    *
FROM
    staging.sweden_holidays;

-- pick out weekday
SELECT
    date,
    dayname (date) as weekday
FROM
    staging.sweden_holidays;

-- lasted from two dates
SELECT
    *,
    today () AS today,
    greatest (date, today) as later_day
FROM
    staging.sweden_holidays;

-- convert date to string
SELECT
    date,
    strftime(date, '%d/%m/%Y') AS date_string,
    typeof(date_string)
FROM
    staging.sweden_holidays;

-- convert string to date
SELECT
    date,
    strftime(date, '%d/%m/%Y') AS date_string,
    strptime(date_string, '%d/%m/%Y')::DATE AS new_date,
    typeof(new_date)
FROM
    staging.sweden_holidays;