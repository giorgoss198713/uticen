SELECT cast(cl.ftd_date as date) ftd_day, cl.pool, COUNT(na.client) AS client_count,
cl.status, cl.brand_name, na.max_call_date, na.total_atomix_count, cl.client_in_atomix
FROM sales_uticen.uticen_clients_with_brand cl
LEFT JOIN (
    SELECT client_id_brand, client, SUM(daily_call_count) AS total_call_count, max_call_date,
    sum(atomix_count) as total_atomix_count
    FROM sales_uticen.uticen_non_answering_clients_all
    GROUP BY client_id_brand, client, max_call_date
    HAVING SUM(daily_call_count) < 10
) na ON cl.client_id_brand = na.client_id_brand
GROUP BY cl.pool, cast(cl.ftd_date as date), cl.status, cl.brand_name, na.max_call_date, na.total_atomix_count, cl.client_in_atomix