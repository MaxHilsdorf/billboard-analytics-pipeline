
  
    

        create or replace transient table BB_DATABASE.BB_SCHEMA.countries
         as
        (-- models/countries.sql

WITH ranked_artists AS (
    SELECT
        country,
        artist,
        top_rank,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY top_rank ASC) AS rank
    FROM BB_DATABASE.BB_SCHEMA.hot_100_artists
),
ranked_genres AS (
    SELECT 
        country,
        genre,
        COUNT(*) AS genre_count,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rank
    FROM BB_DATABASE.BB_SCHEMA.hot_100_artists
    GROUP BY country, genre
)

SELECT
    a.country,
    SUM(a.num_primary_artist) AS total_entries,
    COUNT(DISTINCT a.artist) AS total_artists,
    MIN(a.top_rank) AS top_rank,
    MAX(CASE WHEN ra.rank = 1 THEN ra.artist END) AS top_artist,
    MAX(CASE WHEN rg.rank = 1 THEN rg.genre END) AS top_genre
FROM BB_DATABASE.BB_SCHEMA.hot_100_artists AS a
LEFT JOIN ranked_artists AS ra ON a.country = ra.country AND a.artist = ra.artist
LEFT JOIN ranked_genres AS rg ON a.country = rg.country AND a.genre = rg.genre
GROUP BY a.country
ORDER BY total_entries DESC
        );
      
  