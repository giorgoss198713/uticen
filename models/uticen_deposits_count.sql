select 
client_id_brand, count(id) as deposits_count 
from sales_uticen.uticen_transactions_with_brand
where
type='Deposit'
group by client_id_brand