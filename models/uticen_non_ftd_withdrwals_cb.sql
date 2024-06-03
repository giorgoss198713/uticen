SELECT
twb.client_id_brand_transid_isftd,
twb.usd_amount_with_minus
FROM
  sales_uticen.uticen_transactions_with_brand twb
  LEFT JOIN sales_uticen.uticen_chargeback_clients_transactions cct
  ON twb.client_id_brand_transid_isftd = cct.client_id_brand_transid_isftd
  LEFT JOIN sales_uticen.uticen_refunded_clients_transactions rft
  ON twb.client_id_brand_transid_isftd = rft.client_id_brand_transid_isftd
    WHERE
  twb.is_ftd = 'f'
  AND twb.type = 'Withdrawal'
  AND cct.client_id_brand_transid_isftd IS NULL
  AND rft.client_id_brand_transid_isftd IS NULL