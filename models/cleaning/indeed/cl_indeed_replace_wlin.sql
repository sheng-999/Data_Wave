SELECT 
    *,
    {{ func_replace('job_title') }} as job_title_min
FROM 
    {{ref("cl_indeed_wholecat_wlin")}}

