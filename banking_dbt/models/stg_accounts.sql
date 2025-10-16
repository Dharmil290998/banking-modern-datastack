{{ config(materialized='view') }}

with ranked as (
    select
        Data:id::string            as account_id,
        Data:customer_id::string   as customer_id,
        Data:account_type::string  as account_type,
        Data:balance::float        as balance,
        Data:currency::string      as currency,
        Data:created_at::timestamp as created_at,
        current_timestamp       as load_timestamp,
        row_number() over (
            partition by Data:id::string
            order by Data:created_at desc
        ) as rn
    from {{ source('raw', 'accounts') }}
)

select
    account_id,
    customer_id,
    account_type,
    balance,
    currency,
    created_at,
    load_timestamp
from ranked
where rn = 1