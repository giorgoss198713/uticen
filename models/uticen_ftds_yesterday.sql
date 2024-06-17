SELECT  CONCAT_WS('_',min(twb.client_id_brand_day),twb.is_ftd,
twb.type) 
as min_client_id_brand_day, 
twb.client_id_brand,
twb.pool_final,
twb.brand_pool_final
from
sales_uticen.uticen_transactions_with_brand twb
where
twb.type='Deposit'
AND twb.is_ftd is true
AND twb.approved_day =(
CASE WHEN
extract(isodow from (current_timestamp)::date)=1 THEN current_timestamp::date - interval '3 day'
ELSE current_timestamp::date - interval '1 day'
END)
GROUP BY twb.client_id_brand, twb.is_ftd, 
twb.type, twb.pool_final, twb.brand_pool_final