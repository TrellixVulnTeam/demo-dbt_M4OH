{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_ab3') }}
select
    _id,
    {{ adapter.quote('name') }},
    active,
    adminuser AS admin_id,
    citycode AS province_code,
    {{ adapter.quote('level') }}::json->'level' AS current_level_value,
    {{ adapter.quote('level') }}::json->'name'::text AS current_level_name,
    cast(jsonb_extract_path_text(level, 'expiredAt') AS date) AS current_level_expired_at,
    {{ adapter.quote('level') }}::json->'bonusPercent' AS bonus_percent,
    {{ adapter.quote('level') }}::json->'maximumNumberMember' AS stats_max_member,
    {{ adapter.quote('statistic') }}::json->'memberTotal' AS stats_current_member,
    createdat AS created_at,
    updatedat AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_teams_hashid
from {{ ref('teams_ab3') }}
-- teams from {{ source('unibag', '_airbyte_raw_teams') }}
where 1 = 1

