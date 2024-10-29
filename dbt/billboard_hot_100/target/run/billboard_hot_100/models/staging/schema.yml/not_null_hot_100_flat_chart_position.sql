select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select chart_position
from BB_DATABASE.BB_SCHEMA.hot_100_flat
where chart_position is null



      
    ) dbt_internal_test