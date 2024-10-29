select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select country
from BB_DATABASE.BB_SCHEMA.countries
where country is null



      
    ) dbt_internal_test