{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sku_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'sku',
        'info',
        adapter.quote('name'),
        adapter.quote('type'),
        'brand',
        'cover',
        'price',
        boolean_to_string('active'),
        'author',
        adapter.quote('source'),
        boolean_to_string('display'),
        'picture',
        'product',
        adapter.quote('version'),
        'groupsku',
        'quantity',
        'unitcode',
        'createdat',
        'statistic',
        'updatedat',
        array_to_string('properties'),
        'suppliersku',
        boolean_to_string('isoutofstock'),
        'pricepercent',
        'searchstring',
        'updateactiveid',
        boolean_to_string('displayinventory'),
    ]) }} as _airbyte_product_sku_hashid,
    tmp.*
from {{ ref('product_sku_ab2') }} tmp
-- product_sku
where 1 = 1

