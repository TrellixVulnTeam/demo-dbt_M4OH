{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('wards_ab3') }}
select
    _id,
    code,
    {{ adapter.quote('name') }},
    slug,
    cityid,
    {{ adapter.quote('source') }},
    district,
    gidocode,
    osirisid,
    updatedat,
    districtid,
    provinceid,
    searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_wards_hashid
from {{ ref('wards_ab3') }}
-- wards from {{ source('unibag', '_airbyte_raw_wards') }}
where 1 = 1

