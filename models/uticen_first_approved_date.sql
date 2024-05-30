SELECT DISTINCT
  twb.client_id_brand_day,
  twb.client_id_brand,
  twb.approved_day as transaction_date,
  cl.ftd_date,
  NULL as ftd_date_referral,
  twb.agent_id_brand_final,
  NULL as client_agent_id_brand,
  sum(twb.usd_amount) as usd_amount
FROM
  sales_uticen.uticen_transactions_with_brand twb
 LEFT JOIN (SELECT DISTINCT ftd_date, client_id_brand
from
sales_uticen.uticen_clients_with_brand
) cl
	  ON cl.client_id_brand=twb.client_id_brand 
WHERE
  twb.client_id_brand_day IN (
    select
      MIN(twb1.client_id_brand_day)
    from
      sales_uticen.uticen_transactions_with_brand twb1
    WHERE
      twb1.is_ftd is false
      AND twb1.status = 'Approved'
      AND twb1.type = 'Deposit'
    GROUP BY
      twb1.client_id_brand
  )
  AND twb.is_ftd is false
  AND twb.status ='Approved'
  AND twb.type = 'Deposit'
GROUP BY twb.client_id_brand_day, twb.client_id_brand, twb.approved_day, cl.ftd_date, twb.agent_id_brand_final, twb.client_id