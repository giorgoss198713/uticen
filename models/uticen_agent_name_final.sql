	SELECT DISTINCT
	u.username  as agent_name,
	twb.agent_id_brand_final,
	u.last_login_date
	FROM
  	sales_uticen.uticen_transactions_with_brand twb
  	INNER JOIN sales_uticen.uticen_admin_users u ON u.agent_id = twb.agent_id_brand_final