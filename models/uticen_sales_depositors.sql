SELECT
concat_ws(' ',twb.brand_name,twb.language) as brand_desk,
cwb.client_id_brand,
cwb.id as client_id,
(CASE WHEN cwb.ftd_date IS NULL
-- OR WHEN rb.client_id_brand IS NOT NULL 
THEN 'Referral'
ELSE
'FTD'
END) as referral,
twb.language, twb.brand_name, 
cwb.full_name as Client,
twb.pool_final,
cwb.country,
cwb.ftd_date::date,
fad.transaction_date as first_deposit_date,
(fad.transaction_date::date-cwb.ftd_date::date) as total_days_ftd_to_deposit,
(CASE WHEN (fad.transaction_date::date-cwb.ftd_date::date)<20
--AND rb.client_id_brand IS NULL
THEN 'HOT'
WHEN cwb.ftd_date IS NULL
--OR rb.client_id_brand IS NOT NULL
THEN 'REFERRAL'
WHEN (fad.transaction_date::date-cwb.ftd_date::date)>=20 
--AND rb.client_id_brand IS NULL
THEN 'COLD'
END) as hot_or_cold,
(CASE WHEN (fad.transaction_date::date-cwb.ftd_date::date)<20 
--AND rb.client_id_brand IS NULL 
AND nft.sum_usd_amount<=999
THEN 'LOWEST'
WHEN (fad.transaction_date::date-cwb.ftd_date::date)<20 
--AND rb.client_id_brand IS NULL 
AND nft.sum_usd_amount>999 AND nft.sum_usd_amount<=1499
THEN 'LOW'
WHEN (fad.transaction_date::date-cwb.ftd_date::date)<20 
--AND rb.client_id_brand IS NULL 
 AND nft.sum_usd_amount>1499 AND nft.sum_usd_amount<=4499
THEN 'NORMAL'
WHEN (fad.transaction_date::date-cwb.ftd_date::date)<20 
--AND rb.client_id_brand IS NULL 
AND nft.sum_usd_amount>4499
THEN 'HIGH'
ELSE 'FALSE'
END) as priority,
NULL AS campaign_name,
--cbd.campaign_name_transformed as campaign_name,
nft.sum_usd_amount as total_deposits_usd
FROM sales_uticen.uticen_transactions_with_brand twb
INNER JOIN sales_uticen.uticen_first_approved_date fad ON fad.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND fad.row_num=1
LEFT JOIN sales_uticen.uticen_non_ftd_deposits nfd ON nfd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
LEFT JOIN sales_uticen.uticen_clients_with_brand cwb ON cwb.client_id_brand=twb.client_id_brand
--LEFT JOIN public.campaign_brand_dbt cbd ON cbd.campaign_id_brand=cwb.campaign_id_brand
LEFT JOIN sales_uticen.uticen_non_ftd_total nft ON nft.client_id_brand=twb.client_id_brand
--LEFT JOIN public.persisted_referral_brand rb ON rb.client_id_brand=twb.client_id_brand
WHERE
pool_final NOT IN ('CRM test pool','CRM Test Pool')
ORDER BY cwb.id