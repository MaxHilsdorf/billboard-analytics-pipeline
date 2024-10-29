select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select top_rank
from BB_DATABASE.BB_SCHEMA.hot_100_artists
where top_rank is null



      
    ) dbt_internal_test