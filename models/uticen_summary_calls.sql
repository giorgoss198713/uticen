WITH distinct_rows AS (
SELECT DISTINCT client, agent, extract(epoch from (finished_at - accepted_at))::int as duration, created_date, status
from imports.uticen_calls
)
select 
CAST(dr.created_date as date) AS created_day, u.username, NULL AS agent_name, concat_ws('_',dr.agent,c.brand_name) as agent_id_brand,
c.brand_name, c.pool,
SUM(CASE WHEN dr.duration > 180 THEN dr.duration ELSE 0 END) as total_duration,
EXTRACT(HOUR FROM INTERVAL '1 second' * SUM(CASE WHEN dr.duration > 180 THEN dr.duration ELSE 0 END)) AS hours,
EXTRACT(MINUTE FROM INTERVAL '1 second' * SUM(CASE WHEN dr.duration > 180 THEN dr.duration ELSE 0 END)) AS minutes,
DATE_PART('SECOND', INTERVAL '1 second' * SUM(CASE WHEN dr.duration > 180 THEN dr.duration ELSE 0 END)) AS seconds,
 CONCAT(
        TO_CHAR(EXTRACT(HOUR FROM INTERVAL '1 second' * SUM(CASE WHEN duration > 180 THEN duration ELSE 0 END)), 'FM00'),
        ':',
        TO_CHAR(EXTRACT(MINUTE FROM INTERVAL '1 second' * SUM(CASE WHEN duration > 180 THEN duration ELSE 0 END)), 'FM00'),
        ':',
        TO_CHAR(DATE_PART('SECOND', INTERVAL '1 second' * SUM(CASE WHEN duration > 180 THEN duration ELSE 0 END)), 'FM00')
    ) AS formatted_total_duration
from distinct_rows dr
JOIN sales_uticen.uticen_clients_with_brand c ON dr.client=c.id
JOIN imports.uticen_agents ag ON ag.id=dr.agent
JOIN sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
--JOIN imports.uticen_user_types ut ON u.type=ut.id
--AND u.type IN ('1','4','7','12')
--webphone_status IN ('ANSWERED','callEnded','inCall')
where
c.full_name NOT iLIKE '%test%'
AND c.full_name NOT iLIKE '% test%'
AND c.full_name NOT iLIKE '%test %'
AND u.type=3
GROUP BY created_day, dr.agent, c.brand_name, c.pool, u.username
HAVING SUM(CASE WHEN duration > 180 THEN duration ELSE 0 END)>0
