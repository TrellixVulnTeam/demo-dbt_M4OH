{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('inventories_ab3') }}
select
    {{ adapter.quote('id') }},
    _id,
    code,
    {{ adapter.quote('name') }},
    slug,
    email,
    phone,
    active,
    address,
    contact,
    checksum,
    {{ adapter.quote('location') }},
    supplier,
    createdat,
    updatedat,
    minimumvalue,
    searchstring,
    paymentmethods,
    canissueinvoice,
    canautosendemail,
    doessupportsellyexpress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_inventories_hashid
from {{ ref('inventories_ab3') }}
-- inventories from {{ source('unibag', '_airbyte_raw_inventories') }}
where 1 = 1

