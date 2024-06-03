select twb.client_id_brand, 
twb.client_id_brand_transid_isftd,
count(twb.client_id_brand_transid_isftd) as chargeback_count,
sum(twb.usd_amount_with_minus) as chargeback_sum
from sales_uticen.uticen_transactions_with_brand twb
WHERE
twb.payment_method='Chargeback'
GROUP BY twb.client_id_brand, twb.client_id_brand_transid_isftd
