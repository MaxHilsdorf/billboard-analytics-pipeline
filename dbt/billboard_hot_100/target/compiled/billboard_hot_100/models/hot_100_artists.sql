-- models/hot_100_artists.sql

WITH 
    billboard_data AS (
        SELECT * FROM BB_DATABASE.BB_SCHEMA.billboard_hot_100
    ),
    artist_data AS (
        SELECT * FROM BB_DATABASE.BB_SCHEMA.artist_data
    )

SELECT DISTINCT
    billboard_data.artist,
    artist_data.country,
    artist_data.genre,
    MIN(billboard_data.chart_position)
FROM billboard_data
LEFT JOIN artist_data
    ON billboard_data.artist = artist_data.artist_name