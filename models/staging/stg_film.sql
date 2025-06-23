{{
    config(
        materialized = 'table',
        schema = 'rental_staging',
        alias = 'stg_film'
    )
}}

select
  film_id,
  title,
  description,
  release_year::int,
  rental_duration,
  rental_rate::numeric,
  length,
  replacement_cost::numeric,
  rating,
  special_features,
  language_id,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'film') }}