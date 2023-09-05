SELECT 
    info_source,
    job_title,
    company,
    location,
    posted_date,
    job_function,
    salary,
    job_title_category,
    job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
    work_type,
    ville,
    if (location is not null, "france","") as country
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
    job_title_category,
    job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
    work_type,
    ville,
    if (location is not null, "france","") as country
FROM {{ ref("cl_indeed_end") }}