SELECT 
cl.client_id_brand, cl.ftd_date,
(CASE WHEN fad.client_id_brand_day IS NULL THEN 'N' ELSE 'Y' END) as redepositor
FROM sales_uticen.uticen_clients_with_brand cl
LEFT JOIN sales_uticen.uticen_first_approved_date fad on fad.client_id_brand =cl.client_id_brand