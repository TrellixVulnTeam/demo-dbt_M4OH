{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_ab3') }}
select
    _id,
    {{ adapter.quote('desc') }},
    icon,
    {{ adapter.quote('name') }},
    {{ adapter.quote('type') }},
    cover,
    endat,
    active,
    article,
    {{ adapter.quote('options') }},
    startat,
    segments,
    createdat,
    updatedat,
    isapplyforall,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_events_hashid
from {{ ref('events_ab3') }}
-- events from {{ source('unibag', '_airbyte_raw_events') }}
where 1 = 1

