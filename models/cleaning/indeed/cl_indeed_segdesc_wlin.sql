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
FROM {{ref("cl_indeed_segjobtitle_wlin")}}