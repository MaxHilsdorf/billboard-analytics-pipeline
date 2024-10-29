select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select total_artists
from BB_DATABASE.BB_SCHEMA.countries
where total_artists is null



      
    ) dbt_internal_test