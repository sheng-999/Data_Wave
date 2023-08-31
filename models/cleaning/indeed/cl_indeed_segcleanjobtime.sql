SELECT
    *,
    -- add a job type column like in LinkedIn- -  -
    CASE
        WHEN regexp_contains(whole_cat,"Temps plein") THEN "Temps plein"
        WHEN regexp_contains(whole_cat,"Temps partiel") THEN "Temps partiel"
        ELSE NULL
    END AS job_type
    
FROM {{ref("cl_indeed_segjobtitlecat_wlin")}}