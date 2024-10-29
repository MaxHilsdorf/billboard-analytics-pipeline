-- models/countries.sql

WITH ranked_artists AS (
    SELECT
        country,
        artist,
        top_rank,
        ROW_NUMBER() OVER (PARTITION BY COUNTRY ORDER BY top_rank ASC) AS rank
    FROM BB_DATABASE.BB_SCHEMA.hot_100_artists
),
ranked_genres AS (
    SELECT 
        genre,
        COUNT(*) as genre_count,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
    FROM BB_DATABASE.BB_SCHEMA.hot_100_artists
    GROUP BY country, genre
)

SELECT
    a.country,
    COUNT(*) AS total_entries,
    COUNT(DISTINCT a.artist) AS total_artists,
    SUM(a.top10_entries) AS top_10_entries,
    MIN(a.top_rank) AS top_rank,
    MAX(CASE WHEN ra.rank = 1 THEN ra.artist END) AS top_artist,
    MAX(CASE WHEN rg.rank = 1 THEN rg.genre END) AS top_genre
FROM BB_DATABASE.BB_SCHEMA.hot_100_artists AS a
LEFT JOIN ranked_artists AS ra ON a.country = ra.country
LEFT JOIN ranked_genres AS rg ON a.genre = rg.genre
GROUP BY a.country
ORDER BY total_entries DESC