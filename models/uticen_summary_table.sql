SELECT 
twb.language, twb.brand_name, twb.pool_final, 
concat_ws('_',twb.brand_name,twb.pool_final) as brand_pool_final,
count(distinct crd.min_client_id_brand_day) AS FTDs,
count(distinct fad.client_id_brand_day) AS "Depositors",
sum(nfd.usd_amount) AS "Deposit Amount",
sum(nfw.usd_amount_with_minus) AS "Withdrawal Amount",
COALESCE(sum(nfd.usd_amount)+sum(nfW.usd_amount_with_minus),sum(nfd.usd_amount),sum(nfW.usd_amount_with_minus),0) AS "Net Amount", 
twb.client_id_brand_transid_isftd 
,anf.agent_name, twb.approved_date,
concat_ws('_',twb.brand_name,twb.pool_final,TO_CHAR(cast(twb.approved_date as date), 'Month YYYY')) as brand_pool_month_year
FROM sales_uticen.uticen_transactions_with_brand twb
LEFT JOIN sales_uticen.uticen_conversion_rate_denominator crd ON crd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND crd.row_num=1
LEFT JOIN sales_uticen.uticen_first_approved_date fad ON fad.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND fad.row_num=1
LEFT JOIN sales_uticen.uticen_non_ftd_deposits nfd ON nfd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_non_ftd_withdrawals nfw ON nfw.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_agent_name_ftd anf ON anf.agent_id_brand_day=twb.agent_id_brand_day
WHERE
pool_final NOT IN ('CRM test pool','CRM Test Pool')
GROUP BY twb.language, twb.brand_name, twb.pool_final,
twb.client_id_brand_transid_isftd,
anf.agent_name, twb.approved_date