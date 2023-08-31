SELECT
    job_title,
    {{ func_replace('job_title') }} as transformed
FROM 
    {{ref("cl_indeed_wholecat_wlin")}}