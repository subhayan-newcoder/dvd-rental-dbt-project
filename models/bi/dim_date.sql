{{
  config(
    materialized = 'table',
    schema = 'bi',
    alias = 'dim_date'
    )
}}



WITH dates AS (
  select rental_date as date from {{ ref('stg_rental') }}
  union
  select payment_date as date from {{ ref('stg_payment') }}
)
select
  distinct date::date as date_id,
  extract(year from date) as year,
  extract(month from date) as month,
  extract(day from date) as day,
  extract(dow from date) as weekday,
  to_char(date, 'Month') as month_name,
  to_char(date, 'Day') as day_name
from dates
