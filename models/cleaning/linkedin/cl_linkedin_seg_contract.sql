SELECT
    *,
-- ---------- segment cat from job title -----------------
    CASE
        WHEN regexp_contains(lower(job_title), 'cdi')
        THEN "CDI"
        WHEN regexp_contains(lower(job_title), 'cdd')
        THEN "CDD"
        WHEN regexp_contains(lower(job_title), 'consultant')
        THEN "Consultant"
        WHEN 
            regexp_contains(lower(job_title), 'stage')
            OR regexp_contains(lower(job_title), 'alternance')
        THEN "Stage & Alternance"
        WHEN
            regexp_contains(lower(job_title), 'intérim')
            OR regexp_contains(lower(job_title), 'interim')
        THEN "Intérim"
        WHEN
            regexp_contains(lower(job_title), 'independent')
            OR regexp_contains(lower(job_title), 'freelance')
        THEN 'Independent & Freelance'
        ELSE NULL
        END AS contract_type_from_title,
------- segment from job_type ----------
    CASE
        WHEN
            regexp_contains(lower(type), 'cdi')
            OR regexp_contains(lower(type), 'temps plein')
        THEN "CDI"
        WHEN regexp_contains(lower(type), 'cdd')
        THEN "CDD"
        WHEN regexp_contains(lower(type), 'consultant')
        THEN "Consultant"
        WHEN
            regexp_contains(lower(type), 'stage')
            OR regexp_contains(lower(type), 'alternance')
        THEN "Stage & Alternance"
        WHEN
            regexp_contains(lower(type), 'intérim')
            OR regexp_contains(lower(type), 'interim')
        THEN "Intérim"
        WHEN
            regexp_contains(lower(type), 'independent')
            OR regexp_contains(lower(type), 'freelance')
        THEN 'Independent & Freelance'
        ELSE NULL
        END AS contract_type_from_type,
----------  segment from whole_desc -------------
    CASE
        WHEN regexp_contains(lower(whole_desc), 'cdi')
        THEN 'CDI'
        WHEN regexp_contains(lower(whole_desc), 'cdd')
        THEN 'CDD'
        WHEN regexp_contains(lower(whole_desc), 'consultant')
        THEN "Consultant"
        WHEN
            regexp_contains(lower(whole_desc), 'stage')
            OR regexp_contains(lower(whole_desc), 'alternance')
        THEN 'Stage & Alternance'
        WHEN
            regexp_contains(lower(whole_desc), 'intérim')
            OR regexp_contains(lower(whole_desc), 'interim')
        THEN 'Intérim'
        WHEN
            regexp_contains(lower(whole_desc), 'independent')
            OR regexp_contains(lower(whole_desc), 'freelance')
        THEN 'Independent & Freelance'
        ELSE NULL
        END AS contract_type_from_desc,
FROM 
    {{ref("cl_linkedin_seg_jobtitle")}}