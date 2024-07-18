select 
cat3.client_id_brand, cat3.pool, cat3.brand_name, cat3.ftd_date,  cat3.deposit_last_day, cat3.deposit_five_days_before, cat3.client_in_email_list_cat3,
cat14.deposits, cat14.withdrawals, cat14.net_deposits, cat14.deposits_ex_ftd,  cat14.withdrawals_ex_ftd,  cat14.net_deposits_ex_ftd,
cat14.deposits_count_prev_day, cat14.deposits_minus_one_interval_day, cat14.deposits_minus_one_interval_month, cat14.deposits_count_prev_month,
cat14.deposits_prev_month
from sales_uticen.uticen_marketing_cat3 cat3
LEFT JOIN sales_uticen.uticen_marketing_cat_1_4 cat14 ON cat14.client_id_brand=cat3.client_id_brand