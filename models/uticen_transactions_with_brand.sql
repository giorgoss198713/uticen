select distinct
t.id,
tra.client AS client_id, 
tra.login AS ta_login,
t.currency,
t.amount,
t. usd_conversion_rate*amount as usd_amount,
false AS frombm,
t.status,
t.created_date,
to_char(t.created_date, 'HH24:MI') as created_time,
t.inserted_date approved_date,
to_char(t.inserted_date, 'HH24:MI') as approved_time,
CAST(t.inserted_date as date) as approved_day,
false AS isfake,
t.type,
case when sub_type iLIKE '%Ftd%' THEN true else false END AS is_ftd,
cl.pool AS current_pool_transformed,
te.name AS pool_transformed,
to_jsonb(psp_details::json)->>'paymentMethod' as payment_method,
to_jsonb(psp_details::json)->>'pspName' as psp_name, -- EXTRA COLUMN
INITCAP(div.name) AS desk_manager,
grp.name AS group_manager, --EXTRA COLUMN
CASE WHEN cl.language='en' THEN 'ENG' ELSE cl.language END AS language,
cl.brand_name AS brand_name,
NULL AS psp_id_brand,
concat_ws('_',tra.client,cl.brand_name) AS client_id_brand,
NULL AS ta_id_brand,
NULL AS fundprocessor_id_brand,
concat_ws('_',cl.brand_name,te.name) AS brand_pool,
t.agent,
concat_ws('_',t.agent,cl.brand_name) AS agent_id_brand,
concat_ws('_',tra.client,cl.brand_name,CAST(t.inserted_date as date)) AS client_id_brand_day,
NULL AS client_id_brand_day_time,
concat_ws('_',t.agent,cl.brand_name,t.id,false)  AS client_id_brand_transid_isftd,
NULL AS client_id_brand_day_isftd, --ATTENTION
NULL AS client_id_brand_day_isftd_type, --ATTENTION
concat_ws('_',t.agent, cl.brand_name) AS agent_id_brand_final, --ATTENTION FULL LOGIC
concat_ws('_',t.agent,cl.brand_name,CAST(t.inserted_date as date)) AS agent_id_brand_day,
cl.pool AS pool_final, --ATTENTION WAITING FOR FIX
CASE WHEN te.name IS NOT NULL THEN concat_ws('_',cl.brand_name,te.name) ELSE NULL END AS brand_pool_final,
CASE WHEN t.type = 'Withdrawal' THEN - t. usd_conversion_rate*amount ELSE t. usd_conversion_rate*amount END as usd_amount_with_minus,
NULL::bigint AS answered_binary, --ATTENTION, CLIENTS?
concat_ws('_',u.username,cl.brand_name, to_char(t.inserted_date, 'FMMonth YYYY')) as username_brand_date,
concat_ws('-',u.username,cl.brand_name) as username_brand,
EXTRACT(WEEK FROM t.inserted_date) - EXTRACT(WEEK FROM DATE_TRUNC('month', t.inserted_date)) + 1 AS week_of_month,
CASE EXTRACT(DOW FROM t.inserted_date)
    WHEN 0 THEN '7. Sunday'
    WHEN 1 THEN '1. Monday'
    WHEN 2 THEN '2. Tuesday'
    WHEN 3 THEN '3. Wednesday'
    WHEN 4 THEN '4. Thursday'
    WHEN 5 THEN '5. Friday'
    WHEN 6 THEN '6. Saturday'
    END AS day_of_week
FROM sales_uticen.transactions t
left join sales_uticen.trading_accounts tra on t.trading_account = tra.id
left join sales_uticen.uticen_clients_with_brand cl on tra.client = cl.id
left join sales_uticen.agents ag on ag.id = t.agent
left join sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
left join sales_uticen.teams te on ag.team = te.id
left join sales_uticen.groups grp on grp.id = te.group_id
left join sales_uticen.divisions div on div.id = grp.division
where
t.status='Approved'
AND t.type NOT IN ('Returned')

UNION ALL

select
(to_jsonb(transaction_details::json)->>'id')::bigint as id,
cl.id as client_id, 
tra.login AS ta_login,
to_jsonb(transaction_details::json)->>'currency' as currency,
ui.amount,
(to_jsonb(transaction_details::json)->>'amountInUsd')::double precision as usd_amount,
true AS frombm,
to_jsonb(transaction_details::json)->>'status' as status,
(to_timestamp((transaction_details::jsonb ->> 'createdDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp as created_date,
to_char((to_timestamp((transaction_details::jsonb ->> 'createdDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp, 'HH24:MI') as created_time,
(to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp as approved_date,
to_char((to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp, 'HH24:MI') as approved_time,
CAST((to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp as date) as approved_day,
((to_jsonb(transaction_details::json)->>'isAllFake'))::boolean as is_fake,
to_jsonb(transaction_details::json)->>'type' as type,
true as is_ftd,
cl.pool as current_pool_transformed,
cl.first_calling_pool_transformed as pool_transformed,
to_jsonb(transaction_details::json)->>'paymentMethod' as payment_method,
to_jsonb(transaction_details::json)->>'psp' as psp_name,
INITCAP(div.name) AS desk_manager,
grp.name AS group_manager,
CASE WHEN cl.language='en' THEN 'ENG' ELSE cl.language END AS language,
cl.brand_name AS brand_name,
NULL AS psp_id_brand,
concat_ws('_',tra.client,cl.brand_name) AS client_id_brand,
NULL AS ta_id_brand,
NULL AS fundprocessor_id_brand,
concat_ws('_',cl.brand_name,te.name) AS brand_pool,
cl.first_calling_agent as agent,
concat_ws('_',cl.first_calling_agent,cl.brand_name) AS agent_id_brand,
concat_ws('_',tra.client,cl.brand_name,CAST((to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp as date)) AS client_id_brand_day,
NULL AS client_id_brand_day_time,
concat_ws('_',cl.id,cl.brand_name,(to_jsonb(transaction_details::json)->>'id'),true) AS client_id_brand_transid_isftd, --ATTENTION
NULL AS client_id_brand_day_isftd, --ATTENTION
NULL AS client_id_brand_day_isftd_type, --ATTENTION
concat_ws('_',cl.first_calling_agent,cl.brand_name) AS agent_id_brand_final, --ATTENTION FULL LOGIC
concat_ws('_',cl.first_calling_agent,cl.brand_name,CAST((to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp as date)) AS agent_id_brand_day,
cl.pool AS pool_final, --ATTENTION WAITING FOR FIX
CASE WHEN te.name IS NOT NULL THEN concat_ws('_',cl.brand_name,te.name) ELSE NULL END AS brand_pool_final,
(to_jsonb(transaction_details::json)->>'amountInUsd')::double precision as usd_amount_with_minus,
NULL::bigint AS answered_binary, --ATTENTION, CLIENTS?
concat_ws('_',u.username,cl.brand_name, to_char((to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp, 'FMMonth YYYY')) as username_brand_date,
concat_ws('-',u.username,cl.brand_name) as username_brand,
EXTRACT(WEEK FROM (to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp) - 
EXTRACT(WEEK FROM DATE_TRUNC('month', (to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp)) + 1 AS week_of_month,
CASE EXTRACT(DOW FROM (to_timestamp((transaction_details::jsonb ->> 'createdDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp)
    WHEN 0 THEN '7. Sunday'
    WHEN 1 THEN '1. Monday'
    WHEN 2 THEN '2. Tuesday'
    WHEN 3 THEN '3. Wednesday'
    WHEN 4 THEN '4. Thursday'
    WHEN 5 THEN '5. Friday'
    WHEN 6 THEN '6. Saturday'
    END AS day_of_week
from sales_uticen.incentives ui
left join sales_uticen.trading_accounts tra on ui.trading_account = tra.id
left join sales_uticen.uticen_clients_with_brand cl on tra.client = cl.id
left join sales_uticen.agents ag on ag.id = cl.first_calling_agent
left join sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
left join sales_uticen.teams te on cl.first_calling_pool_transformed = te.name
left join sales_uticen.groups grp on grp.id = te.group_id
left join sales_uticen.divisions div on div.id = grp.division
where
reason=1
AND ui.status='Credited'
AND ui.type='Balance'
AND to_jsonb(transaction_details::json)->>'status'='Approved'
AND cl.first_calling_pool_transformed is not null