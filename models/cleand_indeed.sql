with
    seg_contract_type as (
        select
            job_title,
            company,
            localisation,
            posted_date,
            whole_desc,
            whole_cat,
            -- --------- segment from whole_cat ---------
            case
                when regexp_contains(lower(whole_cat), 'cdi')
                then "CDI"
                when regexp_contains(lower(whole_cat), 'cdd')
                then "CDD"
                when regexp_contains(lower(whole_cat), 'consultant')
                then "Consultant"
                when
                    regexp_contains(lower(whole_cat), 'stage')
                    or regexp_contains(lower(whole_cat), 'alternance')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(whole_cat), 'intérim')
                    or regexp_contains(lower(whole_cat), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(whole_cat), 'independent')
                    or regexp_contains(lower(whole_cat), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type_from_cat,
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
            end as contract_type_from_title
        from teamprojectdamarket.dbt_sheng999.stg_indeed
    )

select
    job_title,
    company,
    localisation,
    posted_date,
    whole_desc,
    whole_cat,
    contract_type_from_title,
    contract_type_from_cat,
    ------------- find the unique contract type --------------
    case
        when contract_type_from_cat is null and contract_type_from_title is not null then contract_type_from_title
        when contract_type_from_title is null and contract_type_from_cat is not null then contract_type_from_cat
        when
            contract_type_from_title is not null
            and contract_type_from_title != contract_type_from_cat
        then contract_type_from_title
        else contract_type_from_cat
    end as contract_type
from seg_contract_type
