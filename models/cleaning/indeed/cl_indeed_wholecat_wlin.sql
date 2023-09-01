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
    ) as whole_cat,
from {{ ref ("stg_indeed")}}
