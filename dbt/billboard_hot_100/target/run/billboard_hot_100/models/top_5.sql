
  create or replace   view BB_DATABASE.BB_SCHEMA.top_5
  
   as (
    -- models/top_5.sql

WITH 
    source_data AS (
        SELECT * FROM BB_DATABASE.BB_SCHEMA.billboard_hot_100
    )

SELECT *
FROM source_data
LIMIT 5
  );

