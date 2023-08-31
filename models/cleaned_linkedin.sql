with
    seg_contract_type as (
        select
            _,
            job_title,
            job_company,
            job_location,
            posted_date,
            job_salary,
            -- ----- rename function as job_function cause funtion is also a function
            -- in sql ----------
            function as job_funtion,
            type,
            hierarchy,
            sector,
            whole_desc,
            -- ---------- segment cat from job title -----------------
            case
                when regexp_contains(lower(job_title), 'cdi')
                then "CDI"
                when regexp_contains(lower(job_title), 'cdd')
                then "CDD"
                when regexp_contains(lower(job_title), 'consultant')
                then "Consultant"
                when
                    regexp_contains(lower(job_title), 'stage')
                    or regexp_contains(lower(job_title), 'alternance')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(job_title), 'intérim')
                    or regexp_contains(lower(job_title), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(job_title), 'independent')
                    or regexp_contains(lower(job_title), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type_from_title,
            -- ---- segment from job_type ----------
            case
                when
                    regexp_contains(lower(type), 'cdi')
                    or regexp_contains(lower(type), 'temps plein')
                then "CDI"
                when regexp_contains(lower(type), 'cdd')
                then "CDD"
                when regexp_contains(lower(type), 'consultant')
                then "Consultant"
                when
                    regexp_contains(lower(type), 'stage')
                    or regexp_contains(lower(type), 'alternance')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(type), 'intérim')
                    or regexp_contains(lower(type), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(type), 'independent')
                    or regexp_contains(lower(type), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type_from_type,
            -- -------  segment from whole_desc -------------
            case
                when regexp_contains(lower(whole_desc), 'cdi')
                then 'CDI'
                when regexp_contains(lower(whole_desc), 'cdd')
                then 'CDD'
                when regexp_contains(lower(whole_desc), 'consultant')
                then "Consultant"
                when
                    regexp_contains(lower(whole_desc), 'stage')
                    or regexp_contains(lower(whole_desc), 'alternance')
                then 'Stage & Alternance'
                when
                    regexp_contains(lower(whole_desc), 'intérim')
                    or regexp_contains(lower(whole_desc), 'interim')
                then 'Intérim'
                when
                    regexp_contains(lower(whole_desc), 'independent')
                    or regexp_contains(lower(whole_desc), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type_from_desc
        from `teamprojectdamarket.dbt_staging.stg_linkedin`
    )
select
    _,
    job_title,
    job_company,
    job_location,
    posted_date,
    job_salary,
    job_funtion,
    type as job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type_from_title,
    contract_type_from_type,
    contract_type_from_desc,
    case
        -- ----- priority 1 : title is null -----------------------
        when contract_type_from_title is null and contract_type_from_desc is not null
        then contract_type_from_desc
        when contract_type_from_title is null and contract_type_from_type is not null
        then contract_type_from_type
        -- ----- priority 2 : description is null -----------------
        when contract_type_from_desc is null and contract_type_from_title is not null
        then contract_type_from_title
        when contract_type_from_desc is null and contract_type_from_type is not null
        then contract_type_from_type
        -- ----- priority 3 :  type is null --------------------
        when contract_type_from_type is null and contract_type_from_title is not null
        then contract_type_from_title
        when contract_type_from_type is null and contract_type_from_desc is not null
        then contract_type_from_desc
        -- ----- if all of them are not null ----------------------
        -- title is not null
        when
            contract_type_from_title is not null
            and (
                contract_type_from_title != contract_type_from_type
                or contract_type_from_title != contract_type_from_desc
            )
        then contract_type_from_title
        -- desc is not null ---------------------
        when
            contract_type_from_desc is not null
            and contract_type_from_type != contract_type_from_desc
        then contract_type_from_desc
        -- all are null, so classify as "others"
        when
            contract_type_from_type is null
            and contract_type_from_title is null
            and contract_type_from_desc is null
        then 'CDI'
        else contract_type_from_type
    end as contract_type
from seg_contract_type
