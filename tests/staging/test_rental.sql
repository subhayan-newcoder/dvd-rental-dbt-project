select 1
from {{ref('stg_rental')}}
where return_date is not null
  and rental_date >= return_date