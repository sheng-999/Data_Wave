SELECT 
    job_title,
    job_title_min, 
    company, 
    localisation,
    posted_date, 
    whole_desc, 
    whole_cat, 
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
    end as contract_type_from_cat 
FROM 
    {{ref("cl_indeed_replace_wlin")}}