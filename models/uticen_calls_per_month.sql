SELECT
	cast(c.ftd_date as date) as ftd_date,
	c.full_name as client_name,
    c.id as client_id,
	c.brand_name,
	concat_ws('_',c.id,c.brand_name) as client_id_brand,
	c.age,
	null as work,
	c.gender,
	c.status,
	c.deposit_amount as deposit,
	u1.username as broker,
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE))) THEN 1 END) AS "1",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '1 day') THEN 1 END) AS "2",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '2 days') THEN 1 END) AS "3",
	COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '3 days') THEN 1 END) AS "4",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '4 days') THEN 1 END) AS "5",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '5 days') THEN 1 END) AS "6",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '6 days') THEN 1 END) AS "7",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '7 days') THEN 1 END) AS "8",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '8 days') THEN 1 END) AS "9",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '9 days') THEN 1 END) AS "10",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '10 days') THEN 1 END) AS "11",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '11 days') THEN 1 END) AS "12",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '12 days') THEN 1 END) AS "13",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '13 days') THEN 1 END) AS "14",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '14 days') THEN 1 END) AS "15",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '15 days') THEN 1 END) AS "16",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '16 days') THEN 1 END) AS "17",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '17 days') THEN 1 END) AS "18",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '18 days') THEN 1 END) AS "19",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '19 days') THEN 1 END) AS "20",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '20 days') THEN 1 END) AS "21",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '21 days') THEN 1 END) AS "22",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '22 days') THEN 1 END) AS "23",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '23 days') THEN 1 END) AS "24",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '24 days') THEN 1 END) AS "25",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '25 days') THEN 1 END) AS "26",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '26 days') THEN 1 END) AS "27",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '27 days') THEN 1 END) AS "28",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '28 days') THEN 1 END) AS "29",
	COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '29 days') THEN 1 END) AS "30",
    COUNT(CASE WHEN DATE_TRUNC('day', ca.created_date) = DATE_TRUNC('day', CURRENT_DATE - (CURRENT_DATE - DATE_TRUNC('month', CURRENT_DATE)) + INTERVAL '30 days') THEN 1 END) AS "31"
FROM
    sales_uticen.uticen_clients_with_brand c
 	LEFT JOIN imports.uticen_calls ca ON ca.client=c.id
	LEFT JOIN imports.uticen_agents ag ON ag.id=ca.agent
	LEFT JOIN imports.uticen_agents ag1 ON ag.id=c.retention_agent
	LEFT JOIN sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
	LEFT JOIN sales_uticen.uticen_admin_users u1 ON u1.user_id=ag1.user_id
WHERE
    EXTRACT(MONTH FROM ca.created_date) = EXTRACT(MONTH FROM CURRENT_DATE)
	AND u.type=3
	AND DATE_TRUNC('month', ftd_date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY
    c.id, c.brand_name, c.status, cast(c.ftd_date as date), c.full_name, c.age, c.gender, c.deposit_amount, u1.username
ORDER BY
    cast(c.ftd_date as date)