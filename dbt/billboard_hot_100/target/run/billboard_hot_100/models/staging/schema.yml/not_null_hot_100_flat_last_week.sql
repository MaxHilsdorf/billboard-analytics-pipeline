select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select last_week
from BB_DATABASE.BB_SCHEMA.hot_100_flat
where last_week is null



      
    ) dbt_internal_test