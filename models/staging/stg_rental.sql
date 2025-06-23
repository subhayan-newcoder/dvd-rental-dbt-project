{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_id = 'rental_id',
    schema = 'rental_staging'
  )
}}

WITH source_data AS (
  select
    rental_id,
    rental_date::timestamp,
    inventory_id,
    customer_id,
    return_date::timestamp,
    staff_id,
    last_update::timestamp as updated_at
  from {{ source('rental_dvd', 'rental') }}
  where rental_date is not null
  {% if is_incremental() %}
    and last_update >= (select max(updated_at) from {{ this }})
  {% endif %}
)
select * from source_data