{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_ab3') }}
select
    _id,
    {{ adapter.quote('name') }},
    active,
    string_to_array(REPLACE(REPLACE(categories::text, '[', ''), ']', ''), ',') AS categories,
    string_to_array(REPLACE(REPLACE(subcategories::text, '[', ''), ']', ''), ',') AS sub_categories,
    {{ adapter.quote('price') }}::json->'base' AS price_base,
    {{ adapter.quote('price') }}::json->'market' AS price_market,
    {{ adapter.quote('price') }}::json->'minimum' AS price_min,
    {{ adapter.quote('price') }}::json->'maximum' AS price_max,
    createdat AS created_at,
    updatedat AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_products_hashid
from {{ ref('products_ab3') }}
-- products from {{ source('unibag', '_airbyte_raw_products') }}
where 1 = 1

