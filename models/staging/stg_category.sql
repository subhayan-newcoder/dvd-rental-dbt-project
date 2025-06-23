{{
    config(
        materialized = 'table',
        schema = 'rental_staging',
        alias = 'stg_category'
    )
}}

select
  category_id,
  lower(name) as name,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'category') }}