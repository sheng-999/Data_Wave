-- use of the macro function on the whole_desc & salary columns ------------- 

WITH salary_extract AS (
SELECT
    *,
    {{ func_salary('job_salary') }} as salaire_1,
    {{ func_salary('whole_desc') }} as salaire_2
FROM
    {{ ref ("cl_linkedin_def_worktype")}}
)

SELECT
    *,
    CASE
    WHEN salaire_1 IS NOT NULL
    THEN salaire_1
    ELSE salaire_2
    END AS salary
FROM 
    salary_extract