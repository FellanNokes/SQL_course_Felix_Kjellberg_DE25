-- remove leading and trailing spaces
SELECT
    trim(sql_word, ' ') as trimmed_word,
    trimmed_word[1] as first_character,
    trimmed_word[-1] as last_character
FROM
    staging.sql_glossary

-- transform character to uppercase
SELECT
    upper(trim(sql_word, ' ')) as sql_term,
    sql_term[1] as first_character,
    sql_term[-1] as last_character
FROM
    staging.sql_glossary

-- replace two or more spaces with one space
SELECT
    description,
    replace(description, '  ', ' ')as cleaned_description
FROM staging.sql_glossary;

-- concatenate strings with ||
SELECT
    concat(upper(trim(sql_word, ' ')), ' command') as sql_command,
    upper(trim(sql_word, ' ')) || ' command' as sql_command1,
FROM
    staging.sql_glossary;

-- extract substring
SELECT
    trim(sql_word) as trimmed_word,
    substring(trim(sql_word),1,5) as first_five_chars,
    trimmed_word[1:5] as sliced_five_chars
FROM
    staging.sql_glossary;

-- reverse
SELECT
    reverse(trim(sql_word)) as reversed_word,
FROM
    staging.sql_glossary;

-- find position of first occurence of a substring
-- return 0 if substring is not found 
SELECT
    description,
    instr(description, 'select') as select_position,
    select_position != 0 as about_select
FROM staging.sql_glossary;