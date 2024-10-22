select client, array_agg(login) as login_array
from sales_uticen.trading_accounts
group by client