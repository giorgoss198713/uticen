SELECT
DISTINCT 
twb.client_id_brand,
twb.approved_date,
twb.usd_amount
FROM
sales_uticen.uticen_transactions_with_brand twb
INNER JOIN sales_uticen.uticen_conversion_rate_denominator crd on crd.client_id_brand = twb.client_id_brand
WHERE
  twb.is_ftd is false
  AND twb.type = 'Deposit'