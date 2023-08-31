WITH salary_test AS (

SELECT
    *,
    {{ func_salary('whole_cat') }} as salary1
FROM 
    {{ref("stg_indeed")}}

)
SELECT *
FROM salary_test
wHERE salary1 IS NOT NULL