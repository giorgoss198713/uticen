SELECT 
    ta_login AS login, 
    client_id, 
    twb.client_id_brand, 
    twb.brand_name, 
    CAST(cl.ftd_date AS DATE) AS ftd_date,
    SUM(CASE WHEN twb.type = 'Deposit' THEN twb.usd_amount ELSE 0 END) AS deposits,
    SUM(CASE WHEN twb.type = 'Withdrawal' THEN twb.usd_amount_with_minus ELSE 0 END) AS withdrawals,
    SUM(twb.usd_amount_with_minus) AS net_deposits,
    SUM(CASE WHEN twb.type = 'Deposit' AND twb.is_ftd = FALSE THEN twb.usd_amount ELSE 0 END) AS deposits_ex_ftd,
    SUM(CASE WHEN twb.type = 'Withdrawal' AND twb.is_ftd = FALSE THEN twb.usd_amount_with_minus ELSE 0 END) AS withdrawals_ex_ftd,
    SUM(CASE WHEN twb.is_ftd = FALSE THEN COALESCE(twb.usd_amount_with_minus, 0) ELSE 0 END) AS net_deposits_ex_ftd
FROM 
    sales_uticen.uticen_transactions_with_brand twb
LEFT JOIN 
    sales_uticen.uticen_clients_with_brand cl ON cl.client_id_brand = twb.client_id_brand
GROUP BY 
    ta_login, client_id, twb.client_id_brand, twb.brand_name, CAST(cl.ftd_date AS DATE)