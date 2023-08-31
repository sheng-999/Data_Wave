with
    cleaned_linkedin as (select * from {{ ref("cleaned_linkedin") }}),
    cleaned_indeed as (select * from {{ ref("cleaned_indeed") }})

SELECT 
    job_title,
    company,
    location,
    posted_date,
    salary,
    job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
FROM cleaned_linkedin

UNION ALL
SELECT
    job_title,
    company,
    location,
    posted_date,
    salary,
    job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
FROM cleaned_indeed