-- models/hot_100_artists.sql

WITH 
    billboard_data AS (
        SELECT 
            artist,
            MIN(chart_position) AS top_rank,
            COUNT(*) AS total_entries,
            COUNT(CASE WHEN chart_position <= 10 THEN 1 END) AS top10_entries
        FROM BB_DATABASE.BB_SCHEMA.hot_100_flat
        GROUP BY artist
    ),
    collab_data AS (
        SELECT 
            chart_position,
            COUNT(DISTINCT artist) AS artist_count
        FROM BB_DATABASE.BB_SCHEMA.hot_100_flat
        GROUP BY chart_position
        HAVING COUNT(DISTINCT artist) > 1
    ),
    artist_collabs AS (
        SELECT 
            hf.artist,
            COUNT(cd.chart_position) AS num_collabs
        FROM BB_DATABASE.BB_SCHEMA.hot_100_flat AS hf
        JOIN collab_data AS cd ON hf.chart_position = cd.chart_position
        GROUP BY hf.artist
    ),
    primary_artist_data AS (
        SELECT
            artist,
            COUNT(*) AS num_primary_artist
        FROM BB_DATABASE.BB_SCHEMA.hot_100_flat
        WHERE is_primary_artist = TRUE
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
    COALESCE(artist_collabs.num_collabs, 0) AS num_collabs,
    COALESCE(primary_artist_data.num_primary_artist, 0) AS num_primary_artist,
    artist_data.country,
    artist_data.genre
FROM billboard_data
LEFT JOIN artist_collabs
    ON billboard_data.artist = artist_collabs.artist
LEFT JOIN primary_artist_data
    ON billboard_data.artist = primary_artist_data.artist
LEFT JOIN artist_data
    ON LOWER(billboard_data.artist) = LOWER(artist_data.artist_name)