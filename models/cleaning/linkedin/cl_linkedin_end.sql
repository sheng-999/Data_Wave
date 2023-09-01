-- final output before concatenation with indeed ------------- 
SELECT
    info_source,
    job_title,
    job_company AS company,
    job_location AS location,
    posted_date,
    function AS job_function,
    salary,
    job_title_category,
    type AS job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
    work_type
FROM
    {{ ref ("cl_linkedin_def_salary")}}