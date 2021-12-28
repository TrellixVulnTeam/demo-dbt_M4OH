{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('desc'),
        'icon',
        adapter.quote('name'),
        adapter.quote('type'),
        'cover',
        'endat',
        boolean_to_string('active'),
        'article',
        adapter.quote('options'),
        'startat',
        'segments',
        'createdat',
        'updatedat',
        'information',
        boolean_to_string('isapplyforall'),
    ]) }} as _airbyte_events_hashid,
    tmp.*
from {{ ref('events_ab2') }} tmp
-- events
where 1 = 1

