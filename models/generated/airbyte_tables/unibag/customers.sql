{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_ab3') }}
select
    _id,
    {{ adapter.quote('name') }},
    {{ adapter.quote('user') }},
    email,
    phone,
    {{ adapter.quote('source') }},
    {{ adapter.quote('location') }},
    createdat,
    isdeleted,
    statistic,
    updatedat,
    searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customers_hashid
from {{ ref('customers_ab3') }}
-- customers from {{ source('unibag', '_airbyte_raw_customers') }}
where 1 = 1

