with
    whole as (
        select
            -- ----------- info from raw source -----------
            job_title,
            company,
            localisation,
            posted_date,
            whole_desc,
            -- --------- concat all cat -------------
            concat(
                ifnull(cat1, ''),
                ' - ',
                ifnull(cat2, ''),
                ' - ',
                ifnull(cat3, ''),
                ' - ',
                ifnull(cat4, ''),
                ' - ',
                ifnull(cat5, ''),
                ' - ',
                ifnull(cat6, ''),
                ' - ',
                ifnull(cat7, ''),
                ' - ',
                ifnull(cat8, ''),
                ' - ',
                ifnull(cat9, ''),
                ' - ',
                ifnull(cat10, ''),
                ' - ',
                ifnull(cat11, '')
            ) as whole_cat
        from `teamprojectdamarket.raw_data.indeed_job_date_complete`
    ),
    type_from_cat as (
        select
            whole.job_title,
            whole.company,
            whole.localisation,
            whole.posted_date,
            whole.whole_desc,
            case
                when regexp_contains(lower(whole.whole_cat), 'cdi')
                then "CDI"
                when regexp_contains(lower(whole.whole_cat), 'cdd')
                then "CDD"
                when regexp_contains(lower(whole.whole_cat), 'consultant')
                then "Consultant"
                when
                    regexp_contains(lower(whole.whole_cat), 'stage')
                    or regexp_contains(lower(whole.whole_cat), 'alternance')
                then "Stage & Alternance"
                when
                    regexp_contains(lower(whole.whole_cat), 'intérim')
                    or regexp_contains(lower(whole.whole_cat), 'interim')
                then "Intérim"
                when
                    regexp_contains(lower(whole.whole_cat), 'independent')
                    or regexp_contains(lower(whole.whole_cat), 'freelance')
                then 'Independent & Freelance'
                else null
            end as contract_type
        from whole
    )
select
    type_from_cat.job_title,
    type_from_cat.company,
    type_from_cat.localisation,
    type_from_cat.posted_date,
    type_from_cat.whole_desc,
    type_from_cat.contract_type,
    case
        when regexp_contains(lower(type_from_cat.whole_desc), 'cdi')
        then "CDI"
        when regexp_contains(lower(type_from_cat.whole_desc), 'cdd')
        then "CDD"
        when regexp_contains(lower(type_from_cat.whole_desc), 'consultant')
        then "Consultant"
        when
            regexp_contains(lower(type_from_cat.whole_desc), 'stage')
            or regexp_contains(lower(type_from_cat.whole_desc), 'alternance')
        then "Stage & Alternance"
        when
            regexp_contains(lower(type_from_cat.whole_desc), 'intérim')
            or regexp_contains(lower(type_from_cat.whole_desc), 'interim')
        then "Intérim"
        when
            regexp_contains(lower(type_from_cat.whole_desc), 'independent')
            or regexp_contains(lower(type_from_cat.whole_desc), 'freelance')
        then 'Independent & Freelance'
        else null
    end as contract_type_from_desc
from type_from_cat
