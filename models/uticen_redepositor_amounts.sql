SELECT DISTINCT
fad.client_id_brand,
fad.client_id_brand_day,
fad.transaction_date,
sum(twb.usd_amount_with_minus)
FROM
  sales_uticen.uticen_transactions_with_brand twb
  INNER JOIN sales_uticen.uticen_first_approved_date fad
  ON fad.client_id_brand=twb.client_id_brand
WHERE
  twb.is_ftd is false
  AND twb.type IN ('Deposit','Withdrawal')
  group by fad.client_id_brand, fad.client_id_brand_day, fad.transaction_date