SELECT DISTINCT
    u.username AS agent_name,
    twb.agent_id_brand_final,
    twb.agent_id_brand_day,
    u.user_id as id,
    twb.brand_name
  FROM sales_uticen.uticen_transactions_with_brand twb
  	JOIN (SELECT user_id, username, agent_id
	FROM sales_uticen.uticen_admin_users) u ON u.agent_id = twb.agent_id_brand_final
  WHERE
  twb.is_ftd IS true