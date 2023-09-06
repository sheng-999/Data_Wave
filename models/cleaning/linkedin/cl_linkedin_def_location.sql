-- use of the macro function to clean the location and join referential tables to get department, region & geoloc------------ 

WITH cleaned_table AS (
SELECT
    *,
    {{ func_location('job_location') }} as clean_location
FROM
    {{ ref ("cl_linkedin_def_salary")}}
)

-- match the city with the city list
, match_city AS (
SELECT
    loc.*,
    ville
FROM 
    cleaned_table AS loc
LEFT JOIN {{ ref ("cleaned_localisation")}} AS city
ON loc.clean_location = city.ville
)

---- match location with departement name and use prefecture as the city
, match_department AS (
SELECT
    loc.*,
    prefecture
FROM 
    match_city AS loc
LEFT JOIN {{ ref ("cleaned_dpt_prefecture")}} AS dpt
ON loc.clean_location = dpt.departement
)

---- match the location with the region and name and use the chef lieu as the city
, match_region AS (
SELECT
    loc.*,
    chef_lieu
FROM 
    match_department AS loc
LEFT JOIN {{ ref ("cleaned_reg_chef_lieu")}} AS reg
ON loc.clean_location = reg.region
)

, find_location_city AS (
SELECT
    *,
    CASE
    WHEN ville IS NOT NULL THEN ville
    WHEN prefecture IS NOT NULL THEN prefecture
    WHEN chef_lieu IS NOT NULL THEN chef_lieu
    ELSE 'teletravail'
    END AS location_city
FROM match_region
)

SELECT
    loc.*,
    ref.latitude,
    ref.longitude,
    ref.departement,
    ref.region
FROM find_location_city AS loc
LEFT JOIN {{ ref ("cleaned_localisation")}} AS ref
ON loc.location_city = ref.ville