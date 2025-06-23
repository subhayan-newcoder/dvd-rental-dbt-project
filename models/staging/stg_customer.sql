{{
  config(
    materialized = 'table',
    schema = 'rental_staging',
    alias = 'stg_customer'
    )
}}

select
  customer_id,
  lower(first_name) as first_name,
  lower(last_name) as last_name,
  lower(trim(email)) as email,
  address_id,
  active::boolean as is_active,
  create_date::timestamp as created_at,
  last_update::timestamp as updated_at
from {{ source('rental_dvd', 'customer') }}