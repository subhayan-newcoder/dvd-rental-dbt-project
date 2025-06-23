{{
    config(
        materialized = 'view',
        schema = 'rental_staging'
    )
}}

select
  country_id,
  lower(trim(country)) as country,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'country') }}
