{{
  config(
    materialized = 'incremental',
    unique_key = 'rental_id',
    incrmental_strategy = 'merge',
    schema = 'bi',
    alias = 'fct_rental'
    )
}}

select
  r.rental_id,
  r.customer_id,
  r.inventory_id,
  f.film_id,
  r.rental_date,
  r.return_date,
  EXTRACT(DAY FROM (r.return_date - r.rental_date)) as rental_duration_days,
  r.staff_id,
  r.updated_at
from {{ ref('stg_rental') }} r
join {{ ref('stg_inventory') }} i on r.inventory_id = i.inventory_id
join {{ ref('stg_film') }} f on i.film_id = f.film_id
{% if is_incremental() %}
  and r.updated_at >= coalesce((select max(updated_at) from {{ this }}), '1900-01-01')
{% endif %}
