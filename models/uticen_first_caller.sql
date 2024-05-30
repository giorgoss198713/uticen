WITH min_dates AS (
    SELECT client, MIN(accepted_at) AS first_call_date
    FROM imports.uticen_calls
    --WHERE client = 1061
    GROUP BY client
)
SELECT 
    ca.client, 
    ca.agent AS first_agent, 
    te.name AS first_pool, 
    ca.accepted_at AS first_call_date
FROM 
    imports.uticen_calls ca
LEFT JOIN 
    imports.uticen_agents ag ON ca.agent = ag.id
LEFT JOIN 
    imports.uticen_users u ON u.id = ag.user_id
LEFT JOIN 
    imports.uticen_teams te ON te.id = ag.team
INNER JOIN 
    min_dates md ON ca.client = md.client AND ca.accepted_at = md.first_call_date
WHERE 
    u.type = 3 
    --AND ca.client = 1061;
