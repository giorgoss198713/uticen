SELECT
    NULL AS cdr_id,
    client,
    client_id_brand,
    brand_name,
    pool,
    agent,
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
    MAX(CASE WHEN call_result = 'Conversation Successful' THEN 1 ELSE 0 END) AS conversation_successful_count,
    MAX(CASE WHEN call_result = 'No Answer' THEN 1 ELSE 0 END) AS no_answer_count,
    MAX(CASE WHEN call_result = 'Answered Short Conversation' THEN 1 ELSE 0 END) AS answered_short_conversation_count,
    MAX(CASE WHEN call_result = 'Call Failed' THEN 1 ELSE 0 END) AS call_failed_count
FROM
    (
        SELECT
            NULL AS cdr_id,
            ca.client,
            concat_ws('_', ca.client, cl.brand_name) AS client_id_brand,
            cl.brand_name,
            cl.pool,
            ca.agent,
            extract(epoch from (finished_at - accepted_at))::int as duration,
            ca.created_date,
            ca.status,
            NULL call_type,
            u.username,
            u.type,
            (CASE 
                WHEN extract(epoch from (finished_at - accepted_at))::int > 180 THEN 'Conversation Successful'
                WHEN ca.status IN ('Not Answer') THEN 'No Answer'
                WHEN extract(epoch from (finished_at - accepted_at))::int <= 180 AND ca.status IN ('Finished') THEN 'Answered Short Conversation'
                WHEN extract(epoch from (finished_at - accepted_at))::int <= 180 AND ca.status NOT IN ('Failed', 'Rejected', 'In progress') THEN 'Call Failed'
            END) AS call_result
        FROM
            imports.uticen_calls ca
            JOIN sales_uticen.uticen_clients_with_brand cl ON ca.client=cl.id
			JOIN imports.uticen_agents ag ON ag.id=ca.agent
			JOIN sales_uticen.uticen_admin_users u ON u.user_id=ag.user_id
        WHERE 
            u.type=3
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
    type
ORDER BY
    created_date DESC

