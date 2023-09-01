SELECT
    *,
    case
        -- ----- priority 1 : title is null -----------------------
        when
            contract_type_title is null
            and contract_type_cat is not null
        then contract_type_cat
        when
            contract_type_title is null
            and contract_type_desc is not null
        then contract_type_desc
        -- ----- priority 2 : category is null -------------------- 
        when
            contract_type_cat is null
            and contract_type_title is not null
        then contract_type_title
        when
            contract_type_cat is null
            and contract_type_desc is not null
        then contract_type_desc
        -- ----- priority 3 : description is null -----------------
        when
            contract_type_desc is null
            and contract_type_title is not null
        then contract_type_title
        when
            contract_type_desc is null
            and contract_type_cat is not null
        then contract_type_cat
        -- ----- if all of them are not null ----------------------
        -- title is not null 
        when
            contract_type_title is not null
            and (
                contract_type_title != contract_type_cat
                or contract_type_title != contract_type_desc
            )
        then contract_type_title
        -- cat is not null ---------------------
        when
            contract_type_cat is not null
            and contract_type_cat != contract_type_desc
        then contract_type_cat
        when
            contract_type_cat is null
            and contract_type_title is null
            and contract_type_desc is null
        then 'CDI'
        else contract_type_desc
    end as contract_type
FROM {{ref("cl_indeed_segcontract")}}