
    
    

select
    artist as unique_field,
    count(*) as n_records

from BB_DATABASE.BB_SCHEMA.hot_100_artists
where artist is not null
group by artist
having count(*) > 1


