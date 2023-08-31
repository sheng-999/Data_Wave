    select
    -- ---- 3rd doublon check : ----
    distinct *,
    'Linkedin' as info_source
from teamprojectdamarket.dbt.linkedin_concatenated_removed_duplicated
