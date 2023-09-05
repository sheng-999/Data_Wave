SELECT 
cil.*,
ssf.sub_sector
FROM {{ ref("concat_indeed_linkedin") }} as cil
left join teamprojectdamarket.raw_data_annexe.sub_sector_filter as ssf 
on cil.sector = ssf.sector
WHERE   
    job_title_category='data analyst'
    OR job_title_category = 'business analyst'
    OR job_title_category = 'bi specialist'
    