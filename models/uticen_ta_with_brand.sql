SELECT
  DISTINCT ta.login,
  ta.client,
  twb.brand_name,
  concat_ws('_', twb.client_id, twb.brand_name) as client_id_brand,
  NULL AS balance,
  NULL as abs_balance
FROM sales_uticen.trading_accounts ta
  --LEFT JOIN imports.uticen_trading_accounts_pnl pnl ON pnl.login = ta.login
  JOIN sales_uticen.uticen_transactions_with_brand twb ON ta.client = twb.client_id
--ORDER BY abs(pnl.balance) DESC