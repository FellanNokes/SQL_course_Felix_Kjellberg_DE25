/* ======================
0. Making course database
=========================*/
-- a) Select all exercises in this course
*
FROM
    staging.course_structure
WHERE
    content_type = 'exercise';

-- b) Select all lectures in this course
SELECT
    *
FROM
    staging.course_structure
WHERE
    content_type = 'lecture';

--c) Select all records for week 48
SELECT
    *
FROM
    staging.course_structure
WHERE
    week = 48;

--d) Select all records for week 47-49
SELECT
    *
FROM
    staging.course_structure
WHERE
    week BETWEEN 47 AND 49;

--e) How many lectures are in the table?
SELECT
    COUNT(content_type)
FROM
    staging.course_structure
WHERE
    content_type = "lecture"
    -- 22
    --f) How many other content are there?
SELECT DISTINCT
    content_type
FROM
    staging.course_structure
    --3
 --g) Which are the unique content types in this table?
    --exam, lecture, exercise

--h) Delete the row with content 02_setup_duckdb and add it again.
--i) You see that 02_setup_duckdb comes in the end of your table, even though the week is 46. Now make a query where you sort the weeks in ascending order.
--j) Now you can choose what you want to explore in this table.