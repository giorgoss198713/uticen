WITH identify_clients AS (SELECT cl.client_id_brand, cl.status,
cl.ftd_date, cl.brand_name, cl.pool,
tsz.total_sum, twb.usd_amount
FROM sales_uticen.uticen_clients_with_brand cl
LEFT JOIN sales_uticen.uticen_total_client_sum_zero tsz ON tsz.client_id_brand=cl.client_id_brand
LEFT JOIN sales_uticen.uticen_transactions_with_brand twb ON twb.client_id_brand=cl.client_id_brand
AND twb.type='Deposit'
AND twb.is_ftd is true
where
(cl.status IN ('Refunded ','Do Not Call','Refunded','REFUNDED','refunded','REFUNDED ', 'refunded ')
OR tsz.total_sum<10))

SELECT 
identify_clients.client_id_brand,
twb.client_id_brand_transid_isftd,
max(twb.approved_date) as max_wd_date,
twb.usd_amount_with_minus
from identify_clients
inner join sales_uticen.uticen_transactions_with_brand twb ON identify_clients.client_id_brand=twb.client_id_brand
where
twb.type='Withdrawal'
group by identify_clients.client_id_brand, twb.client_id_brand_transid_isftd, twb.usd_amount_with_minus