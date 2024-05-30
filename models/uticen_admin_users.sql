select u.id as user_id, a.id as agent_id, u.username, last_login_date, ut.name as user_type
  from imports.uticen_users u
  left join imports.uticen_agents a ON a.user_id=u.id
  left join imports.uticen_user_types ut ON ut.id=u.type