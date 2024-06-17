SELECT DISTINCT 
    twb.client_id_brand,
    twb.ta_login as login,
    COUNT(CASE WHEN twb.type = 'Withdrawal' AND DATE_TRUNC('month', twb.approved_day) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') THEN twb.id ELSE NULL END) AS number_withdrawals_1_month_ago,
    CASE 
        WHEN COUNT(CASE WHEN twb.type = 'Withdrawal' AND DATE_TRUNC('month', twb.approved_day) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') THEN twb.id ELSE NULL END) > 0 
        THEN 'Yes' 
        ELSE 'No' 
    END AS status_withdrawals_1_month_ago,
    
    COUNT(CASE WHEN twb.type = 'Withdrawal' AND DATE_TRUNC('month', twb.approved_day) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '2 month') THEN twb.id ELSE NULL END) AS number_withdrawals_2_months_ago,
    CASE 
        WHEN COUNT(CASE WHEN twb.type = 'Withdrawal' AND DATE_TRUNC('month', twb.approved_day) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '2 month') THEN twb.id ELSE NULL END) > 0 
        THEN 'Yes' 
        ELSE 'No' 
    END AS status_withdrawals_2_months_ago,

    COUNT(CASE WHEN twb.type = 'Withdrawal' AND DATE_TRUNC('month', twb.approved_day) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '3 month') THEN twb.id ELSE NULL END) AS number_withdrawals_3_months_ago,
    CASE 
        WHEN COUNT(CASE WHEN twb.type = 'Withdrawal' AND DATE_TRUNC('month', twb.approved_day) = DATE_TRUNC('month', CURRENT_DATE - INTERVAL '3 month') THEN twb.id ELSE NULL END) > 0 
        THEN 'Yes' 
        ELSE 'No' 
    END AS status_withdrawals_3_months_ago

FROM
sales_uticen.uticen_transactions_with_brand twb
--left join sales.trading_accounts tr
--ON twb.client_id_brand=concat_ws('_',tr.client_id,tr.brand_name)
WHERE
    twb.ta_login <> -1
GROUP BY 
    twb.client_id_brand, 
    twb.ta_login