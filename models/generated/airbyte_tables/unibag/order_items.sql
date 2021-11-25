{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_items_ab3') }}
select
    _id,
    status,
    quantity,
    {{ adapter.quote('price') }}::json->'base' AS price_base,
    {{ adapter.quote('price') }}::json->'sell' AS price_sell,
    {{ adapter.quote('price') }}::json->'profit' AS price_profit,
    {{ adapter.quote('price') }}::json->'profitUni' AS price_profit_of_selly,
    {{ adapter.quote('price') }}::json->'minimum' AS price_min,
    {{ adapter.quote('price') }}::json->'maximum' AS price_max,
    {{ adapter.quote('price') }}::json->'market' AS price_market,
    {{ adapter.quote('price') }}::json->'supplierPrice' AS price_of_supplier,
    {{ adapter.quote('price') }}::json->'weight' AS weight,
    {{ adapter.quote('sku') }}::json->'_id'::text AS sku_id,
    {{ adapter.quote('sku') }}::json->'version' AS sku_version,
    {{ adapter.quote('user') }} AS seller_id,
    {{ adapter.quote('order') }} AS order_id,
    {{ adapter.quote('product') }} AS product_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_order_items_hashid
from {{ ref('order_items_ab3') }}
-- order_items from {{ source('unibag', '_airbyte_raw_order_items') }}
where 1 = 1

