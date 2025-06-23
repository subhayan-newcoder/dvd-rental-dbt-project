{{
    config(
        materialized = 'table',
        schema = 'mart',
        alias = 'film_popularity'
    )
}}

select
  f.film_id,
  f.title,
  count(r.rental_id) as rental_count,
  count(distinct r.customer_id) as unique_customers,
  sum(p.amount) as total_revenue
from {{ ref('fct_rentals') }} r
join {{ ref('dim_film') }} f on r.film_id = f.film_id
left join {{ref('fct_payment')}} p on r.rental_id = p.rental_id
group by f.film_id, f.title