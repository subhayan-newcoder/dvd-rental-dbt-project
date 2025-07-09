{{
    config(
        materialized = 'incremental',
        unique_key = ['payment_id','customer_id'],
        incremental_strategy = 'merge',
        schema = 'bi',
        alias = 'fct_payment'
    )
}}


select
  p.payment_id,
  p.customer_id,
  p.staff_id,
  p.rental_id,
  p.payment_date,
  p.amount
from {{ref('stg_payment')}} p
{% if is_incremental() %}
where p.payment_date >=(select coalesce(max(payment_date), '1970-01-01') from {{this}})
{% endif %}