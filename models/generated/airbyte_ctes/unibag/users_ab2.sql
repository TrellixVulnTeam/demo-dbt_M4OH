{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast(info as {{ type_json() }}) as info,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(team as {{ type_json() }}) as team,
    cast(apple as {{ dbt_utils.type_string() }}) as apple,
    cast(phone as {{ type_json() }}) as phone,
    cast(avatar as {{ type_json() }}) as avatar,
    {{ cast_to_boolean('banned') }} as banned,
    cast(google as {{ type_json() }}) as google,
    cast(facebook as {{ type_json() }}) as facebook,
    {{ cast_to_boolean('hasorder') }} as hasorder,
    cast(referral as {{ type_json() }}) as referral,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(statistic as {{ type_json() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(membership as {{ type_json() }}) as membership,
    cast(bannedreason as {{ dbt_utils.type_string() }}) as bannedreason,
    cast(registerfrom as {{ dbt_utils.type_string() }}) as registerfrom,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    {{ cast_to_boolean('isupdatedinfo') }} as isupdatedinfo,
    cast(identification as {{ type_json() }}) as identification,
    cast(lastactivatedat as {{ dbt_utils.type_string() }}) as lastactivatedat,
    cast(identificationid as {{ dbt_utils.type_string() }}) as identificationid,
    cast(socialloginemail as {{ type_json() }}) as socialloginemail,
    cast(lastviewnotificationat as {{ dbt_utils.type_string() }}) as lastviewnotificationat,
    {{ cast_to_boolean('isverifiedidentification') }} as isverifiedidentification,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1

