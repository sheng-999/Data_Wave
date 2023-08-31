with
    cleaned_linkedin as (select * from {{ ref("cleaned_linkedin") }}),
    cleaned_indeed as (select * from {{ ref("cleaned_indeed") }})

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
FROM cleaned_linkedin

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
FROM cleaned_indeed