SELECT DISTINCT 
twb.usd_amount_with_minus,
twb.client_id_brand_transid_isftd,
twb.client_id_brand,
twb.approved_date
FROM
sales_uticen.uticen_transactions_with_brand twb
WHERE
  twb.is_ftd is false
  AND twb.type ='Withdrawal'