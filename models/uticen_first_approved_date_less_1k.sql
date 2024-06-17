SELECT
    t.client_id_brand_day_time,
  min(t.client_id_brand_day) AS client_id_brand_day_min,
  sum(t.usd_amount) as usd_amount,
  ROW_NUMBER() OVER (PARTITION BY t.client_id_brand_day ORDER BY t.client_id_brand_day) AS row_num
from
  sales_uticen.uticen_transactions_with_brand t
  INNER JOIN sales_uticen.uticen_first_approved_date fa ON fa.client_id_brand_day = t.client_id_brand_day 
WHERE
  t.type = 'Deposit'
  AND t.is_ftd is false
GROUP BY
  t.client_id_brand_day, t.client_id_brand_day_time
  having sum(t.usd_amount)<1000
  AND sum(t.usd_amount )>0