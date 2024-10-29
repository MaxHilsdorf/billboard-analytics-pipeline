
  
    

        create or replace transient table BB_DATABASE.BB_SCHEMA.summary_stats
         as
        (-- models/summary_statistics.sql

SELECT *
FROM BB_DATABASE.BB_SCHEMA.hot_100_artists
        );
      
  