select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select num_collabs
from BB_DATABASE.BB_SCHEMA.hot_100_artists
where num_collabs is null



      
    ) dbt_internal_test