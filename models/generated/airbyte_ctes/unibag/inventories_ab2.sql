{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('inventories_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_float() }}) as code,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    {{ cast_to_boolean('active') }} as active,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(contact as {{ type_json() }}) as contact,
    cast(checksum as {{ dbt_utils.type_string() }}) as checksum,
    cast({{ adapter.quote('location') }} as {{ type_json() }}) as {{ adapter.quote('location') }},
    cast(supplier as {{ type_json() }}) as supplier,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(minimumvalue as {{ dbt_utils.type_float() }}) as minimumvalue,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(paymentmethods as {{ type_json() }}) as paymentmethods,
    {{ cast_to_boolean('canissueinvoice') }} as canissueinvoice,
    {{ cast_to_boolean('canautosendemail') }} as canautosendemail,
    {{ cast_to_boolean('doessupportsellyexpress') }} as doessupportsellyexpress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories_ab1') }}
-- inventories
where 1 = 1

