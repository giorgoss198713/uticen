SELECT
  min(t.client_id_brand_day) AS client_id_brand_day_min,
  sum(t.usd_amount) as usd_amount
from
  sales_uticen.uticen_transactions_with_brand t
  INNER JOIN sales_uticen.uticen_first_approved_date fa ON fa.client_id_brand_day = t.client_id_brand_day 
WHERE
  t.type  = 'Deposit'
  AND t.is_ftd is false
GROUP BY
  t.client_id_brand_day
  having sum(t.usd_amount)<1000
  AND sum(t.usd_amount )>0