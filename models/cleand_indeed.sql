with
    seg_contract_type as (
        select
            job_title,
            --- job title clean without accent and lower ---
            REPLACE(REPLACE(LOWER(job_title), 'é', 'e'), 'è', 'e') as job_title_min,
            company,
            localisation,
            posted_date,
            whole_desc,
            whole_cat,
            -- ---------- segment from whole_cat ---------
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
            -- ---------- segment cat from job title -----------------
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
        from teamprojectdamarket.dbt_sheng999.stg_indeed
    )

select
    job_title,
    job_title_min,
    --- job title simplified in 3 categories ---
    CASE 
        WHEN REGEXP_CONTAINS(job_title_min, 'data analyst|analyste data|analyste de donnees h/f|analyste de donnees techniques (h/f)|analyste des donnees f/h|data integrity analyst h/f, st priest|data quality analyst|data-analyst h/f|alternant analyste de donnees (h/f)|data quality analyst - h/f|data quality analyste informatique h/f (it) / freelance|analyste base de donnees (h/f)|analyste de donnees en ligne - france|data quality analyst h/f|apprenti(e) analyste de donnees et support au pilotage|programme analyst – economic analysis – data integration department|analyste de donnees techniques h/f|analyste donnees|analyste des donnees f/h|analyste de donnees (performance commerciale) en alternance (f/h/x)|analyste de donnees comptables h/f|stage - data quality analyst f/h|analyste donnees (h/f)|un.e ingenieur.e analyste des donnees eau et assainissement|data quality analyst (crm) - paris - f/h/x - internship|alternant - analyste master data h/f|data quality analyst (h/f)|data quality analyst|data-analyst - h/f|data & pricing analyst h/f|data quality analyst - stage|analyste de donnees pour les etudes de marche aviation commerciale f/h|analyste de donnees f-h') THEN 'data analyst'
        WHEN REGEXP_CONTAINS(job_title_min, 'business analyst|groupm | alternance business intelligence analyst f/h|business performance analyst') THEN 'business analyst'
        ELSE 'others'
    END as job_title_category,
    company,
    localisation,
    posted_date,
    whole_desc,
    whole_cat,
    contract_type_from_title,
    contract_type_from_cat,
    contract_type_from_desc,
    -- ----------- find the unique contract type --------------
    /* 
    priority : 
    title > category > description
    */
    case
        -- ----- priority 1 : title is null -----------------------
        when contract_type_from_title is null and contract_type_from_cat is not null
        then contract_type_from_cat
        when contract_type_from_title is null and contract_type_from_desc is not null
        then contract_type_from_desc
        -- ----- priority 2 : category is null -------------------- 
        when contract_type_from_cat is null and contract_type_from_title is not null
        then contract_type_from_title
        when contract_type_from_cat is null and contract_type_from_desc is not null
        then contract_type_from_desc
        -- ----- priority 3 : description is null -----------------
        when contract_type_from_desc is null and contract_type_from_title is not null
        then contract_type_from_title
        when contract_type_from_desc is null and contract_type_from_cat is not null
        then contract_type_from_cat
        -- ----- if all of them are not null ----------------------
        -- title is not null 
        when
            contract_type_from_title is not null
            and (
                contract_type_from_title != contract_type_from_cat
                or contract_type_from_title != contract_type_from_desc
            )
        then contract_type_from_title
        -- cat is not null ---------------------
        when
            contract_type_from_cat is not null
            and contract_type_from_cat != contract_type_from_desc
        then contract_type_from_cat
        else contract_type_from_desc
    end as contract_type
from seg_contract_type
