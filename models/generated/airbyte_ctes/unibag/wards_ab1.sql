{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_wards') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['cityId'], ['cityId']) }} as cityid,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as {{ adapter.quote('source') }},
    {{ json_extract_scalar('_airbyte_data', ['district'], ['district']) }} as district,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_wards') }} as table_alias
-- wards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

