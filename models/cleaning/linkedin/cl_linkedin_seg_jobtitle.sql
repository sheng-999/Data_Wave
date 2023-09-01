SELECT
    *,
    --- job title simplified in 3 categories ---
    CASE
        WHEN REGEXP_CONTAINS(job_title_min, 'data analyst|data analyste|analyste data|analyste de donnees|analyste donnees|analyste des donnees|data integrity analyst|data quality analyst|data quality analyste|analyste base de donnees|programme analyst|economic analysis|analyste master data|master data finance analyst|data-analyst|data & pricing analyst|senior analyst|media analyst|data manager|quantitative analyst|lead quality analyst') THEN 'data analyst'
        WHEN REGEXP_CONTAINS(job_title_min, 'business analyst| business performance analyst|responsable produit et business analyse') THEN 'business analyst'
        WHEN REGEXP_CONTAINS(job_title_min, 'bi analyst| business intelligence analyst|consultant power bi|consultant(e) business intelligence qlik|consultant bi|analyste decisionnel - business intelligence|consultante decisionnel - business intelligence|business intelligence analyst|expert(e) business intelligence|consultante decisionnel - business intelligence|consultant power bi|charge de power bi') THEN 'bi specialist'
        WHEN REGEXP_CONTAINS(job_title_min, 'engineer|ingenieur') THEN 'engineer'
        WHEN REGEXP_CONTAINS(job_title_min, 'developpeur|developer') THEN 'developer'
        ELSE 'others'
    END as job_title_category
FROM
    {{ ref ("cl_linkedin_replace")}}