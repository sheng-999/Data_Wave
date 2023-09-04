with
    stg_indeed as (select * from {{ ref("stg_indeed") }})

    , seg_contract_type as (
        select
            *,
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
                    or regexp_contains(lower(whole_cat), 'apprentissage')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(whole_cat), 'intérim')
                    or regexp_contains(lower(whole_cat), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(whole_cat), 'independent')
                    or regexp_contains(lower(whole_cat), 'indépendant')
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
                    or regexp_contains(lower(job_title), 'apprentissage')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(job_title), 'intérim')
                    or regexp_contains(lower(job_title), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(job_title), 'independent')
                    or regexp_contains(lower(job_title), 'indépendent')
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
                    or regexp_contains(lower(whole_desc), 'apprentissage')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(whole_desc), 'intérim')
                    or regexp_contains(lower(whole_desc), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(whole_desc), 'independent')
                    or regexp_contains(lower(whole_desc), 'indépendent')
                    or regexp_contains(lower(whole_desc), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type_from_desc,
            ---------- work type segment --------------
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
            when regexp_contains(lower(localisation), '.*online.*') 
            or regexp_contains((localisation), '.*remote.*') 
            or regexp_contains(lower(localisation), '.*en ligne.*')
            or regexp_contains(lower(localisation), '.*a distance.*') 
            or regexp_contains(lower(localisation), '.*à distance.*')
            or regexp_contains(lower(localisation), '.*eu.*')
            or regexp_contains(lower(localisation), '.*us.*')
            or regexp_contains(lower(localisation), '.*uk.*')
            or regexp_contains(lower(localisation), '.*london.*')
            or regexp_contains(lower(localisation), '.*londres.*')
            then 'Remote'
            when 
            regexp_contains(lower(localisation), '.*hybride.*') 
            or regexp_contains((localisation), '.*teletravail.*') 
            or regexp_contains(lower(localisation), '.*télétravail.*')
            then 'Hybride'
            when 
            regexp_contains(lower(localisation), '.*sur site.*') 
            or regexp_contains((localisation), '.*on site.*') 
            then 'Onsite'
            else null
        end as work_type_from_location,
        ---- step  3 teletravail Y/N segment from whole_cat ----
        case 
            when regexp_contains(lower(whole_cat), '.*online.*') 
            or regexp_contains((whole_cat), '.*remote.*') 
            or regexp_contains(lower(whole_cat), '.*en ligne.*')
            or regexp_contains(lower(whole_cat), '.*a distance.*') 
            or regexp_contains(lower(whole_cat), '.*à distance.*')
            then 'Remote'
            when 
            regexp_contains(lower(whole_cat), '.*hybride.*') 
            or regexp_contains((whole_cat), '.*teletravail.*') 
            or regexp_contains(lower(whole_cat), '.*télétravail.*')
            then 'Hybride'
            when 
            regexp_contains(lower(whole_cat), '.*sur site.*') 
            or regexp_contains((whole_cat), '.*on site.*') 
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
        from stg_indeed
    )
    , cleaned_contract_type as (
        select
            *,
            -- ----------- find the unique contract type --------------
            /* 
    priority : 
    title > category > description
    */
            case
                -- ----- priority 1 : title is null -----------------------
                when
                    contract_type_from_title is null
                    and contract_type_from_cat is not null
                then contract_type_from_cat
                when
                    contract_type_from_title is null
                    and contract_type_from_desc is not null
                then contract_type_from_desc
                -- ----- priority 2 : category is null -------------------- 
                when
                    contract_type_from_cat is null
                    and contract_type_from_title is not null
                then contract_type_from_title
                when
                    contract_type_from_cat is null
                    and contract_type_from_desc is not null
                then contract_type_from_desc
                -- ----- priority 3 : description is null -----------------
                when
                    contract_type_from_desc is null
                    and contract_type_from_title is not null
                then contract_type_from_title
                when
                    contract_type_from_desc is null
                    and contract_type_from_cat is not null
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
                when
                    contract_type_from_cat is null
                    and contract_type_from_title is null
                    and contract_type_from_desc is null
                then 'CDI'
                else contract_type_from_desc
            end as contract_type,
        ------ work type definition -----------
            case 
        --- priority:  title > location > whole cat >  whole desc -------
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
    , indeed_salary_extract as (
        select
            *,
            case
                when
                    regexp_contains(
                        whole_cat,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9][0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_cat,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9][0-9] [0-9][0-9][0-9] €"
                    )
                when
                    regexp_contains(
                        whole_cat,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_cat,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9] [0-9][0-9][0-9] €"
                    )
                when
                    regexp_contains(
                        whole_cat, "[0-9] [0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_cat, "[0-9] [0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                when
                    regexp_contains(
                        whole_cat, "[0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_cat, "[0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                when regexp_contains(whole_cat, "[0-9][0-9][0-9] € à [0-9][0-9][0-9] €")
                then regexp_extract(whole_cat, "[0-9][0-9][0-9] € à [0-9][0-9][0-9] €")
                when regexp_contains(whole_cat, "[0-9][0-9] [0-9][0-9][0-9] €")
                then regexp_extract(whole_cat, "[0-9][0-9] [0-9][0-9][0-9] €")
                when regexp_contains(whole_cat, "[0-9] [0-9][0-9][0-9] €")
                then regexp_extract(whole_cat, "[0-9] [0-9][0-9][0-9] €")
                when regexp_contains(whole_cat, "[0-9][0-9][0-9] €")
                then regexp_extract(whole_cat, "[0-9][0-9][0-9] €")
                when regexp_contains(whole_cat, "[0-9][0-9],[0-9][0-9] €")
                then regexp_extract(whole_cat, "[0-9][0-9],[0-9][0-9] €")
            end as salaire_1,
            case
                when
                    regexp_contains(
                        whole_desc,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9][0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_desc,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9][0-9] [0-9][0-9][0-9] €"
                    )
                when
                    regexp_contains(
                        whole_desc,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_desc,
                        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9] [0-9][0-9][0-9] €"
                    )
                when
                    regexp_contains(
                        whole_desc, "[0-9] [0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_desc, "[0-9] [0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                when
                    regexp_contains(
                        whole_desc, "[0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                then
                    regexp_extract(
                        whole_desc, "[0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
                    )
                when
                    regexp_contains(whole_desc, "[0-9][0-9][0-9] € à [0-9][0-9][0-9] €")
                then regexp_extract(whole_desc, "[0-9][0-9][0-9] € à [0-9][0-9][0-9] €")
                when regexp_contains(whole_desc, "[0-9][0-9] [0-9][0-9][0-9] €")
                then regexp_extract(whole_desc, "[0-9][0-9] [0-9][0-9][0-9] €")
                when regexp_contains(whole_desc, "[0-9][0-9][0-9][0-9][0-9] €")
                then regexp_extract(whole_desc, "[0-9][0-9][0-9][0-9][0-9] €")
                when regexp_contains(whole_desc, "[0-9] [0-9][0-9][0-9] €")
                then regexp_extract(whole_desc, "[0-9] [0-9][0-9][0-9] €")
                when regexp_contains(whole_desc, "[0-9][0-9][0-9] €")
                then regexp_extract(whole_desc, "[0-9][0-9][0-9] €")
                when regexp_contains(whole_desc, "[0-9][0-9],[0-9][0-9] €")
                then regexp_extract(whole_desc, "[0-9][0-9],[0-9][0-9] €")
                when regexp_contains(whole_desc, "[0-9][0-9]k€[^A-Za-z0-9][0-9][0-9]k€")
                then regexp_extract(whole_desc, "[0-9][0-9]k€[^A-Za-z0-9][0-9][0-9]k€")
                when
                    regexp_contains(
                        whole_desc, "[0-9][0-9]k€ [^A-Za-z0-9] [0-9][0-9]k€"
                    )
                then
                    regexp_extract(whole_desc, "[0-9][0-9]k€ [^A-Za-z0-9] [0-9][0-9]k€")
                when regexp_contains(whole_desc, "[0-9][0-9][^A-Za-z0-9][0-9][0-9]k€")
                then regexp_extract(whole_desc, "[0-9][0-9][^A-Za-z0-9][0-9][0-9]k€")
                when regexp_contains(whole_desc, "[0-9][0-9] [^A-Za-z0-9] [0-9][0-9]k€")
                then regexp_extract(whole_desc, "[0-9][0-9] [^A-Za-z0-9] [0-9][0-9]k€")
                when
                    regexp_contains(
                        whole_desc, "[0-9][0-9] [0-9][0-9][0-9],[0-9][0-9]€"
                    )
                then
                    regexp_extract(whole_desc, "[0-9][0-9] [0-9][0-9][0-9],[0-9][0-9]€")
                when
                    regexp_contains(whole_desc, "[0-9][0-9] [0-9][0-9][0-9],[0-9][0-9]")
                then regexp_extract(whole_desc, "[0-9][0-9] [0-9][0-9][0-9],[0-9][0-9]")
                when regexp_contains(whole_desc, "[0-9] [0-9][0-9][0-9],[0-9][0-9]€")
                then regexp_extract(whole_desc, "[0-9] [0-9][0-9][0-9],[0-9][0-9]€")
                when regexp_contains(whole_desc, "[0-9] [0-9][0-9][0-9],[0-9][0-9]")
                then regexp_extract(whole_desc, "[0-9] [0-9][0-9][0-9],[0-9][0-9]")
                when regexp_contains(whole_desc, "[0-9][0-9][0-9][0-9],[0-9][0-9]€")
                then regexp_extract(whole_desc, "[0-9][0-9][0-9][0-9],[0-9][0-9]€")
                when regexp_contains(whole_desc, "[0-9][0-9][0-9][0-9],[0-9][0-9]")
                then regexp_extract(whole_desc, "[0-9][0-9][0-9][0-9],[0-9][0-9]")
                when regexp_contains(whole_desc, "[0-9][0-9][0-9],[0-9][0-9]€")
                then regexp_extract(whole_desc, "[0-9][0-9][0-9],[0-9][0-9]€")
                when regexp_contains(whole_desc, "[0-9][0-9][0-9],[0-9][0-9]")
                then regexp_extract(whole_desc, "[0-9][0-9][0-9],[0-9][0-9]")
                when regexp_contains(whole_desc, "[0-9][0-9]k€")
                then regexp_extract(whole_desc, "[0-9][0-9]k€")
                when regexp_contains(whole_desc, "[0-9][0-9] k€")
                then regexp_extract(whole_desc, "[0-9][0-9] k€")
            end as salaire_2
        from cleaned_contract_type
    )
    , cleaned_salary as (
        select
            *,
            case
                when salaire_1 is not null
                then salaire_1
                when salaire_2 is not null
                then salaire_2
                else null
            end as salary
        from indeed_salary_extract
    )

    -- add a job type column like in LinkedIn
, cleaned_job_type AS (
SELECT
    *,
    CASE
        WHEN regexp_contains(whole_cat,"Temps plein") THEN "Temps plein"
        WHEN regexp_contains(whole_cat,"Temps partiel") THEN "Temps partiel"
        ELSE NULL
        END AS job_type
FROM cleaned_salary
)
    -- split the row posted_date wich has several rows inside and use only the second
    -- part
    , date_split as (
        select
            *,
            split(posted_date, "\n")[safe_offset(1)] as new_date,
        from cleaned_job_type
    )
    -- count the number of days from the posted information
    , get_days as (
        select
            *,
            case
                when lower(new_date) like "%employer actif"
                then "0"
                when lower(new_date) like "%à l'instant"
                then "0"
                when lower(new_date) like "%aujourd'hui"
                then "0"
                when lower(new_date) like "%il y a plus de%"
                then left(split(new_date, "il y a plus de ")[safe_offset(1)], 2)
                else left(split(new_date, "il y a ")[safe_offset(1)], 2)
            end as nb_jours
        from date_split
    )
    -- calculate the posted_date between to the extracted number of days and the
    -- scrapping date (28/08/2023)
    , cleaned_posted_date as (
        select
            *,
            date_add(
                "2023-08-28", interval cast(nb_jours as int64) day
            ) as posted_date_clean
        from get_days
    ),
    -- - job title clean without accent and lower ---
    title_cleaning as (
        select
            *,
            replace(replace(lower(job_title), 'é', 'e'), 'è', 'e') as job_title_min
        from cleaned_posted_date
    )

<<<<<<< HEAD
-- count the number of days from the posted information
, get_days AS (
SELECT
  *,
  CASE
    WHEN LOWER(new_date) like "%employer actif" THEN "0"
    WHEN LOWER(new_date) like "%à l'instant" THEN "0"
    WHEN LOWER(new_date) like "%aujourd'hui" THEN "0"
    WHEN LOWER(new_date) like "%il y a plus de%" THEN LEFT(SPLIT(new_date,"il y a plus de ")[SAFE_OFFSET(1)],2)
    ELSE LEFT(SPLIT(new_date,"il y a ")[SAFE_OFFSET(1)],2)
  END AS  nb_jours
FROM date_split
)

-- calculate the posted_date between to the extracted number of days and the scrapping date (28/08/2023)
, cleaned_posted_date AS (
SELECT
  job_title,
  company,
  localisation,
  whole_desc,
  contract_type,
  salary,
  DATE_ADD("2023-08-28", INTERVAL CAST(nb_jours AS INT64) DAY) AS posted_date_clean
FROM get_days
)

--- job title clean without accent and lower ---
, title_cleaning AS (
SELECT
*,
REPLACE(REPLACE(LOWER(job_title), 'é', 'e'), 'è', 'e') as job_title_min
FROM cleaned_posted_date
),

job_title_3 as (
SELECT
=======
------------- out put --------
select
    info_source,
>>>>>>> 67bb4767b26ea8f10864ef180397edea175864ad
    job_title,
    company,
    localisation  AS location,
    posted_date_clean AS posted_date,
    ' '  AS job_function,
    salary,
    job_type,
    " " AS hierarchy,
    " " AS sector,
    whole_desc,
    contract_type,
<<<<<<< HEAD
    posted_date_clean,
    salary,
    --- job title simplified in 3 categories ---
    CASE
        WHEN REGEXP_CONTAINS(job_title_min, 'data analyst|analyste data|analyste de donnees h/f|analyste de donnees techniques (h/f)|analyste des donnees f/h|data integrity analyst h/f, st priest|data quality analyst|data-analyst h/f|alternant analyste de donnees (h/f)|data quality analyst - h/f|data quality analyste informatique h/f (it) / freelance|analyste base de donnees (h/f)|analyste de donnees en ligne - france|data quality analyst h/f|apprenti(e) analyste de donnees et support au pilotage|programme analyst – economic analysis – data integration department|analyste de donnees techniques h/f|analyste donnees|analyste des donnees f/h|analyste de donnees (performance commerciale) en alternance (f/h/x)|analyste de donnees comptables h/f|stage - data quality analyst f/h|analyste donnees (h/f)|un.e ingenieur.e analyste des donnees eau et assainissement|data quality analyst (crm) - paris - f/h/x - internship|alternant - analyste master data h/f|data quality analyst (h/f)|data quality analyst|data-analyst - h/f|data & pricing analyst h/f|data quality analyst - stage|analyste de donnees pour les etudes de marche aviation commerciale f/h|analyste de donnees f-h') THEN 'data analyst'
        WHEN REGEXP_CONTAINS(job_title_min, 'business analyst|groupm | alternance business intelligence analyst f/h|business performance analyst') THEN 'business analyst'
        ELSE 'others'
    END as job_title_category
FROM title_cleaning
)
select 
job_title,
    company,
    localisation,
    whole_desc,
    contract_type,
    posted_date_clean,
    salary,
    job_title_category,
    REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE
(REPLACE (localisation, '0', ''),
'1', ''),
'2', ''),
'3', ''),
'4', ''),
'5', ''),
'6', ''),
'7', ''),
'8', ''),
'9', ''),
'1e', ''),
'2e', ''),
'3e', ''),
'4e', ''),
'5e', ''),
'6e', ''),
'7e', ''),
'8e', ''),
'9e', ''),
'10e', ''),
'11e', ''),
'12e', ''),
'13e', ''),
'14e', ''),
'15e', ''),
'16e', ''),
'17e', ''),
'18e', ''),
'19e', ''),
'20e', ''),
'(', ''),
')', ''),
" + location", ''),
")", ''),
"Télétravail à","") 
" et périphérie","")
", France","")
"Ville de ","")
as localisation_clean,
    FROM
job_title_3
=======
    work_type,
    
    -- - job title simplified in 3 categories ---
    case
        when
            regexp_contains(
                job_title_min,
                'data analyst|analyste data|analyste de donnees h/f|analyste de donnees techniques (h/f)|analyste des donnees f/h|data integrity analyst h/f, st priest|data quality analyst|data-analyst h/f|alternant analyste de donnees (h/f)|data quality analyst - h/f|data quality analyste informatique h/f (it) / freelance|analyste base de donnees (h/f)|analyste de donnees en ligne - france|data quality analyst h/f|apprenti(e) analyste de donnees et support au pilotage|programme analyst – economic analysis – data integration department|analyste de donnees techniques h/f|analyste donnees|analyste des donnees f/h|analyste de donnees (performance commerciale) en alternance (f/h/x)|analyste de donnees comptables h/f|stage - data quality analyst f/h|analyste donnees (h/f)|un.e ingenieur.e analyste des donnees eau et assainissement|data quality analyst (crm) - paris - f/h/x - internship|alternant - analyste master data h/f|data quality analyst (h/f)|data quality analyst|data-analyst - h/f|data & pricing analyst h/f|data quality analyst - stage|analyste de donnees pour les etudes de marche aviation commerciale f/h|analyste de donnees f-h'
            )
        then 'data analyst'
        when
            regexp_contains(
                job_title_min,
                'business analyst|groupm | alternance business intelligence analyst f/h|business performance analyst'
            )
        then 'business analyst'
        else 'others'
    end as job_title_category
from title_cleaning

>>>>>>> 67bb4767b26ea8f10864ef180397edea175864ad

