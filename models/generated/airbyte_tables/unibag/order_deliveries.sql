{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_deliveries_ab3') }}
select
    _id,
    code,
    {{ adapter.quote('order') }},
    title,
    reason,
    status,
    service,
    customer,
    delivery,
    {{ adapter.quote('location') }},
    createdat,
    promotion,
    updatedat,
    trackingcode,
    trackingtime,
    isadminchange,
    trackingordercode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_order_deliveries_hashid
from {{ ref('order_deliveries_ab3') }}
-- order_deliveries from {{ source('unibag', '_airbyte_raw_order_deliveries') }}
where 1 = 1

