select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select song
from BB_DATABASE.BB_SCHEMA.hot_100_flat
where song is null



      
    ) dbt_internal_test