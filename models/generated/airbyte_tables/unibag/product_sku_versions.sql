{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_versions_ab3') }}
select
    _id,
    sku,
    info,
    {{ adapter.quote('name') }},
    price,
    {{ adapter.quote('source') }},
    codesku,
    picture,
    product,
    {{ adapter.quote('version') }},
    createdat,
    statistic,
    updatedat,
    properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_product_sku_versions_hashid
from {{ ref('product_sku_versions_ab3') }}
-- product_sku_versions from {{ source('unibag', '_airbyte_raw_product_sku_versions') }}
where 1 = 1

