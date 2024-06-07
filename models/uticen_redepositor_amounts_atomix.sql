SELECT DISTINCT
twb.client_id_brand_transid_isftd,
fad.client_id_brand,
twb.approved_date,
twb.usd_amount_with_minus
FROM
  sales_uticen.uticen_transactions_with_brand twb
  INNER JOIN sales_uticen.uticen_first_approved_date fad
  ON fad.client_id_brand=twb.client_id_brand
WHERE
  twb.is_ftd is false
  AND twb.type IN ('Deposit','Withdrawal')