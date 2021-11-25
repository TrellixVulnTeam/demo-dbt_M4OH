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
    title,
    status,
    promotion::json->'discount' AS discount_value,
    {{ adapter.quote('delivery') }}::json->'fee' AS fee,
    {{ adapter.quote('delivery') }}::json->>'note' AS note,
    {{ adapter.quote('delivery') }}::json->>'courierName' AS courier_name,
    {{ adapter.quote('delivery') }}::json->>'serviceName' AS service_name,
    {{ adapter.quote('delivery') }}::json->>'serviceCode' AS service_code,
    {{ adapter.quote('delivery') }}::json->>'currency' AS currency,
    {{ adapter.quote('delivery') }}::json->'minDeliveryDay' AS min_delivery_day,
    {{ adapter.quote('delivery') }}::json->'maxDeliveryDay' AS max_delivery_day,
    {{ adapter.quote('delivery') }}::json->>'estimateTimeDelivery' AS estimate_time_delivery,
    service AS service_delivery,
    {{ adapter.quote('location') }}::json->'province' AS location_province,
    {{ adapter.quote('location') }}::json->'district' AS location_district,
    {{ adapter.quote('location') }}::json->'ward' AS location_ward,
    {{ adapter.quote('location') }}::json->>'address' AS location_address,
    {{ adapter.quote('location') }}::json->>'fullAddress' AS location_full_address,
    {{ adapter.quote('customer') }}::json->>'name' AS customer_name,
    {{ adapter.quote('customer') }}::json->>'phone' AS customer_phone,
    {{ adapter.quote('order') }} AS order_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_order_deliveries_hashid
from {{ ref('order_deliveries_ab3') }}
-- order_deliveries from {{ source('unibag', '_airbyte_raw_order_deliveries') }}
where 1 = 1

