{{ config(materialized='view') }}

SELECT
    Data:id::string                 AS transaction_id,
    Data:account_id::string         AS account_id,
    Data:amount::float              AS amount,
    Data:txn_type::string           AS transaction_type,
    Data:related_account_id::string AS related_account_id,
    Data:status::string             AS status,
    Data:created_at::timestamp      AS transaction_time,
    CURRENT_TIMESTAMP            AS load_timestamp
FROM {{ source('raw', 'transactions') }}