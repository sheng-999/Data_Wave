SELECT
  REPLACE(region,"dazur","d azur") AS region,
  chef_lieu
FROM teamprojectdamarket.raw_data_annexe.localisation
GROUP BY region,chef_lieu
ORDER BY region