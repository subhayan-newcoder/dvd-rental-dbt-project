{{
    config(
        materialized = 'table',
        schema = 'bi',
        alias = 'ltv'
    )
}}

select
  customer_id,
  count(distinct rental_id) as total_rentals,
  count(payment_id) as total_payments,
  sum(amount) as total_revenue,
  avg(amount) as avg_payment_amount,
  min(payment_date) as first_payment_date,
  max(payment_date) as last_payment_date
from {{ ref('fct_payment') }}
group by customer_id