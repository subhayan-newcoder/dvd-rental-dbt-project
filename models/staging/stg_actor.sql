
{{
    config(
    materialized = 'table',
    schema = 'rental_staging'
    )
}}

select 
    actor_id, 
    lower(first_name) as first_name, 
    lower(last_name) as last_name, 
    last_update::timestamp as updated_at
from {{ source('rental_dvd', 'actor') }}