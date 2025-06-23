{{
    config(
        materialized = 'table',
        schema = 'mart',
        alias = 'monthly_revenue'
    )
}}

select
  date_trunc('month', payment_date) as revenue_month,
  sum(amount) as total_revenue,
  count(*) as total_payments
from {{ ref('fct_payment') }}
group by 1
order by 1
