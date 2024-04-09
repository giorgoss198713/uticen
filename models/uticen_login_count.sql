select client, count(login) as login_count from imports.uticen_trading_accounts
group by client