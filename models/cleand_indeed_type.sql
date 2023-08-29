select
    job_title,
    company,
    localisation,
    posted_date,
    whole_desc,
    ----------- segment from whole_cat ---------
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
    ------------ segment cat from job title -----------------
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
    end as contract_type_from_desc
from teamprojectdamarket.dbt_sheng999.stg_indeed
