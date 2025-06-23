{% test unique_columns_test(model, column_names) %}

select 
    {{ column_names }},
    count(1)
from {{ model }}
group by {{ column_names }}
having count(1) > 1

{% endtest %}