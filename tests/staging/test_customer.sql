select 1
from {{ref('stg_customer')}}
where email != lower(email)
