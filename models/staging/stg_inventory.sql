{{
  config(
    materialized = 'incremental',
    unique_key = 'inventory_id',
    incremental_strategy = 'merge',
    schema = 'rental_staging'
    )
}}

select
  inventory_id,
  film_id,
  store_id,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'inventory') }}
{% if is_incremental() %}
  where last_update >= coalesce((select max(updated_at) from {{ this }}), '1900-01-01')
{% endif %}
