SELECT
    *,
    {{ func_contract('job_title') }} as contract_type_title,
    {{ func_contract('whole_desc') }} as contract_type_desc,
    {{ func_contract('type') }} as contract_type_type
FROM 
    {{ref("cl_linkedin_seg_jobtitle")}}