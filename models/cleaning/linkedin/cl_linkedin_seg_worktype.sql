SELECT
    *,
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
        regexp_contains(lower(job_location), '.*online.*') 
        OR regexp_contains((job_location), '.*remote.*') 
        OR regexp_contains(lower(job_location), '.*en ligne.*')
        OR regexp_contains(lower(job_location), '.*a distance.*') 
        OR regexp_contains(lower(job_location), '.*à distance.*')
        OR regexp_contains(lower(job_location), '.*eu.*')
        OR regexp_contains(lower(job_location), '.*us.*')
        OR regexp_contains(lower(job_location), '.*uk.*')
        OR regexp_contains(lower(job_location), '.*london.*')
        OR regexp_contains(lower(job_location), '.*londres.*')
    THEN 'Remote'
    WHEN
        regexp_contains(lower(job_location), '.*hybride.*') 
        OR regexp_contains((job_location), '.*teletravail.*') 
        OR regexp_contains(lower(job_location), '.*télétravail.*')
    THEN 'Hybride'
    WHEN
        regexp_contains(lower(job_location), '.*sur site.*') 
        OR regexp_contains((job_location), '.*on site.*') 
    THEN 'Onsite'
    ELSE NULL
    END AS work_type_from_location,
---- step  3 teletravail Y/N segment from type ----
    CASE
    WHEN
        regexp_contains(lower(type), '.*online.*') 
        OR regexp_contains((type), '.*remote.*') 
        OR regexp_contains(lower(type), '.*en ligne.*')
        OR regexp_contains(lower(type), '.*a distance.*') 
        OR regexp_contains(lower(type), '.*à distance.*')
    THEN 'Remote'
    WHEN
        regexp_contains(lower(type), '.*hybride.*') 
        OR regexp_contains((type), '.*teletravail.*') 
        OR regexp_contains(lower(type), '.*télétravail.*')
    THEN 'Hybride'
    WHEN
            regexp_contains(lower(type), '.*sur site.*') 
        OR regexp_contains((type), '.*on site.*') 
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
    {{ref("cl_linkedin_def_contract")}}

