select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select weeks_on_chart
from BB_DATABASE.BB_SCHEMA.hot_100_flat
where weeks_on_chart is null



      
    ) dbt_internal_test