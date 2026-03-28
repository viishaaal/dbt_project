select
    customer_id,
    sum(amount) as total_revenue
from {{ ref('fct_orders') }}
group by customer_id