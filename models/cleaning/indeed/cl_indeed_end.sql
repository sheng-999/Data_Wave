---- clean indeed end ----
SELECT
    'indeed' AS info_source,
    job_title_min AS job_title,
    company,
    localisation AS location,
    posted_date_clean AS posted_date,
    ' '  AS job_function,
    salary,
    job_title_category,
    job_type,
    " " AS hierarchy,
    " " AS sector,
    whole_desc,
    contract_type,
    work_type
FROM {{ref("cl_indeed_segsalary")}}

   