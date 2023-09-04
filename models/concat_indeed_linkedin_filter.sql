SELECT *
FROM {{ ref("concat_indeed_linkedin") }}
WHERE
    job_title_category='data analyst'
    OR job_title_category = 'business analyst'
    OR job_title_category = 'bi specialist'