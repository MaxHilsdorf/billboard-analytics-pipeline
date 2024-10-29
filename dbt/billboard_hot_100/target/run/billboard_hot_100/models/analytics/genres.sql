
  
    

        create or replace transient table BB_DATABASE.BB_SCHEMA.genres
         as
        (-- models/genres.sql

SELECT *
FROM BB_DATABASE.BB_SCHEMA.hot_100_artists
        );
      
  