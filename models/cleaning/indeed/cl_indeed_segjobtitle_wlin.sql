SELECT 
    job_title,
    job_title_min, 
    company, 
    localisation,
    posted_date, 
    whole_desc, 
    whole_cat,
    contract_type_from_cat,
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
FROM {{ref("cl_indeed_segwholecat_wlin")}}