SELECT  
twb.client_id_brand,
twb.pool_final,
twb.currency,
twb.usd_amount_with_minus,
twb.brand_pool_final
from
sales_uticen.uticen_transactions_with_brand twb
where
twb.type = 'Withdrawal'
AND twb.is_ftd is false
AND twb.approved_day = (
CASE WHEN 
extract(isodow from (current_timestamp)::date)=1 THEN current_timestamp::date - interval '3 day'
ELSE current_timestamp::date - interval '1 day' END)