{{
    config(
        materialized = 'view',
        schema = 'rental_staging'
    )
}}

select
  language_id,
  lower(trim(name)) as name,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'language') }}
