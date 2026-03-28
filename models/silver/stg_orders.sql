{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

select
    order_id,
    customer_id,
    amount,
    status,
    order_date
from {{ source('bronze', 'orders_raw') }}
where status = 'completed'

{% if is_incremental() %}
  and order_date >= dateadd(day, -2, (select max(order_date) from {{ this }}))
{% endif %}