SELECT
    NULL AS cdr_id,
    client,
    client_id_brand,
    brand_name,
    pool,
    agent::text,
    duration,
    EXTRACT(HOUR FROM INTERVAL '1 second' * duration) AS hours,
	EXTRACT(MINUTE FROM INTERVAL '1 second' * duration) AS minutes,
	DATE_PART('SECOND', INTERVAL '1 second' * duration) AS seconds,
	--DATE_PART('SECOND', INTERVAL '1 second' * duration) AS seconds,
	CONCAT(
        TO_CHAR(EXTRACT(HOUR FROM INTERVAL '1 second' * duration), 'FM00'),
        ':',
        TO_CHAR(EXTRACT(MINUTE FROM INTERVAL '1 second' * duration), 'FM00'),
        ':',
        TO_CHAR(DATE_PART('SECOND', INTERVAL '1 second' * duration), 'FM00')
		) as formatted_duration,
    created_date,
    status,
    NULL AS call_type,
    username,
    type,
    case when user_type='agent' then 'Retention Agent' else user_type END AS user_type,
    MAX(CASE WHEN call_result = 'Conversation Successful' THEN 1 ELSE 0 END)::bigint AS conversation_successful_count,
    MAX(CASE WHEN call_result = 'No Answer' THEN 1 ELSE 0 END)::bigint AS no_answer_count,
    MAX(CASE WHEN call_result = 'Answered Short Conversation' THEN 1 ELSE 0 END)::bigint AS answered_short_conversation_count,
    MAX(CASE WHEN call_result = 'Call Failed' THEN 1 ELSE 0 END)::bigint AS call_failed_count
FROM
    (
        SELECT
            NULL AS cdr_id,
            ca.client,
            concat_ws('_', ca.client, cl.brand_name) AS client_id_brand,
            cl.brand_name,
            cl.pool,
			u.user_id as agent,
            --ca.agent,
            extract(epoch from (finished_at - accepted_at))::int as duration,
            ca.created_date,
            ca.status,
            NULL call_type,
            u.username,
            u.type,
            u.user_type,
            (CASE 
                WHEN extract(epoch from (finished_at - accepted_at))::int > 180 THEN 'Conversation Successful'
                WHEN ca.status IN ('Not Answer') THEN 'No Answer'
                WHEN extract(epoch from (finished_at - accepted_at))::int <= 180 AND ca.status IN ('Finished') THEN 'Answered Short Conversation'
                WHEN extract(epoch from (finished_at - accepted_at))::int <= 180 AND ca.status NOT IN ('Failed', 'Rejected', 'In progress') THEN 'Call Failed'
            END) AS call_result
        FROM
            sales_uticen.calls ca
            JOIN sales_uticen.uticen_clients_with_brand cl ON ca.client=cl.id
			--JOIN sales_uticen.agents ag ON ag.id=ca.agent
			--JOIN sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
			JOIN sales_uticen.uticen_admin_users u ON u.user_id=ca.caller
            JOIN sales_uticen.agents ag ON ag.user_id=u.user_id
        WHERE 
            u.type=3
			--AND cl.id=1813
    ) AS subquery
GROUP BY
    client,
    client_id_brand,
    brand_name,
    pool,
    agent,
    duration,
    created_date,
    status,
    username,
    type,
    user_type
ORDER BY
    created_date DESC