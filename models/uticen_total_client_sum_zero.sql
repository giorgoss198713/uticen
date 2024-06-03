select twb.client_id_brand,
SUM(twb.usd_amount_with_minus) as total_sum
from sales_uticen.uticen_transactions_with_brand twb
GROUP BY twb.client_id_brand, twb.currency
HAVING (SUM(twb.usd_amount_with_minus)>=0 
AND SUM(twb.usd_amount_with_minus)<10
	   and SUM(twb.usd_amount_with_minus)<>1)