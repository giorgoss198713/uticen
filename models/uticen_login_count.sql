select client, count(login) as login_count 
from sales_uticen.trading_accounts
group by client