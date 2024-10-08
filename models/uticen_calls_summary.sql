select client, min(accepted_at) as first_call_date, max(accepted_at) as last_call_date, count(ca.created_date) as attempted_calls, count(accepted_at) as answered_calls
from sales_uticen.calls ca
JOIN sales_uticen.uticen_admin_users u ON u.user_id=ca.caller
JOIN sales_uticen.agents ag ON ag.user_id=u.user_id
WHERE
u.type=3
group by client