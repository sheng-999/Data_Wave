with stg_linkedin as (select * from {{ ref("stg_linkedin") }})

, seg_contract_type as (
        select
            *,
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
            -- ---- segment from job_type ----------
            case
                when
                    regexp_contains(lower(type), 'cdi')
                    or regexp_contains(lower(type), 'temps plein')
                then "CDI"
                when regexp_contains(lower(type), 'cdd')
                then "CDD"
                when regexp_contains(lower(type), 'consultant')
                then "Consultant"
                when
                    regexp_contains(lower(type), 'stage')
                    or regexp_contains(lower(type), 'alternance')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(type), 'intérim')
                    or regexp_contains(lower(type), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(type), 'independent')
                    or regexp_contains(lower(type), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type_from_type,
            -- -------  segment from whole_desc -------------
            case
                when regexp_contains(lower(whole_desc), 'cdi')
                then 'CDI'
                when regexp_contains(lower(whole_desc), 'cdd')
                then 'CDD'
                when regexp_contains(lower(whole_desc), 'consultant')
                then "Consultant"
                when
                    regexp_contains(lower(whole_desc), 'stage')
                    or regexp_contains(lower(whole_desc), 'alternance')
                then 'Stage & Alternance'
                when
                    regexp_contains(lower(whole_desc), 'intérim')
                    or regexp_contains(lower(whole_desc), 'interim')
                then 'Intérim'
                when
                    regexp_contains(lower(whole_desc), 'independent')
                    or regexp_contains(lower(whole_desc), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type_from_desc,
            ----- different work type base segment  ---- 
            case 
            ----- step 1 teletravail Y/N segment from title ----
            when regexp_contains(lower(job_title), '.*online.*') 
            or regexp_contains((job_title), '.*remote.*') 
            or regexp_contains(lower(job_title), '.*en ligne.*')
            or regexp_contains(lower(job_title), '.*a distance.*') 
            or regexp_contains(lower(job_title), '.*à distance.*')
            then 'Remote'
            when 
            regexp_contains(lower(job_title), '.*hybride.*') 
            or regexp_contains((job_title), '.*teletravail.*') 
            or regexp_contains(lower(job_title), '.*télétravail.*')
            then 'Hybride'
            when 
            regexp_contains(lower(job_title), '.*sur site.*') 
            or regexp_contains((job_title), '.*on site.*') 
            then 'Onsite'
            else null
        end as work_type_from_title,
        ---- step 2 teletravail Y/N segment from location ----
        case 
            when regexp_contains(lower(job_location), '.*online.*') 
            or regexp_contains((job_location), '.*remote.*') 
            or regexp_contains(lower(job_location), '.*en ligne.*')
            or regexp_contains(lower(job_location), '.*a distance.*') 
            or regexp_contains(lower(job_location), '.*à distance.*')
            or regexp_contains(lower(job_location), '.*eu.*')
            or regexp_contains(lower(job_location), '.*us.*')
            or regexp_contains(lower(job_location), '.*uk.*')
            or regexp_contains(lower(job_location), '.*london.*')
            or regexp_contains(lower(job_location), '.*londres.*')
            then 'Remote'
            when 
            regexp_contains(lower(job_location), '.*hybride.*') 
            or regexp_contains((job_location), '.*teletravail.*') 
            or regexp_contains(lower(job_location), '.*télétravail.*')
            then 'Hybride'
            when 
            regexp_contains(lower(job_location), '.*sur site.*') 
            or regexp_contains((job_location), '.*on site.*') 
            then 'Onsite'
            else null
        end as work_type_from_location,
        ---- step  3 teletravail Y/N segment from type ----
        case 
            when regexp_contains(lower(type), '.*online.*') 
            or regexp_contains((type), '.*remote.*') 
            or regexp_contains(lower(type), '.*en ligne.*')
            or regexp_contains(lower(type), '.*a distance.*') 
            or regexp_contains(lower(type), '.*à distance.*')
            then 'Remote'
            when 
            regexp_contains(lower(type), '.*hybride.*') 
            or regexp_contains((type), '.*teletravail.*') 
            or regexp_contains(lower(type), '.*télétravail.*')
            then 'Hybride'
            when 
            regexp_contains(lower(type), '.*sur site.*') 
            or regexp_contains((type), '.*on site.*') 
            then 'Onsite'
            else null
        end as work_type_from_type,
        ---- step 4 teletravail Y/N segment from desc ----
        case 
            when regexp_contains(lower(whole_desc), '.*online.*') 
            or regexp_contains((whole_desc), '.*remote.*') 
            or regexp_contains(lower(whole_desc), '.*en ligne.*')
            or regexp_contains(lower(whole_desc), '.*a distance.*') 
            or regexp_contains(lower(whole_desc), '.*à distance.*')
            then 'Remote'
            when 
            regexp_contains(lower(whole_desc), '.*hybride.*') 
            or regexp_contains((whole_desc), '.*teletravail.*') 
            or regexp_contains(lower(whole_desc), '.*télétravail.*')
            then 'Hybride'
            when 
            regexp_contains(lower(whole_desc), '.*sur site.*') 
            or regexp_contains((whole_desc), '.*on site.*') 
            then 'Onsite'
            else null
        end as work_type_from_desc 
        from stg_linkedin
    )

, seg_contract_type_clean AS(
select
    *,
    case
        -- ----- priority 1 : title is null -----------------------
        when contract_type_from_title is null and contract_type_from_desc is not null
        then contract_type_from_desc
        when contract_type_from_title is null and contract_type_from_type is not null
        then contract_type_from_type
        -- ----- priority 2 : description is null -----------------
        when contract_type_from_desc is null and contract_type_from_title is not null
        then contract_type_from_title
        when contract_type_from_desc is null and contract_type_from_type is not null
        then contract_type_from_type
        -- ----- priority 3 :  type is null --------------------
        when contract_type_from_type is null and contract_type_from_title is not null
        then contract_type_from_title
        when contract_type_from_type is null and contract_type_from_desc is not null
        then contract_type_from_desc
        -- ----- if all of them are not null ----------------------
        -- title is not null
        when
            contract_type_from_title is not null
            and (
                contract_type_from_title != contract_type_from_type
                or contract_type_from_title != contract_type_from_desc
            )
        then contract_type_from_title
        -- desc is not null ---------------------
        when
            contract_type_from_desc is not null
            and contract_type_from_type != contract_type_from_desc
        then contract_type_from_desc
        -- all are null, so classify as "others"
        when
            contract_type_from_type is null
            and contract_type_from_title is null
            and contract_type_from_desc is null
        then 'CDI'
        else contract_type_from_type
    end as contract_type,
    ---------- work type segment -------------
    case 
        --- priority:  title > location > type > desc -------
        --- 1: title is not null ----
        when work_type_from_title is not null
        then work_type_from_title
        --- 2: if title is null ----
        when work_type_from_title is null 
        and work_type_from_location is not null 
        then work_type_from_location
        --- 3: if title & location is null ----
        when work_type_from_title is null 
        and work_type_from_location is null
        and work_type_from_type is not null
        then work_type_from_type
        --- 4: if title, location, type are null ---
        when work_type_from_title is null
        and work_type_from_type is null
        and work_type_from_location is null
        and work_type_from_desc is not null
        then work_type_from_desc
       ---- 5: all of them are not null ----
        when work_type_from_title is not null
        and work_type_from_type is not null
        and work_type_from_location is not null
        and work_type_from_desc is not null 
        then work_type_from_title
    ---- 6 : all of them are null ----
        when work_type_from_title is null
        and work_type_from_type is null
        and work_type_from_location is null
        and work_type_from_desc is null 
        then 'Onsite'
    else 'Not defined'
    end as work_type
from seg_contract_type
)

--- job title clean without accent and lower ---
, title_cleaning AS (
SELECT
*,
REPLACE(REPLACE(REPLACE(LOWER(job_title), 'é', 'e'), 'è', 'e'), '(h/f)', '') as job_title_min,
FROM seg_contract_type_clean
)
, cleaned_title_cat AS (
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
FROM title_cleaning
)
-- output ------------- 
  SELECT
    info_source,
    job_title,
    job_company AS company,
    job_location AS location,
    posted_date,
    function AS job_function,
    job_salary AS salary,
    type AS job_type,
    hierarchy,
    sector,
    whole_desc,
    contract_type,
    work_type
FROM cleaned_title_cat
