WITH RankedNotes AS (
    SELECT
        nt.id,
        concat_ws('_', nt.client, cl.brand_name) as client_id_brand,
        nt.created_date,
        ROW_NUMBER() OVER (
            PARTITION BY nt.client, cl.brand_name 
            ORDER BY nt.created_date DESC, nt.id DESC
        ) as rn
    FROM sales_uticen.notes nt
    JOIN sales_uticen.uticen_clients_with_brand cl 
        ON cl.id = nt.client
    WHERE nt.client = 1448
),
LatestNotes AS(
SELECT
    client_id_brand,
    created_date as latest_created_date,
    id as latest_note_id
FROM RankedNotes
WHERE rn = 1
)
SELECT
    nt.client,
    cl.brand_name,
    ln.client_id_brand,
    NULL AS updatedby_id,
    u.username,
    ntl.title as note_title,
    nt.note,
    nt.created_date
FROM sales_uticen.notes nt
JOIN sales_uticen.note_titles ntl ON ntl.id = nt.note_title
LEFT JOIN sales_uticen.uticen_clients_with_brand cl ON cl.id = nt.client
LEFT JOIN sales_uticen.uticen_admin_users u ON u.user_id = nt.user_id
JOIN LatestNotes ln ON ln.client_id_brand = concat_ws('_', nt.client, cl.brand_name)
AND ln.latest_note_id = nt.id
WHERE u.type = 3