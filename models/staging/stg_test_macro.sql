SELECT
    *,
    {{ func_location('job_location') }}
FROM 
    {{ref("stg_linkedin")}}

