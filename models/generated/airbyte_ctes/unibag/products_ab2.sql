{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast(info as {{ type_json() }}) as info,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast({{ adapter.quote('order') }} as {{ type_json() }}) as {{ adapter.quote('order') }},
    cast(price as {{ type_json() }}) as price,
    cast(score as {{ type_json() }}) as score,
    {{ cast_to_boolean('active') }} as active,
    cast(author as {{ dbt_utils.type_string() }}) as author,
    guides,
    photos,
    videos,
    cast(quantity as {{ dbt_utils.type_float() }}) as quantity,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    documents,
    cast(sharedesc as {{ dbt_utils.type_string() }}) as sharedesc,
    cast(statistic as {{ type_json() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    categories,
    properties,
    {{ cast_to_boolean('isoutofstock') }} as isoutofstock,
    cast(pricepercent as {{ type_json() }}) as pricepercent,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    subcategories,
    cast(inactivereason as {{ dbt_utils.type_string() }}) as inactivereason,
    cast(propertiesmain as {{ dbt_utils.type_string() }}) as propertiesmain,
    cast(sharestatistic as {{ type_json() }}) as sharestatistic,
    {{ cast_to_boolean('canissueinvoice') }} as canissueinvoice,
    {{ cast_to_boolean('pendinginactive') }} as pendinginactive,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_ab1') }}
-- products
where 1 = 1

