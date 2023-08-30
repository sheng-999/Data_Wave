WITH stg_linkedin AS (SELECT * FROM {{ ref ('stg_linkedin')}} )

 
--- job title clean without accent and lower ---
, title_cleaning AS (
SELECT
*,
REPLACE(REPLACE(REPLACE(LOWER(job_title), 'é', 'e'), 'è', 'e'), "(h/f)", "") as job_title_min,
FROM stg_linkedin
)
, title_cat AS (
SELECT
    job_title,
    job_company,
    job_location,
    posted_date,
    job_salary,
    function,
    type as job_type,
    hierarchy,
    sector,
    whole_desc,
    --- job title simplified in 3 categories ---
    CASE
        WHEN REGEXP_CONTAINS(job_title_min, 'data analyst|data analyste|analyste data|analyste de donnees|analyste donnees|analyste des donnees|data integrity analyst|data quality analyst|data quality analyste|analyste base de donnees|programme analyst|economic analysis|analyste master data|master data finance analyst|data-analyst|data & pricing analyst|senior analyst') THEN 'data analyst'
        WHEN REGEXP_CONTAINS(job_title_min, 'business analyst| bi analyst| business intelligence analyst|business performance analyst') THEN 'business analyst'
        WHEN REGEXP_CONTAINS(job_title_min, 'engineer|ingenieur') THEN 'engineer'
        WHEN REGEXP_CONTAINS(job_title_min, 'developpeur') THEN 'developpeur'
        ELSE 'others'
    END as job_title_category
FROM title_cleaning
)


SELECT job_title_category,
    COUNT (job_title_category) AS title_count
From title_cat
GROUP BY job_title_category

/*
SELECT job_title,
    COUNT (job_title) AS title_count
From title_cat
WHERE job_title_category='others'
GROUP BY job_title
ORDER BY COUNT (job_title) DESC*/
