{{
    config(
        materialized = 'table',
        schema = 'mart',
        alias = 'category_engagement'
    )
}}

select
  c.name as category_name,
  count(r.rental_id) as rental_count,
  sum(p.amount) as total_revenue,
  avg(f.length) as avg_film_length
from {{ref('fct_rentals')}} r
join {{ref('dim_film')}} f on r.film_id = f.film_id
left join {{ref('fct_payment')}} p on r.rental_id = p.rental_id
left join {{ref('stg_film_category')}} fc on f.film_id = fc.film_id
left join {{ref('stg_category')}} c on fc.category_id = c.category_id
group by c.name