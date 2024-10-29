-- models/my_first_model.sql

WITH 
    SOURCE_DATA AS (
        SELECT * FROM BB_DATABASE.BB_SCHEMA.billboard_hot_100
    )

SELECT *
FROM SOURCE_DATA
LIMIT 5