{{
    config(
    materialized = 'table',
    schema = 'rental_staging',
    alias = 'stg_address'
    )
}}

select
  address_id,
  trim(address) as address_line_1,
  trim(address2) as address_line_2,
  district,
  city_id,
  postal_code,
  phone,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'address') }}