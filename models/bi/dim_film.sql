{{
    config(
        materialized = 'materialized_view',
        schema = 'bi',
        alias = 'dim_film'
    )
}}

select
  f.film_id,
  f.title,
  f.description,
  f.release_year,
  f.length,
  case
    when f.length < 60 then 'Short'
    when f.length between 60 and 120 then 'Medium'
    else 'Long'
  end as length_category,
  f.rating,
  f.special_features,
  cat.name as category_name,
  lang.name as language_name
from {{ ref('stg_film') }} f
left join {{ ref('stg_film_category') }} fc on f.film_id = fc.film_id
left join {{ ref('stg_category') }} cat on fc.category_id = cat.category_id
left join {{ ref('stg_language') }} lang on f.language_id = lang.language_id