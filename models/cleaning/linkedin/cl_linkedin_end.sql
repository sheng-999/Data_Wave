-- final output before concatenation with indeed ------------- 
SELECT
    'linkedin' AS info_source,
    job_title_min AS job_title,
    job_company AS company,
    ville AS location,
    posted_date,
    function AS job_function,
    salary,
    job_title_category,
    type AS job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
    work_type,
    location_city,
    latitude,
    longitude,
    departement,
    region
FROM
    {{ ref ("cl_linkedin_def_location")}}