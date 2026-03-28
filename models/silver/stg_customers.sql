{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

select
    customer_id,
    trim(name) as name,
    lower(email) as email,
    city,
    created_at
from {{ source('bronze', 'customers_raw') }}
where name is not null

{% if is_incremental() %}
  and created_at >= dateadd(day, -2, (select max(created_at) from {{ this }}))
{% endif %}
