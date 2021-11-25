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
    code,
    info,
    {{ adapter.quote('name') }},
    team,
    apple,
    phone,
    avatar,
    banned,
    google,
    facebook,
    hasorder,
    referral,
    createdat,
    statistic,
    updatedat,
    membership,
    bannedreason,
    registerfrom,
    searchstring,
    isupdatedinfo,
    identification,
    lastactivatedat,
    identificationid,
    socialloginemail,
    lastviewnotificationat,
    isverifiedidentification,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_ab3') }}
-- users from {{ source('unibag', '_airbyte_raw_users') }}
where 1 = 1

