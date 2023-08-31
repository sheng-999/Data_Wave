SELECT
    job_title,
    {{ func_replace('job_title') }} as job_title_min, 
    company, 
    localisation,
    posted_date, 
    whole_desc, 
    whole_cat,
    contract_type_from_cat,
    contract_type_from_title,
    contract_type_from_desc,
    case
        -- ----- priority 1 : title is null -----------------------
        when
            contract_type_from_title is null
            and contract_type_from_cat is not null
        then contract_type_from_cat
        when
            contract_type_from_title is null
            and contract_type_from_desc is not null
        then contract_type_from_desc
        -- ----- priority 2 : category is null -------------------- 
        when
            contract_type_from_cat is null
            and contract_type_from_title is not null
        then contract_type_from_title
        when
            contract_type_from_cat is null
            and contract_type_from_desc is not null
        then contract_type_from_desc
        -- ----- priority 3 : description is null -----------------
        when
            contract_type_from_desc is null
            and contract_type_from_title is not null
        then contract_type_from_title
        when
            contract_type_from_desc is null
            and contract_type_from_cat is not null
        then contract_type_from_cat
        -- ----- if all of them are not null ----------------------
        -- title is not null 
        when
            contract_type_from_title is not null
            and (
                contract_type_from_title != contract_type_from_cat
                or contract_type_from_title != contract_type_from_desc
            )
        then contract_type_from_title
        -- cat is not null ---------------------
        when
            contract_type_from_cat is not null
            and contract_type_from_cat != contract_type_from_desc
        then contract_type_from_cat
        when
            contract_type_from_cat is null
            and contract_type_from_title is null
            and contract_type_from_desc is null
        then 'CDI'
        else contract_type_from_desc
    end as contract_type
FROM {{ref("cl_indeed_segdesc_wlin")}}