select client, min(accepted_at) as first_call_date, max(accepted_at) as last_call_date, count(created_date) as attempted_calls, count(accepted_at) as answered_calls
from sales_uticen.calls
group by client