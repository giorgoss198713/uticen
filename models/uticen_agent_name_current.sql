	SELECT DISTINCT
	u.username as agent_name,
	cl.agent_id_brand
	FROM
  	sales_uticen.uticen_clients_with_brand cl
  	INNER JOIN sales_uticen.uticen_admin_users u 
    on cl.retention_agent=u.agent_id