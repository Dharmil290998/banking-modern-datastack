{{ config(materialized='view') }}

with ranked as (
    select
        Data:id::string            as customer_id,
        Data:first_name::string    as first_name,
        Data:last_name::string     as last_name,
        Data:email::string         as email,
        Data:created_at::timestamp as created_at,
        current_timestamp       as load_timestamp,
        row_number() over (
            partition by Data:id::string
            order by Data:created_at desc
        ) as rn
    from {{ source('raw', 'customers') }}
)

select
    customer_id,
    first_name,
    last_name,
    email,
    created_at,
    load_timestamp
from ranked
where rn = 1