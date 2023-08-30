<<<<<<< HEAD
SELECT * FROM `teamprojectdamarket.raw_data.indeed_job_date_complete` 
=======
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
>>>>>>> 9c374b9f0ab831792792b0f97c2a6b26f36c2395
