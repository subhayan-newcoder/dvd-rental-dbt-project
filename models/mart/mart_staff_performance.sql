{{
    config(
        materialized = 'table',
        schema = 'mart',
        alias = 'staff_performance'
    )
}}

select
  staff_id,
  date_trunc('month', payment_date) as month,
  count(payment_id) as payments_processed,
  sum(amount) as revenue_generated
from {{ ref('fct_payment')}}
group by staff_id, date_trunc('month', payment_date)
order by staff_id, month