
    
    

select
    country as unique_field,
    count(*) as n_records

from BB_DATABASE.BB_SCHEMA.countries
where country is not null
group by country
having count(*) > 1


