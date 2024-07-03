SELECT 
    cl.client_id_brand,
    MAX(nfd.approved_date) AS last_deposit_date,
    CASE 
        WHEN MAX(nfd.approved_date) >= NOW() - INTERVAL '7 DAYS' THEN TRUE
        ELSE FALSE
    END AS deposit_last_week
FROM 
    sales_uticen.uticen_clients_with_brand cl
LEFT JOIN 
    sales_uticen.uticen_non_ftd_deposits nfd ON cl.client_id_brand = nfd.client_id_brand
GROUP BY 
    cl.client_id_brand