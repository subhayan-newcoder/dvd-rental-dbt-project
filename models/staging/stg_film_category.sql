{{config(
    materialized = 'view',
    schema = 'rental_staging'
)}}

select
  film_id,
  category_id,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'film_category') }}
