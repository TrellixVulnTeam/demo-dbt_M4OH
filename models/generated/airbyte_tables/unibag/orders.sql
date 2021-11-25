{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_ab3') }}
select
    _id,
    code,
    trackingcode AS tracking_code,
    status,
    banned,
    string_to_array(REPLACE(REPLACE(REPLACE(tags::text, '[', ''), ']', ''), '"', ''), ',') AS tags,
    isdeleted AS is_deleted,
    {{ adapter.quote('promotion') }}::json->'isApplied' AS promotion_is_applied,
    {{ adapter.quote('promotion') }}::json->'discount' AS promotion_discount_value,
    {{ adapter.quote('promotion') }}::json->'minOrderValue' AS promotion_min_order_value,
    {{ adapter.quote('inventory') }}::json->>'_id' AS inventory_id,
    {{ adapter.quote('inventory') }}::json->>'name' AS inventory_name,
    {{ adapter.quote('payment') }}::json->>'method' AS payment_method,
    {{ adapter.quote('payment') }}::json->>'status' AS payment_status,
    {{ adapter.quote('price') }}::json->'base' AS price_base,
    {{ adapter.quote('price') }}::json->'sell' AS price_sell,
    {{ adapter.quote('price') }}::json->'profit' AS price_profit,
    {{ adapter.quote('price') }}::json->'profitUni' AS price_profit_of_selly,
    {{ adapter.quote('price') }}::json->'minimum' AS price_min,
    {{ adapter.quote('price') }}::json->'maximum' AS price_max,
    {{ adapter.quote('price') }}::json->'total' AS price_total,
    {{ adapter.quote('price') }}::json->'weight' AS weight,
    approvedat AS approved_at,
    rejectedat AS rejected_at,
    pickupat AS pickup_at,
    deliveredat AS delivered_at,
    createdat AS created_at,
    updatedat AS updated_at,
    {{ adapter.quote('user') }} AS seller_id,
    customer AS customer_id,
    delivery::json->>'status' AS delivery_status,
    iswaitingcancelled AS is_waiting_cancelled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_orders_hashid
from {{ ref('orders_ab3') }}
-- orders from {{ source('unibag', '_airbyte_raw_orders') }}
where 1 = 1

