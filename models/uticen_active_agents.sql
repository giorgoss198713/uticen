WITH summary_agent_temp AS (SELECT twb.brand_name, twb.pool_final, anf.agent_name,
concat_ws('_',twb.brand_name,twb.pool_final) as brand_pool_final,
concat_ws('_',twb.brand_name,anf.agent_name) as brand_agent_final,					
count(distinct crd.min_client_id_brand_day) AS FTDs,
count(cdr_id) as calls_count,
twb.client_id_brand_transid_isftd,
twb.approved_day
FROM sales_uticen.uticen_transactions_with_brand twb
LEFT JOIN sales_uticen.uticen_conversion_rate_denominator crd ON crd.client_id_brand_transid_isftd=twb.client_id_brand_transid_isftd
    AND crd.row_num=1
LEFT JOIN sales_uticen.uticen_agent_name_final anf ON anf.agent_id_brand_final=twb.agent_id_brand_final
LEFT JOIN sales_uticen.uticen_calls_count_all ca ON concat_ws('_',anf.agent_name,twb.brand_name,twb.approved_day)=concat_ws('_',ca.username, ca.brand_name,cast(ca.created_date as date))				
GROUP BY twb.brand_name, twb.pool_final, anf.agent_name,
twb.client_id_brand_transid_isftd, twb.approved_day)

SELECT
    COUNT(DISTINCT agent_name) AS distinct_agents_count,
    CONCAT(brand_name, '_', pool_final, '_', TO_CHAR(approved_day, 'Month YYYY')) AS brand_pool_month_year
FROM
    summary_agent_temp
WHERE
(FTDs =1 OR calls_count>0)
GROUP BY
    brand_pool_month_year
ORDER BY
    brand_pool_month_year
