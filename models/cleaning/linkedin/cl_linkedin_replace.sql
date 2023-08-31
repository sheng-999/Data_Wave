SELECT 
    *,
    REPLACE(REPLACE(REPLACE(LOWER(job_title), 'é', 'e'), 'è', 'e'), '(h/f)', '') as job_title_min
FROM 
    {{ref("stg_linkedin")}}