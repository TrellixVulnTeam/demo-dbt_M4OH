{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('districts_ab3') }}
select
    _id,
    code,
    {{ adapter.quote('name') }},
    slug,
    tncid,
    cityid,
    {{ adapter.quote('source') }},
    tnccode,
    gidocode,
    osirisid,
    updatedat,
    searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_districts_hashid
from {{ ref('districts_ab3') }}
-- districts from {{ source('unibag', '_airbyte_raw_districts') }}
where 1 = 1

