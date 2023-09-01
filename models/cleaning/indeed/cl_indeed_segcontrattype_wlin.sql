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
    end as contract_type,
    ------ work type --------
     CASE 
--- priority:  title > location > type > desc -------
--- 1: title is not null ----
    WHEN work_type_from_title IS NOT NULL
    THEN work_type_from_title
--- 2: if title is null ----
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_location IS NOT NULL 
    THEN work_type_from_location
--- 3: if title & location is null ----
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_location IS NULL
        AND work_type_from_type IS NOT NULL
    THEN work_type_from_type
--- 4: if title, location, type are null ---
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_type IS NULL
        AND work_type_from_location IS NULL
        AND work_type_from_desc IS NOT NULL
    THEN work_type_from_desc
---- 5: all of them are not null ----
    WHEN
        work_type_from_title IS NOT NULL
        AND work_type_from_type IS NOT NULL
        AND work_type_from_location IS NOT NULL
        AND work_type_from_desc IS NOT NULL 
    THEN work_type_from_title
---- 6 : all of them are null ----
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_type IS NULL
        AND work_type_from_location IS NULL
        AND work_type_from_desc IS NULL 
    THEN 'Onsite'
    ELSE 'Not defined'
    END AS work_type
FROM {{ref("cl_indeed_segcontract")}}