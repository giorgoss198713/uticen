SELECT
    cl.id as client_id,
    cl.client_id_brand,
	cl.pool,
    cl.brand_name,
    cast(cl.ftd_date as date) as ftd_date,
    CASE 
        WHEN EXTRACT(DOW FROM NOW()) = 1 THEN -- If today is Monday
            EXISTS (
                SELECT 1
                FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                WHERE nfd_sub.client_id_brand = cl.client_id_brand
                AND cast(nfd_sub.approved_date as date) BETWEEN CURRENT_DATE - INTERVAL '3 DAY' AND CURRENT_DATE - INTERVAL '1 DAY'
            )
        ELSE -- If today is not Monday
            EXISTS (
                SELECT 1
                FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                WHERE nfd_sub.client_id_brand = cl.client_id_brand
                AND cast(nfd_sub.approved_date as date) = CURRENT_DATE - INTERVAL '1 DAY'
            )
    END AS deposit_last_day,
    CASE 
        WHEN EXTRACT(DOW FROM NOW()) = 1 THEN -- If today is Monday
            EXISTS (
                SELECT 1
                FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                WHERE nfd_sub.client_id_brand = cl.client_id_brand
                AND cast(nfd_sub.approved_date as date) BETWEEN CURRENT_DATE - INTERVAL '8 DAY' AND CURRENT_DATE - INTERVAL '4 DAY'
            ) 
        ELSE -- If today is not Monday
            EXISTS (
                SELECT 1
                FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                WHERE nfd_sub.client_id_brand = cl.client_id_brand
                AND cast(nfd_sub.approved_date as date) BETWEEN CURRENT_DATE - INTERVAL '6 DAY' AND CURRENT_DATE - INTERVAL '2 DAY'
            )
    END AS deposit_five_days_before,
    CASE
        WHEN
            (
                CASE 
                    WHEN EXTRACT(DOW FROM NOW()) = 1 THEN -- If today is Monday
                        EXISTS (
                            SELECT 1
                            FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                            WHERE nfd_sub.client_id_brand = cl.client_id_brand
                            AND cast(nfd_sub.approved_date as date) BETWEEN CURRENT_DATE - INTERVAL '3 DAY' AND CURRENT_DATE - INTERVAL '1 DAY'
                        )
                    ELSE -- If today is not Monday
                        EXISTS (
                            SELECT 1
                            FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                            WHERE nfd_sub.client_id_brand = cl.client_id_brand
                            AND cast(nfd_sub.approved_date as date) = CURRENT_DATE - INTERVAL '1 DAY'
                        )
                END
            )
            AND NOT 
            (
                CASE 
                    WHEN EXTRACT(DOW FROM NOW()) = 1 THEN -- If today is Monday
                        EXISTS (
                            SELECT 1
                            FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                            WHERE nfd_sub.client_id_brand = cl.client_id_brand
                            AND cast(nfd_sub.approved_date as date) BETWEEN CURRENT_DATE - INTERVAL '8 DAY' AND CURRENT_DATE - INTERVAL '4 DAY'
                        ) 
                    ELSE -- If today is not Monday
                        EXISTS (
                            SELECT 1
                            FROM sales_uticen.uticen_non_ftd_deposits nfd_sub
                            WHERE nfd_sub.client_id_brand = cl.client_id_brand
                            AND cast(nfd_sub.approved_date as date) BETWEEN CURRENT_DATE - INTERVAL '6 DAY' AND CURRENT_DATE - INTERVAL '2 DAY'
                        )
                END
            )
        THEN TRUE
        ELSE FALSE
    END AS client_in_email_list_cat3
FROM 
    sales_uticen.uticen_clients_with_brand cl
LEFT JOIN 
    sales_uticen.uticen_non_ftd_deposits nfd ON cl.client_id_brand = nfd.client_id_brand
GROUP BY 
    cl.id, cl.client_id_brand, cl.pool, cast(cl.ftd_date as date), cl.brand_name