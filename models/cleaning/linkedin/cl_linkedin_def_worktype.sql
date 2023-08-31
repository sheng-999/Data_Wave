---------- work type segment -------------
SELECT
    *,
    CASE 
--- priority:  title > location > type > desc -------
--- 1: title is not null ----
    WHEN work_type_from_title IS NOT NULL
    THEN work_type_from_title
--- 2: if title is null ----
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_location IS NOT NULL 
    THEN work_type_from_location
--- 3: if title & location is null ----
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_location IS NULL
        AND work_type_from_type IS NOT NULL
    THEN work_type_from_type
--- 4: if title, location, type are null ---
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_type IS NULL
        AND work_type_from_location IS NULL
        AND work_type_from_desc IS NOT NULL
    THEN work_type_from_desc
---- 5: all of them are not null ----
    WHEN
        work_type_from_title IS NOT NULL
        AND work_type_from_type IS NOT NULL
        AND work_type_from_location IS NOT NULL
        AND work_type_from_desc IS NOT NULL 
    THEN work_type_from_title
---- 6 : all of them are null ----
    WHEN
        work_type_from_title IS NULL
        AND work_type_from_type IS NULL
        AND work_type_from_location IS NULL
        AND work_type_from_desc IS NULL 
    THEN 'Onsite'
    ELSE 'Not defined'
    END AS work_type
FROM
    {{ ref ("cl_linkedin_seg_worktype")}}