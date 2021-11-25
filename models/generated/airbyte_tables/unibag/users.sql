{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_ab3') }}
select
    _id,
    {{ adapter.quote('name') }},
    banned,
    {{ adapter.quote('phone') }}::json->>'full' AS phone_number,
    {{ adapter.quote('phone') }}::json->>'verified' AS phone_verified,
    cast(phone::json->>'verifiedAt' AS date) AS phone_verified_at,
    {{ adapter.quote('info') }}::json->>'email' AS info_email,
    {{ adapter.quote('info') }}::json->'cityCode' AS info_province_code,
    {{ adapter.quote('info') }}::json->>'gender' AS info_gender,
    {{ adapter.quote('referral') }}::json->>'code' AS referral_code,
    registerfrom AS register_from,
    createdat AS created_at,
    updatedat AS updated_at,
    lastactivatedat AS last_activated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
-- users from {{ source('unibag', '_airbyte_raw_users') }}
where 1 = 1

