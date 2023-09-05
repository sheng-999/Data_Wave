 -- split the row posted_date wich has several rows inside and use only the second part
WITH date_split as (
        select
            *,
            split(posted_date, "\n")[safe_offset(1)] as new_date,
FROM {{ref("cl_indeed_segcleanjobtime")}}
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
        select
            *,
            date_add(
                "2023-08-28", interval -cast(nb_jours as int64) day
            ) as posted_date_clean
        from get_days