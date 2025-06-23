{{
    config(
        materialized = 'incremental',
        unique_id = ['payment_id','customer_id'],
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
where p.payment_date >= coalesce(select max(payment_date) from {{this}}, '1970-01-01')
{% endif %}