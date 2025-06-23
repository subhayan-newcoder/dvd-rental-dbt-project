{{
    config(
        materialized = 'table',
        schema = 'rental_staging'
    )
}}

select
  payment_id,
  customer_id,
  staff_id,
  rental_id,
  amount::numeric,
  payment_date::timestamp
from {{ source('rental_dvd', 'payment') }}
where amount > 0