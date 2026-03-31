{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=['name', 'city']
    )
}}

select
    customer_id,
    name,
    city
from {{ source('bronze', 'customers_raw') }}

{% endsnapshot %}