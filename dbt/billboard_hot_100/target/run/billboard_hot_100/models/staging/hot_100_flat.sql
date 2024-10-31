
  create or replace   view BB_DATABASE.BB_SCHEMA.hot_100_flat
  
   as (
    -- models/hot_100_flat_SQL.sql

WITH
    split_artists AS (
        SELECT
            b.*,
            SPLIT(REGEXP_REPLACE(artist, ' & | Feat\\.', '|'), '|') AS artist_parts
        FROM BB_DATABASE.BB_SCHEMA.billboard_hot_100 b
    ),
    exploded_artists AS (
        SELECT
            b.*,
            TRIM(a.value::STRING) AS split_artist,
            ROW_NUMBER() OVER (PARTITION BY b.chart_position ORDER BY a.index) AS artist_position
        FROM split_artists b,
        LATERAL FLATTEN(input => b.artist_parts) a
    ),
    validated_artists AS (
        SELECT
            ea.*,
            CASE 
                WHEN va.artist_name IS NOT NULL THEN ea.split_artist
                ELSE ea.artist
            END AS final_artist,
            CASE 
                WHEN ea.artist_position = 1 THEN TRUE
                ELSE FALSE
            END AS is_primary_artist
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
    weeks_on_chart,
    is_primary_artist
FROM validated_artists
ORDER BY chart_position ASC, artist ASC
  );

