select client, agent as first_agent, te.name as first_pool, min(accepted_at) as first_call_date
from imports.uticen_calls ca
LEFT JOIN imports.uticen_agents ag ON ca.agent=ag.id
LEFT JOIN imports.uticen_users u ON u.id=ag.user_id
LEFT JOIN imports.uticen_teams te ON te.id=ag.team
WHERE
u.type=3
group by client, agent, te.name