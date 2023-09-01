
-- use of the macro function on the whole_desc & swhole_cat columns ------------- 

WITH salary_extract AS (
SELECT
    *,
    {{ func_salary('whole_desc') }} as salaire_w_desc,
    {{ func_salary('whole_cat') }} as salaire_w_cat
FROM
    {{ref("cl_indeed_segposted_date")}}
)

SELECT
    *,
    CASE
    WHEN salaire_w_cat IS NOT NULL
    THEN salaire_w_cat
    ELSE salaire_w_desc
    END AS salary
FROM 
    salary_extract