with
    distinct_values as (
        -- 1st check : select distinct values from raw concatenated table ----
        select distinct * from teamprojectdamarket.raw_data.linkedin_concatenated
    -- result : from 12k to 11.6k -----
    )

select
    min(_) as _,
    job_title,
    job_company,
    job_location,
    -- 2nd check: select only 1 value, group by title, company, location ---
    min(posted_date) as posted_date,
    min(job_salary) as job_salary,
    min(function) as function,
    min(type) as type,
    min(hierarchy) as hierarchy,
    min(sector) as sector,
    min(whole_desc) as whole_desc
-- result : from 11.6k to 10989 ----
from distinct_values
group by job_title, job_company, job_location
