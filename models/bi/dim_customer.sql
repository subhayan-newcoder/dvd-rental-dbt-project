{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'customer_id',
        schema = 'bi'
    )
}}

with customer as (
select
  c.customer_id,
  lower(c.first_name || ' ' || c.last_name) as full_name,
  c.email,
  a.address_line_1,
  a.postal_code,
  ci.city,
  co.country,
  c.created_at as created_at,
  c.updated_at as updated_at,
  c.is_active as is_active
from {{ ref('stg_customer') }} c
join {{ ref('stg_address') }} a on c.address_id = a.address_id
join {{ ref('stg_city')}} ci on a.city_id = ci.city_id
join {{ ref('stg_country')}} co on ci.country_id = co.country_id
{% if is_incremental() %}
where c.updated_at >= (select max(updated_at) from {{this}})
{% endif %}
)
select * from customer