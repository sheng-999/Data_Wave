SELECT 
    info_source,
    job_title,
    company,
    location,
    posted_date,
    job_function,
    salary,
    job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
    work_type
FROM {{ ref("cl_linkedin_end") }}

UNION ALL
SELECT
    info_source,
    job_title,
    company,
    location,
    posted_date,
    job_function,
    salary,
    job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
    work_type
FROM {{ ref("cl_indeed_end") }}