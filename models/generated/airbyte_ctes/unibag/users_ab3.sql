{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        'info',
        adapter.quote('name'),
        'team',
        'apple',
        'phone',
        'avatar',
        boolean_to_string('banned'),
        'google',
        'facebook',
        boolean_to_string('hasorder'),
        'referral',
        'createdat',
        'statistic',
        'updatedat',
        'membership',
        'bannedreason',
        'registerfrom',
        'searchstring',
        boolean_to_string('isupdatedinfo'),
        'identification',
        'lastactivatedat',
        'identificationid',
        'socialloginemail',
        'lastviewnotificationat',
        boolean_to_string('isverifiedidentification'),
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} tmp
-- users
where 1 = 1

