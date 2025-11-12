/* want to delete bad jokes
to make sure which to delete
do a select first to double check the rows */
SELECT
    *
FROM
    funny_jokes
WHERE
    rating < 5;

DELETE FROM funny_jokes
WHERE
    rating < 5;