SELECT
    *,
    {{ func_contract('whole_cat') }} as contract_type_cat,
    {{ func_contract('job_title') }} as contract_type_title,
    {{ func_contract('whole_desc') }} as contract_type_desc,
    ----- work type added --------
    CASE 
----- step 1 teletravail Y/N segment from title ----
    WHEN
        regexp_contains(lower(job_title), '.*online.*') 
        OR regexp_contains((job_title), '.*remote.*') 
        OR regexp_contains(lower(job_title), '.*en ligne.*')
        OR regexp_contains(lower(job_title), '.*a distance.*') 
        OR regexp_contains(lower(job_title), '.*à distance.*')
    THEN 'Remote'
    WHEN
        regexp_contains(lower(job_title), '.*hybride.*') 
        OR regexp_contains((job_title), '.*teletravail.*') 
        OR regexp_contains(lower(job_title), '.*télétravail.*')
    THEN 'Hybride'
    WHEN
        regexp_contains(lower(job_title), '.*sur site.*') 
        OR regexp_contains((job_title), '.*on site.*') 
    THEN 'Onsite'
    ELSE NULL
    END AS work_type_from_title,
---- step 2 teletravail Y/N segment from location ----
    CASE 
    WHEN
        regexp_contains(lower(localisation), '.*online.*') 
        OR regexp_contains((localisation), '.*remote.*') 
        OR regexp_contains(lower(localisation), '.*en ligne.*')
        OR regexp_contains(lower(localisation), '.*a distance.*') 
        OR regexp_contains(lower(localisation), '.*à distance.*')
        OR regexp_contains(lower(localisation), '.*eu.*')
        OR regexp_contains(lower(localisation), '.*us.*')
        OR regexp_contains(lower(localisation), '.*uk.*')
        OR regexp_contains(lower(localisation), '.*london.*')
        OR regexp_contains(lower(localisation), '.*londres.*')
    THEN 'Remote'
    WHEN
        regexp_contains(lower(localisation), '.*hybride.*') 
        OR regexp_contains((localisation), '.*teletravail.*') 
        OR regexp_contains(lower(localisation), '.*télétravail.*')
    THEN 'Hybride'
    WHEN
        regexp_contains(lower(localisation), '.*sur site.*') 
        OR regexp_contains((localisation), '.*on site.*') 
    THEN 'Onsite'
    ELSE NULL
    END AS work_type_from_location,
---- step  3 teletravail Y/N segment from type ----
    CASE
    WHEN
        regexp_contains(lower(whole_cat), '.*online.*') 
        OR regexp_contains((whole_cat), '.*remote.*') 
        OR regexp_contains(lower(whole_cat), '.*en ligne.*')
        OR regexp_contains(lower(whole_cat), '.*a distance.*') 
        OR regexp_contains(lower(whole_cat), '.*à distance.*')
    THEN 'Remote'
    WHEN
        regexp_contains(lower(whole_cat), '.*hybride.*') 
        OR regexp_contains((whole_cat), '.*teletravail.*') 
        OR regexp_contains(lower(whole_cat), '.*télétravail.*')
    THEN 'Hybride'
    WHEN
            regexp_contains(lower(whole_cat), '.*sur site.*') 
        OR regexp_contains((whole_cat), '.*on site.*') 
    THEN 'Onsite'
    ELSE NULL
    END AS work_type_from_type,
---- step 4 teletravail Y/N segment from desc ----
    CASE 
    WHEN
        regexp_contains(lower(whole_desc), '.*hybride.*') 
        OR regexp_contains((whole_desc), '.*teletravail.*') 
        OR regexp_contains(lower(whole_desc), '.*télétravail.*')
    THEN 'Hybride'
    WHEN
        regexp_contains(lower(whole_desc), '.*sur site.*') 
        OR regexp_contains((whole_desc), '.*on site.*') 
    THEN 'Onsite'
    ELSE NULL
    END AS work_type_from_desc 
FROM 
    {{ref("cl_indeed_replace_wlin")}}

