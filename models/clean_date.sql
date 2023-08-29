WITH stg_indeed_full AS (SELECT * FROM {{ ref ('stg_indeed_full')}} ),

date_split AS(
SELECT
  *,
  SPLIT(posted_date,"\n")[SAFE_OFFSET(1)] AS new_date,
#  if (REGEXP_CONTAINS(LOWER(posted_date),"employer actif"),1,0) as is_urgent
FROM stg_indeed_full
)

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

SELECT
  job_title,
  company,
  localisation,
  posted_date
  whole_desc,
  cat1,
  cat2,
  cat3,
  cat4,
  cat5,
  cat6,
  cat7,
  cat8,
  cat9,
  cat10,
  cat11,
  DATE_ADD("2023-08-28", INTERVAL CAST(nb_jours AS INT64) DAY) AS posted_date_clean
FROM get_days