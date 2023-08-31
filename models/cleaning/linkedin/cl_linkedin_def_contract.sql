SELECT
    *,
    CASE
-- ----- priority 1 : title is null -----------------------
    WHEN contract_type_from_title IS NULL AND contract_type_from_desc IS NOT NULL
    THEN contract_type_from_desc
    WHEN contract_type_from_title IS NULL AND contract_type_from_type IS NOT NULL
    THEN contract_type_from_type
-- ----- priority 2 : description is null -----------------
    WHEN contract_type_from_desc IS NULL AND contract_type_from_title IS NOT NULL
    THEN contract_type_from_title
    WHEN contract_type_from_desc IS NULL AND contract_type_from_type IS NOT NULL
    THEN contract_type_from_type
-- ----- priority 3 :  type is null --------------------
    WHEN contract_type_from_type IS NULL AND contract_type_from_title IS NOT NULL
    THEN contract_type_from_title
    WHEN contract_type_from_type IS NULL AND contract_type_from_desc IS NOT NULL
    THEN contract_type_from_desc
        -- ----- if all of them are not null ----------------------
        -- title is not null
    WHEN
        contract_type_from_title IS NOT NULL
        AND (
            contract_type_from_title != contract_type_from_type
            OR contract_type_from_title != contract_type_from_desc
            )
    THEN contract_type_from_title
        -- desc is not null ---------------------
    WHEN
        contract_type_from_desc IS NOT NULL
        AND contract_type_from_type != contract_type_from_desc
    THEN contract_type_from_desc
        -- all are null, so classify as "others"
    WHEN
        contract_type_from_type IS NULL
        AND contract_type_from_title IS NULL
        AND contract_type_from_desc IS NULL
    THEN 'CDI'
    ELSE contract_type_from_type
    END AS contract_type
FROM
    {{ref("cl_linkedin_seg_contract")}}