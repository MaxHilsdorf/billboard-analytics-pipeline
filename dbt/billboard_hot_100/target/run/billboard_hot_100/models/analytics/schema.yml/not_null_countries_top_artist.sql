select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select top_artist
from BB_DATABASE.BB_SCHEMA.countries
where top_artist is null



      
    ) dbt_internal_test