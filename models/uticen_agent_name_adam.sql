SELECT DISTINCT
u.username as agent_username,
aru.agent_name,
twb.agent_id_brand_final
FROM
  sales_uticen.uticen_transactions_with_brand twb
  INNER JOIN sales_uticen.uticen_admin_users u on u.agent_id = twb.agent
  INNER JOIN sales_marketing.adam_report_usernames aru ON aru.agent_username=u.username
  WHERE
  u.username  in (select agent_username from sales_marketing.adam_report_usernames)