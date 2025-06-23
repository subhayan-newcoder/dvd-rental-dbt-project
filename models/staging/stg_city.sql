{{
    config(
        materialized = 'view',
        schema = 'rental_staging'
    )
}}

select
  city_id,
  country_id,
  lower(trim(city)) as city,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'city') }}
