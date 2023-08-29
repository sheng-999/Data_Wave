WITH job_min AS (
    SELECT 
        *,
        REPLACE(REPLACE(LOWER(job_title), 'é', 'e'), 'è', 'e') as job_title_min
    FROM teamprojectdamarket.raw_data.indeed_job_date_complete)

SELECT
    *,
    CASE 
        WHEN REGEXP_CONTAINS(job_title_min, 'data analyst|analyste data|analyste de donnees h/f|analyste de donnees techniques (h/f)|analyste des donnees f/h|data integrity analyst h/f, st priest|data quality analyst|data-analyst h/f|alternant analyste de donnees (h/f)|data quality analyst - h/f|data quality analyste informatique h/f (it) / freelance|analyste base de donnees (h/f)|analyste de donnees en ligne - france|data quality analyst h/f|apprenti(e) analyste de donnees et support au pilotage|programme analyst – economic analysis – data integration department|analyste de donnees techniques h/f|analyste donnees|analyste des donnees f/h|analyste de donnees (performance commerciale) en alternance (f/h/x)|analyste de donnees comptables h/f|stage - data quality analyst f/h|analyste donnees (h/f)|un.e ingenieur.e analyste des donnees eau et assainissement|data quality analyst (crm) - paris - f/h/x - internship|alternant - analyste master data h/f|data quality analyst (h/f)|data quality analyst|data-analyst - h/f|data & pricing analyst h/f|data quality analyst - stage|analyste de donnees pour les etudes de marche aviation commerciale f/h|analyste de donnees f-h') THEN 'data analyst'
        WHEN REGEXP_CONTAINS(job_title_min, 'business analyst|groupm | alternance business intelligence analyst f/h|business performance analyst') THEN 'business analyst'
        ELSE 'others'
    END as job_title_cleaned
FROM job_min











