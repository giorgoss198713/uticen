WITH answered_clients AS (
SELECT distinct client, cl.brand_name, concat_ws('_',client,cl.brand_name) as client_id_brand
FROM sales_uticen.calls ca
JOIN sales_uticen.uticen_clients_with_brand cl ON ca.client=cl.id
JOIN sales_uticen.agents ag ON ag.id=ca.agent
JOIN sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
WHERE 
    u.type=3
	AND extract(epoch from (finished_at - accepted_at))::int>=180
	order by client
)
SELECT
    ca.client,
    concat_ws('_', ca.client, cl.brand_name) as client_id_brand,
    cast(cl.ftd_date as date) as ftd_day,
    cast(ca.created_date as date) as call_day,
    count(ca.call_id) as daily_call_count,
    cast(mcd.last_call_date as date) as max_call_date,
    SUM(CASE WHEN ca.call_service = 4 THEN 1 ELSE 0 END) as Atomix_Count,
    SUM(CASE WHEN ca.call_service != 4 THEN 1 ELSE 0 END) as Non_Atomix_Count
FROM sales_uticen.calls ca
JOIN sales_uticen.uticen_clients_with_brand cl ON ca.client=cl.id
JOIN sales_uticen.agents ag ON ag.id=ca.agent
JOIN sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
INNER JOIN sales_uticen.uticen_max_call_date mcd ON mcd.client=ca.client
LEFT JOIN answered_clients ac ON ac.client_id_brand=concat_ws('_',ca.client,cl.brand_name)
WHERE
    u.type=3
    AND extract(epoch from (finished_at - accepted_at))::int < 180
    AND ac.client IS NULL
GROUP BY ca.client, cl.brand_name, cast(ca.created_date as date), cast(cl.ftd_date as date), mcd.last_call_date
ORDER BY cast(ca.created_date as date) desc, ca.client desc
