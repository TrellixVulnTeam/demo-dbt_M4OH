{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_ab3') }}
select
    _id,
    sku,
    {{ adapter.quote('name') }},
    active,
    quantity,
    picture AS photo,
    {{ adapter.quote('price') }}::json->'base' AS price_base,
    {{ adapter.quote('price') }}::json->'market' AS price_market,
    {{ adapter.quote('price') }}::json->'minimum' AS price_min,
    {{ adapter.quote('price') }}::json->'maximum' AS price_max,
    {{ adapter.quote('price') }}::json->'supplier' AS price_of_supplier,
    {{ adapter.quote('info') }}::json->'inventory'->'name'::text AS inventory_name,
    {{ adapter.quote('info') }}::json->'supplier'->'_id'::text AS supplier_id,
    {{ adapter.quote('info') }}::json->'supplier'->'name'::text AS supplier_name,
    {{ adapter.quote('statistic') }}::json->'saleTotal' AS stats_sale_total,
    {{ adapter.quote('statistic') }}::json->'salePending' AS stats_sale_pending,
    {{ adapter.quote('statistic') }}::json->'saleDelivered' AS stats_sale_delivered,
    {{ adapter.quote('statistic') }}::json->'saleCancelled' AS stats_sale_cancelled,
    {{ adapter.quote('statistic') }}::json->'saleCashback' AS stats_sale_cashback,
    product AS product_id,
    createdat AS created_at,
    updatedat AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_product_sku_hashid
from {{ ref('product_sku_ab3') }}
-- product_sku from {{ source('unibag', '_airbyte_raw_product_sku') }}
where 1 = 1

