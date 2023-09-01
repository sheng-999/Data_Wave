SELECT
    *,
    {{ func_contract('whole_cat') }} as contrat_type_cat,
    {{ func_contract('job_title') }} as contrat_type_title,
    {{ func_contract('whole_desc') }} as contrat_type_desc
FROM 
    {{ref("cl_indeed_segposted_date")}}

