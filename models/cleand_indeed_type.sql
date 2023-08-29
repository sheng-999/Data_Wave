select
    job_title,
    company,
    localisation,
    posted_date,
    whole_desc,
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
    case
        when regexp_contains(lower(whole_desc), 'cdi')
        then "CDI"
        when regexp_contains(lower(whole_desc), 'cdd')
        then "CDD"
        when regexp_contains(lower(whole_desc), 'consultant')
        then "Consultant"
        when
            regexp_contains(lower(whole_desc), 'stage')
            or regexp_contains(lower(whole_desc), 'alternance')
        then "Stage & Alternance"
        when
            regexp_contains(lower(whole_desc), 'intérim')
            or regexp_contains(lower(whole_desc), 'interim')
        then "Intérim"
        when
            regexp_contains(lower(whole_desc), 'independent')
            or regexp_contains(lower(whole_desc), 'freelance')
        then 'Independent & Freelance'
        else null
    end as contract_type_from_desc
from teamprojectdamarket.dbt_sheng999.stg_indeed
