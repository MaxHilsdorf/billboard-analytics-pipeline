
  
    

        create or replace transient table BB_DATABASE.BB_SCHEMA.hot_100_artists
         as
        (-- models/hot_100_artists.sql

WITH 
    billboard_data AS (
        SELECT artist,
            MIN(chart_position) AS top_rank,
            COUNT(*) AS total_entries,
            COUNT(CASE WHEN chart_position <= 10 THEN 1 END) AS top10_entries
        FROM BB_DATABASE.BB_SCHEMA.hot_100_flat
        GROUP BY artist
    ),
    artist_data AS (
        SELECT * FROM BB_DATABASE.BB_SCHEMA.artist_data
    )

SELECT DISTINCT
    billboard_data.artist,
    billboard_data.top_rank,
    billboard_data.total_entries,
    billboard_data.top10_entries,
    artist_data.country,
    artist_data.genre
FROM billboard_data
LEFT JOIN artist_data
    ON LOWER(billboard_data.artist) = LOWER(artist_data.artist_name)
        );
      
  