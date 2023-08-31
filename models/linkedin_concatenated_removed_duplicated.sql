with removed as (
    with cleaned as (
        with distinct_values as (
            -- 1st check : select distinct values from raw concatenated table ----
            select distinct * from teamprojectdamarket.raw_data.linkedin_concatenated
            -- result : from 12k to 11.6k -----
        )
        select
            job_title,
            job_company,
            job_location,
            whole_desc,
            -- 2nd check: select only 1 value, group by title, company, location ---
            min(posted_date) as posted_date,
            min(job_salary) as job_salary,
            min(function) as function,
            min(type) as type,
            min(hierarchy) as hierarchy,
            min(sector) as sector
        -- result : from 11.6k to 11.3k ----
        from distinct_values
        group by job_title, job_company, job_location, whole_desc
    )
    select 
        job_title,
        job_company,
        job_location,
        whole_desc,
        posted_date,
        job_salary,
        function,
        type,
        hierarchy,
        sector,
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
    from cleaned
)
select 
    job_title,
    job_company,
    job_location,
    whole_desc,
    posted_date,
    job_salary,
    function,
    type,
    hierarchy,
    sector,
    work_type_from_title,
    work_type_from_location,
    work_type_from_type,
    work_type_from_desc,
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
from removed