/* ========
    Task 2 
   ======== */
-- our answer
SELECT
    *
FROM
    staging.squad
WHERE
    NOT regexp_matches (context, title);

-- code along 
SELECT
    title,
    context,
    INSTR (context, title)
FROM
    staging.squad
WHERE
    NOT regexp_matches (context, title);

-- two arguments are string and substring
/* ========
    Task 3 
   ======== */
-- our answers
SELECT
    *
FROM
    staging.squad
WHERE
    context LIKE title || '%';

-- code along
-- use like operator with wildcard %
SELECT
    *
FROM
    staging.squad
WHERE
    context LIKE CONCAT (title, '%');

-- check the results for Southern_California
-- theresults are not ok due to the wildcard _

-- if you use regular expression functions, underscore will be a literal character
SELECT
    *
FROM
    staging.squad
WHERE
    regexp_matches (context, CONCAT ('^', title));

/* ========
    Task 4
   ======== */

-- show a new column which is the first answer from the AI model

SELECT
    answers[18:], -- slicing
    answers[18], -- indexing
    CASE 
        WHEN answers[18] = ',' THEN NULL
        ELSE answers[18:]
    END AS striped_answers,
    striped_answers[:INSTR(striped_answers, '''')-1] AS first_answer, -- a single quoation needs to be typed as ''
    answers
FROM staging.squad;


/* ========
    Task 5
   ======== */
-- generate same result as task 4 but with pattern matching

SELECT 
  -- dont allow single quotation
  regexp_extract(answers, '''([^'']+)'',' , 1) AS first_answer,
  -- allows upper and lower caste letters and numbers, space and , 1 removes the pattern from result
  regexp_extract(answers, '''([A-za-z0-9 ,]+)'',' , 1) AS first_answer_2,
  answers
FROM staging.squad;