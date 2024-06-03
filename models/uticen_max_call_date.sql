select ca.client, c.brand_name, concat_ws('_',ca.client,c.brand_name) as client_id_brand, cast(max(ca.created_date) as date) as last_call_date
from imports.uticen_calls ca
JOIN sales_uticen.uticen_clients_with_brand c ON ca.client=c.id
JOIN imports.uticen_agents ag ON ag.id=ca.agent
JOIN sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
WHERE
u.type=3
GROUP BY ca.client, c.brand_name