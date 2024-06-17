SELECT twb.brand_name, twb.pool_final, anf.agent_name,
concat_ws('_',twb.brand_name,twb.pool_final) as brand_pool_final,
count(distinct crd.min_client_id_brand_day) AS FTDs,
count(distinct fad.client_id_brand_day) AS "Depositors",
count(distinct fam.client_id_brand_day_min) AS "New Depositors more 1k",
count(distinct fal.client_id_brand_day_min) AS "New Depositors less 1k",
count(distinct fad.client_id_brand_day) AS "New Depositors Total",
sum(nfd.usd_amount) AS "Deposit Amount",
sum(nfW.usd_amount_with_minus) AS "Withdrawal Amount",
COALESCE(sum(nfd.usd_amount)+sum(nfW.usd_amount_with_minus),sum(nfd.usd_amount),sum(nfW.usd_amount_with_minus),0) AS "Net Amount", 
twb.client_id_brand_transid_isftd
FROM sales_uticen.uticen_transactions_with_brand twb
LEFT JOIN sales_uticen.uticen_conversion_rate_denominator crd ON crd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND crd.row_num=1
LEFT JOIN sales_uticen.uticen_first_approved_date fad ON fad.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND fad.row_num=1
LEFT JOIN sales_uticen.uticen_first_approved_date_more_1k fam ON fam.client_id_brand_day_min=twb.client_id_brand_day
    AND fad.row_num=1
LEFT JOIN sales_uticen.uticen_first_approved_date_less_1k fal ON fal.client_id_brand_day_min=twb.client_id_brand_day
    AND fal.row_num=1
LEFT JOIN sales_uticen.uticen_non_ftd_deposits nfd ON nfd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_non_ftd_withdrawals nfw ON nfw.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_agent_name_final anf ON anf.agent_id_brand_final=twb.agent_id_brand_final
    AND concat_ws('_',anf.agent_name,brand_name) NOT IN ('marchandgu_fundiza','mickaelsh_fundiza','williamsan_fundiza','terenzigi_fundiza','adamnelson_fundiza',
    'morisqa_fundiza','bergercha_fundiza','mooredo_fundiza','dubreuilal_fundiza','lerun_fundiza', 'tandashvilimi_fundiza') 
WHERE
pool_final NOT IN ('CRM test pool','CRM Test Pool')
GROUP BY twb.brand_name, twb.pool_final, anf.agent_name,
twb.client_id_brand_transid_isftd