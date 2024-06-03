SELECT 
twb.language, twb.brand_name, twb.pool_final,
cwb.country, 
--cbd.campaign_name_transformed,
NULL as campaign_name_transformed,
--cbd.live_not_live,
NULL AS live_not_live,
concat_ws('_',twb.brand_name,twb.pool_final) as brand_pool_final,
count(distinct crd.min_client_id_brand_day) AS FTDs,
count(distinct fad.client_id_brand_day) AS "Depositors",
(case when (nfd.client_id_brand_transid_isftd is not null or nfw.client_id_brand_transid_isftd is not null) then 1 else 0 end) AS "Non FTD",
(case when fad1.client_id_brand is not null then 1 else 0 end) AS "anytime_depositor",
sum(nfd.usd_amount) AS "Deposit Amount",
sum(nfW.usd_amount_with_minus) AS "Withdrawal Amount",
sum(ftd.usd_amount) AS "FTD Amount",
COALESCE(sum(nfd.usd_amount)+sum(nfW.usd_amount_with_minus),sum(nfd.usd_amount),sum(nfW.usd_amount_with_minus),0) AS "Net Amount", 
twb.client_id_brand_transid_isftd,
twb.client_id_brand,
cwb.ftd_Date, 
twb.approved_date,
fdb.ftd_bucket, fdb.ftd_bucket_2, fdb.ftd_bucket_3, fdb.ftd_bucket_4
FROM sales_uticen.uticen_transactions_with_brand twb
LEFT JOIN sales_uticen.uticen_conversion_rate_denominator crd ON crd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND crd.row_num=1
LEFT JOIN sales_uticen.uticen_first_approved_date fad ON fad.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND fad.row_num=1
LEFT JOIN sales_uticen.uticen_non_ftd_deposits nfd ON nfd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_non_ftd_withdrawals nfw ON nfw.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_ftd_deposits ftd ON ftd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_clients_with_brand cwb ON cwb.client_id_brand=twb.client_id_brand
--LEFT JOIN public.campaign_brand_dbt cbd ON cbd.campaign_id_brand=cwb.campaign_id_brand
LEFT JOIN sales_uticen.uticen_ftd_amount_buckets fdb ON fdb.client_id_brand=twb.client_id_brand
LEFT JOIN sales_uticen.uticen_first_approved_date fad1 ON fad1.client_id_brand=twb.client_id_brand
WHERE
twb.pool_final NOT IN ('CRM test pool','CRM Test Pool')
GROUP BY 
twb.language, twb.brand_name, twb.pool_final,
twb.client_id_brand_transid_isftd, twb.client_id_brand, cwb.country, 
--cbd.campaign_name_transformed, 
cwb.ftd_date, twb.approved_date, 
fdb.ftd_bucket, fdb.ftd_bucket_2, fdb.ftd_bucket_3, fdb.ftd_bucket_4, nfd.client_id_brand_transid_isftd, nfw.client_id_brand_transid_isftd,
fad1.client_id_brand 
--cbd.live_not_live
--ORDER BY language, brand_name, pool_final