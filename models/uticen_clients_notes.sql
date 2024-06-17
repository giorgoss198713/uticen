SELECT
    nt.client,
    cl.brand_name,
    concat_ws('_',nt.client,cl.brand_name) as client_id_brand,
    NULL AS updatedby_id,
    u.username,
    ntl.title as note_title,
    note,
    nt.created_date
FROM sales_uticen.notes nt
	JOIN sales_uticen.note_titles ntl ON ntl.id=nt.note_title
	LEFT JOIN sales_uticen.uticen_clients_with_brand cl ON cl.id=nt.client
	LEFT JOIN sales_uticen.uticen_admin_users u ON u.user_id = nt.user_id
WHERE
u.type=3