select u.id as user_id, a.id as agent_id, u.username, last_login_date ,u.type, ut.name as user_type
  from sales_uticen.users u
  left join sales_uticen.agents a ON a.user_id=u.id
  left join sales_uticen.user_types ut ON ut.id=u.type