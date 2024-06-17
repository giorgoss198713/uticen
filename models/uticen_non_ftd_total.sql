select 
twb.client_id_brand,
sum(twb.usd_amount) as sum_usd_amount
FROM sales_uticen.uticen_transactions_with_brand twb
where
twb.type='Deposit'
AND twb.is_ftd is false
GROUP BY twb.client_id_brand