select distinct
cl.id as client_id,
CAST((to_timestamp((transaction_details::jsonb ->> 'approvedDate')::text, 'YYYY-MM-DD HH24:MI:SS') AT TIME ZONE 'UTC')::timestamp as date) as ftd_date
from imports.uticen_incentives ui
left join imports.uticen_trading_accounts tra on ui.trading_account = tra.id
left join imports.uticen_clients cl on tra.client = cl.id
where
reason=1
AND ui.status='Credited'
AND ui.type='Balance'
AND to_jsonb(transaction_details::json)->>'status'='Approved'
order by cl.id