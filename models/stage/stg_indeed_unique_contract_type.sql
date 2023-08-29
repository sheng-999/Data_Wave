select 
job_title, 
company, 
localisation, 
posted_date, 
whole_desc,
contract_type_from_cat,
contract_type_from_desc
from teamprojectdamarket.dbt_sheng999.cleand_indeed_type
where contract_type_from_cat != contract_type_from_desc