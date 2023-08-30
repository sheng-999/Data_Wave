SELECT * FROM teamprojectdamarket.raw_data.linkedin_hybride_manager_fulltime_last_month
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_hybride_premier_emploi_fulltime_last_month
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_yvelines
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_remote_premier_emploi
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_aura
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_bourgogne
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_bretagnep1
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_bretagnep2
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_centre
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_grand_est
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_normandie
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_remote_others
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_remote_premier_emploi
UNION ALL
SELECT * FROM teamprojectdamarket.raw_data.linkedin_onsite_paris_premier_emploi
WHERE whole_desc is not null
