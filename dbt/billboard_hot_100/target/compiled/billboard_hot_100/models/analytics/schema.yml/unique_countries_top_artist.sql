
    
    

select
    top_artist as unique_field,
    count(*) as n_records

from BB_DATABASE.BB_SCHEMA.countries
where top_artist is not null
group by top_artist
having count(*) > 1


