FROM food;


SELECT DISTINCT id FROM food;

-- 201 distinct items
SELECT COUNT(DISTINCT id) FROM food;

-- 135025 rows
SELECT COUNT(*) AS number_rows FROM food;

DESC food;

SELECT * FROM food WHERE week_id BETWEEN '2004-04' AND '2004-06';