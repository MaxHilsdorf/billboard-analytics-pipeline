
  create or replace   view BB_DATABASE.BB_SCHEMA.hot_100_flat_SQL
  
   as (
    -- models/hot_100_flat_SQL.sql

WITH
    split_artists AS (
        SELECT
            b.*,
            SPLIT(REGEXP_REPLACE(ARTIST, ' & | Feat\\.', '|'), '|') AS artist_parts
        FROM BB_DATABASE.BB_SCHEMA.billboard_hot_100 b
    ),
    exploded_artists AS (
        SELECT
            b.*,
            TRIM(a.value::STRING) AS split_artist
        FROM split_artists b,
        LATERAL FLATTEN(input => b.artist_parts) a
    ),
    validated_artists AS (
        SELECT
            ea.*,
            CASE 
                WHEN va.artist_name IS NOT NULL THEN ea.split_artist
                ELSE ea.artist  -- Keep original artist if validation fails
            END AS final_artist
        FROM exploded_artists ea
        LEFT JOIN BB_DATABASE.BB_SCHEMA.artist_data va 
            ON LOWER(ea.split_artist) = LOWER(va.artist_name)
    )
SELECT
    chart_position,
    song,
    final_artist AS artist,
    last_week,
    peak_position,
    weeks_on_chart
FROM validated_artists
ORDER BY chart_position ASC, artist ASC
  );

