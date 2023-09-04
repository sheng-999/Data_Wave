SELECT
  REPLACE(REPLACE(departement,"saint","st")," dor"," d or") AS departement,
  {{ func_location('prefecture') }} AS prefecture
FROM teamprojectdamarket.raw_data_annexe.localisation
GROUP BY departement,prefecture
ORDER BY departement