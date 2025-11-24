desc staging.train_schedule;

FROM
    staging.train_schedule;

-- time difference
SELECT
    scheduled_arrival,
    actual_arrival,
    delay_minutes,
    age (actual_arrival, scheduled_arrival) as delay_inteveral,
    typeof (delay_inteveral)
FROM
    staging.train_schedule;

SELECT
    current_localtimestamp () as current_time,
    date_trunc ('second', current_time) as second;

-- truncate a timestamp to specific precision
SELECT
    scheduled_arrival,
    date_trunc ('hour', scheduled_arrival) as scheduled_arrival_trunc
FROM
    staging.train_schedule
    -- extract subfield of timestamp
    -- show arrival hour in text
SELECT
    scheduled_arrival,
    'kl.' || extract(
        'hour'
        FROM
            scheduled_arrival
    ) AS scheduled_arrival_hour
FROM
    staging.train_schedule