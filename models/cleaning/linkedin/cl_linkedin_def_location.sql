-- use of the macro function to clean the location and join referential tables to get department, region & geoloc------------ 

WITH cleaned_table AS (
SELECT
    *,
    {{ func_location('job_location') }} as clean_location
FROM
    {{ ref ("cl_linkedin_def_salary")}}
)

-- match the city with the city list
, match_city AS (
SELECT
    job_title,
    job_company,
    job_location,
    whole_desc,
    posted_date,
    job_salary,
    function,
    type,
    hierarchy,
    sector,
    job_title_min,
    job_title_category,
    contract_type,
    work_type,
    salary,
    clean_location,
    ville
FROM 
    cleaned_table AS loc
LEFT JOIN {{ ref ("cleaned_localisation")}} AS city
ON loc.clean_location = city.ville
)

---- match location with departement name and use prefecture as the city
, match_department AS (
SELECT
    job_title,
    job_company,
    job_location,
    whole_desc,
    posted_date,
    job_salary,
    function,
    type,
    hierarchy,
    sector,
    job_title_min,
    job_title_category,
    contract_type,
    work_type,
    salary,
    clean_location,
    ville,
    prefecture
FROM 
    match_city AS loc
LEFT JOIN {{ ref ("cleaned_dpt_prefecture")}} AS dpt
ON loc.clean_location = dpt.departement
)

---- match the location with the region and name and use the chef lieu as the city
, match_region AS (
SELECT
    job_title,
    job_company,
    job_location,
    whole_desc,
    posted_date,
    job_salary,
    function,
    type,
    hierarchy,
    sector,
    job_title_min,
    job_title_category,
    contract_type,
    work_type,
    salary,
    clean_location,
    ville,
    prefecture,
    chef_lieu
FROM 
    match_department AS loc
LEFT JOIN {{ ref ("cleaned_reg_chef_lieu")}} AS reg
ON loc.clean_location = reg.region
)

SELECT
    job_title,
    job_company,
    job_location,
    whole_desc,
    posted_date,
    job_salary,
    function,
    type,
    hierarchy,
    sector,
    job_title_min,
    job_title_category,
    contract_type,
    work_type,
    salary,
    CASE
    WHEN ville IS NOT NULL THEN ville
    WHEN prefecture IS NOT NULL THEN prefecture
    WHEN chef_lieu IS NOT NULL THEN chef_lieu
    END AS ville
FROM match_region