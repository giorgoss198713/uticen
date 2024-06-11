WITH min_dates AS (
    SELECT client, MIN(accepted_at) AS first_call_date
    FROM sales_uticen.calls
    --WHERE client = 1061
    GROUP BY client
)
SELECT 
    ca.client, 
    ca.agent AS first_agent, 
    te.name AS first_pool, 
    ca.accepted_at AS first_call_date
FROM 
    sales_uticen.calls ca
LEFT JOIN 
    sales_uticen.agents ag ON ca.agent = ag.id
LEFT JOIN 
    sales_uticen.users u ON u.id = ag.user_id
LEFT JOIN 
    sales_uticen.teams te ON te.id = ag.team
INNER JOIN 
    min_dates md ON ca.client = md.client AND ca.accepted_at = md.first_call_date
WHERE 
    u.type = 3 
    --AND ca.client = 1061;
