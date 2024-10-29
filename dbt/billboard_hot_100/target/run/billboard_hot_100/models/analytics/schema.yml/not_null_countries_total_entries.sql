select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select total_entries
from BB_DATABASE.BB_SCHEMA.countries
where total_entries is null



      
    ) dbt_internal_test