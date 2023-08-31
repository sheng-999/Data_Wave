SELECT
    *,
    {{ func_contract('whole_cat') }} as contract_type_cat,
    {{ func_contract('job_title') }} as contract_type_title,
    {{ func_contract('whole_desc') }} as contract_type_desc
FROM 
    {{ref("cl_indeed_replace_wlin")}}

