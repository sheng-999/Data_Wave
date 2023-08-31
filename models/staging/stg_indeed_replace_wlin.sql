SELECT 
    company, 
    localisation,
    posted_date, 
    whole_desc, 
    whole_cat, 
    job_title, 
    replace(replace(lower(job_title), 'é', 'e'), 'è', 'e') as job_title_min 
FROM 
    {{ref("stg_indeed_wholecat_wlin")}}

