SELECT DISTINCT CONCAT_WS('_',min(t.client_id_brand_day), t.is_ftd, t.type) as min_client_id_brand_day, 
t.client_id_brand,
t.agent_id_brand_final,
concat_ws('_',t.client_id,t.agent_id_brand_final) as client_agent_id_brand
from
sales_uticen.uticen_transactions_with_brand t
where
t.type ='Deposit'
AND t.is_ftd is true
GROUP BY client_id_brand, is_ftd, type, t.client_id, t.agent_id_brand_final