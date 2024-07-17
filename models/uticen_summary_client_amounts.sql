WITH 
    -- CTE for daily transactions
    daily_transactions AS (
        SELECT
            client_id_brand,
            type,
            CAST(approved_date AS DATE) AS approved_date,
            COUNT(id) AS transaction_count,
            SUM(usd_amount) AS deposit_sum
        FROM
            sales_uticen.uticen_transactions_with_brand
        WHERE
            type = 'Deposit'
            AND isfake IS FALSE
            AND is_ftd IS FALSE
        GROUP BY
            client_id_brand, type, CAST(approved_date AS DATE)
    ),
    -- CTE for previous day transactions
    prev_day_transactions AS (
        SELECT
            client_id_brand,
            SUM(transaction_count) AS deposits_count_prev_day
        FROM
            daily_transactions
        WHERE
            (
                EXTRACT(DOW FROM CURRENT_DATE) = 1 AND approved_date IN (CURRENT_DATE - INTERVAL '3 DAY', CURRENT_DATE - INTERVAL '2 DAY', CURRENT_DATE - INTERVAL '1 DAY')
            ) OR (
                EXTRACT(DOW FROM CURRENT_DATE) != 1 AND approved_date = CURRENT_DATE - INTERVAL '1 DAY'
            )
        GROUP BY
            client_id_brand
    ),
    -- CTE for deposits until previous day
    deposits_until_prev_day AS (
        SELECT
            client_id_brand,
            SUM(deposit_sum) AS deposits_until_prev_day
        FROM
            daily_transactions
        WHERE
            approved_date < CURRENT_DATE - INTERVAL '1 DAY'
        GROUP BY
            client_id_brand
    ),
    -- CTE for deposits until end of two months ago
    deposits_minus_one_interval_month AS (
        SELECT
            client_id_brand,
            SUM(deposit_sum) AS deposits_minus_one_interval_month
        FROM
            daily_transactions
        WHERE
            approved_date < (DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 MONTH')
        GROUP BY
            client_id_brand
    ),
    -- CTE for count of deposits in the previous month
    deposits_count_prev_month AS (
        SELECT
            client_id_brand,
            COUNT(*) AS deposits_count_prev_month
        FROM
            sales_uticen.uticen_transactions_with_brand
        WHERE
            type = 'Deposit'
            AND isfake IS FALSE
            AND is_ftd IS FALSE
            AND approved_date >= (DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 MONTH')
            AND approved_date < DATE_TRUNC('month', CURRENT_DATE)
        GROUP BY
            client_id_brand
    ),
    deposits_prev_month AS (
        SELECT
            client_id_brand,
            SUM(deposit_sum) AS deposits_prev_month
        FROM
            daily_transactions
        WHERE
            approved_date >= (DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 MONTH')
            AND approved_date < DATE_TRUNC('month', CURRENT_DATE)
        GROUP BY
            client_id_brand
    )
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
    SUM(CASE WHEN twb.is_ftd = FALSE THEN COALESCE(twb.usd_amount_with_minus, 0) ELSE 0 END) AS net_deposits_ex_ftd,
    COALESCE(pdt.deposits_count_prev_day, 0) AS deposits_count_prev_day,
    COALESCE(dtpd.deposits_until_prev_day, 0) AS deposits_minus_one_interval_day,
    COALESCE(dmom.deposits_minus_one_interval_month, 0) AS deposits_minus_one_interval_month,
    COALESCE(dcm.deposits_count_prev_month, 0) AS deposits_count_prev_month,
    COALESCE(dpm.deposits_prev_month, 0) AS deposits_prev_month
FROM 
    sales_uticen.uticen_transactions_with_brand twb
LEFT JOIN 
    sales_uticen.uticen_clients_with_brand cl ON cl.client_id_brand = twb.client_id_brand
LEFT JOIN 
    prev_day_transactions pdt ON pdt.client_id_brand = twb.client_id_brand
LEFT JOIN 
    deposits_until_prev_day dtpd ON dtpd.client_id_brand = twb.client_id_brand
LEFT JOIN 
    deposits_minus_one_interval_month dmom ON dmom.client_id_brand = twb.client_id_brand
LEFT JOIN 
    deposits_count_prev_month dcm ON dcm.client_id_brand = twb.client_id_brand
LEFT JOIN 
    deposits_prev_month dpm ON dpm.client_id_brand = twb.client_id_brand
GROUP BY 
    ta_login, client_id, twb.client_id_brand, twb.brand_name, CAST(cl.ftd_date AS DATE), pdt.deposits_count_prev_day, dtpd.deposits_until_prev_day, 
    dmom.deposits_minus_one_interval_month, dcm.deposits_count_prev_month, dpm.deposits_prev_month