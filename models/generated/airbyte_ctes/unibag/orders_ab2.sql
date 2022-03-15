{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast({{ adapter.quote('date') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('date') }},
    cast({{ adapter.quote('hour') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('hour') }},
    cast(note as {{ dbt_utils.type_string() }}) as note,
    tags,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast(price as {{ dbt_utils.type_string() }}) as price,
    {{ cast_to_boolean('banned') }} as banned,
    cast(reason as {{ dbt_utils.type_string() }}) as reason,
    cast({{ adapter.quote('source') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('source') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(teamid as {{ dbt_utils.type_string() }}) as teamid,
    cast(payment as {{ dbt_utils.type_string() }}) as payment,
    cast(remarks as {{ dbt_utils.type_string() }}) as remarks,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(delivery as {{ dbt_utils.type_string() }}) as delivery,
    {{ cast_to_boolean('iscalled') }} as iscalled,
    cast(merchant as {{ dbt_utils.type_string() }}) as merchant,
    cast(pickupat as {{ dbt_utils.type_string() }}) as pickupat,
    cast(supplier as {{ dbt_utils.type_string() }}) as supplier,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(inventory as {{ dbt_utils.type_string() }}) as inventory,
    cast(invoiceid as {{ dbt_utils.type_string() }}) as invoiceid,
    {{ cast_to_boolean('isdeleted') }} as isdeleted,
    cast(promotion as {{ dbt_utils.type_string() }}) as promotion,
    cast(requestid as {{ dbt_utils.type_string() }}) as requestid,
    cast(restockat as {{ dbt_utils.type_string() }}) as restockat,
    cast(sendemail as {{ dbt_utils.type_string() }}) as sendemail,
    cast(totalitem as {{ dbt_utils.type_float() }}) as totalitem,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(useragent as {{ dbt_utils.type_string() }}) as useragent,
    {{ cast_to_boolean('wholesale') }} as wholesale,
    cast(approvedat as {{ dbt_utils.type_string() }}) as approvedat,
    cast(cashbackat as {{ dbt_utils.type_string() }}) as cashbackat,
    {{ cast_to_boolean('ispreorder') }} as ispreorder,
    {{ cast_to_boolean('isreviewed') }} as isreviewed,
    cast(rejectedat as {{ dbt_utils.type_string() }}) as rejectedat,
    cast(deliveredat as {{ dbt_utils.type_string() }}) as deliveredat,
    cast(deliveringat as {{ dbt_utils.type_string() }}) as deliveringat,
    cast(deliverycode as {{ dbt_utils.type_string() }}) as deliverycode,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(staffapprove as {{ dbt_utils.type_string() }}) as staffapprove,
    cast(teammemberid as {{ dbt_utils.type_string() }}) as teammemberid,
    cast(processstatus as {{ dbt_utils.type_string() }}) as processstatus,
    cast(hooktimelastat as {{ dbt_utils.type_string() }}) as hooktimelastat,
    {{ cast_to_boolean('isassigncoupon') }} as isassigncoupon,
    {{ cast_to_boolean('isautoapproved') }} as isautoapproved,
    cast(outboundrequest as {{ dbt_utils.type_string() }}) as outboundrequest,
    cast(trackingcodeurl as {{ dbt_utils.type_string() }}) as trackingcodeurl,
    cast(waitingcancelby as {{ dbt_utils.type_string() }}) as waitingcancelby,
    {{ cast_to_boolean('ischangedelivery') }} as ischangedelivery,
    cast(estimatecashbackat as {{ dbt_utils.type_string() }}) as estimatecashbackat,
    {{ cast_to_boolean('fromnewactivebuyer') }} as fromnewactivebuyer,
    {{ cast_to_boolean('iswaitingcancelled') }} as iswaitingcancelled,
    {{ cast_to_boolean('fromnewactiveseller') }} as fromnewactiveseller,
    cast(waitingcancelreason as {{ dbt_utils.type_string() }}) as waitingcancelreason,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_ab1') }}
-- orders
where 1 = 1

