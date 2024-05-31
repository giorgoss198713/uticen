SELECT DISTINCT
u.username as agent_name,
fad.agent_id_brand_final
FROM
  sales_uticen.uticen_first_approved_date fad
  INNER JOIN sales_uticen.uticen_admin_users u on u.agent_id = fad.agent_id_brand_final