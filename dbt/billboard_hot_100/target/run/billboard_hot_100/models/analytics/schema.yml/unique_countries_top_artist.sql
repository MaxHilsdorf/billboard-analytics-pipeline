select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    top_artist as unique_field,
    count(*) as n_records

from BB_DATABASE.BB_SCHEMA.countries
where top_artist is not null
group by top_artist
having count(*) > 1



      
    ) dbt_internal_test