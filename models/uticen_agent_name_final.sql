	SELECT DISTINCT
	u.username  as agent_name,
    u.last_login_date,
	twb.agent_id_brand_final
	FROM
  	sales_uticen.uticen_transactions_with_brand twb
  	INNER JOIN sales_uticen.uticen_admin_users u ON u.agent_id = twb.agent