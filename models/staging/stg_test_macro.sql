SELECT
    job_title,
    {{ func_replace('job_title') }} as transformed
FROM 
    {{ref("stg_indeed_wholecat_wlin")}}