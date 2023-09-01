SELECT 
    company, 
    localisation,
    posted_date, 
    whole_desc, 
    whole_cat, 
    job_title, 
    {{ func_replace('job_title') }} as job_title_min
FROM 
    {{ref("cl_indeed_wholecat_wlin")}}

