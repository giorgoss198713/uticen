select distinct
 cl.id,
 (CASE WHEN education='ciadoinvestidor.com' THEN 'ciadoinvestidor'
 WHEN education='mentorsabio.com' THEN 'mentorsabio'
 WHEN education='poderinvestimentos.com' THEN 'poderinvestimentos'
 ELSE education
 END) AS education_site,
 (CASE WHEN education IN ('ciadoinvestidor.com','poderinvestimentos.com','poderinvestimentos', 'potenciadosaber','ciadoinvestidor')  THEN 'cb10'
 WHEN education IN ('mentorsabio','mentorsabio.com','ganhointeligente','cursosderenda','centraldarenda','analistasdelucro','rendainteligente','capitaldolucro') THEN 'cb9'
 ELSE ''
 END) AS education_cb,
 to_jsonb(address::json)->>'country' as country,
 NULL as formatted_occupation,
 to_jsonb(general_info::json)->>'occupation' as initial_occupation,
 NULL AS occupation_group,
 (extract(year from current_date)-extract(year from birth_date)) as age,
 to_jsonb(general_info::json)->>'maritalStatus' as initial_marital_status,
 to_jsonb(address::json)->>'zipCode' as zip_code,
 to_jsonb(address::json)->>'state' as state,
 0 AS cpa,
 false as depositor,
 lead_id AS brm_id,
 (to_jsonb(general_info::json)->>'dialerLeadId')::bigint as dialer_id,
 NULL AS email,
fd.ftd_date,
0 AS deposit_amount,
0 AS withdrawal_amount,
 ca.last_call_date,
 'Client' AS entry_type,
 null as verified,
 st.name as status,
 to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' as pool,
 cl.created_date,
 (to_jsonb(marketing_info::json)->>'campaignId')::bigint as campaign_id,
 NULL AS referral,
 NULL::date AS converted_date,
 true as is_ftd,
 LOWER(br.name) as brand_name,
 lc.login_count,
 fc.first_pool AS first_calling_pool_transformed, --ATENTION WAITING FOR FIX
 INITCAP(to_jsonb(hierarchy_log::json)->-1->'changes'->>'division') as desk_manager, --ATENTION
 CASE WHEN language='en' THEN 'ENG' else language END AS pool_language,
 fc.first_agent AS first_calling_agent,
 agent AS retention_agent,
 CASE WHEN language='en' THEN 'ENG' else language END AS language,
 NULL AS referral_brand,
 first_name as fname,
 last_name as lname,
 to_jsonb(general_info::json)->>'gender' as gender,
 concat_ws(' ',first_name,last_name) as full_name,
 CASE WHEN cl.agent IS NULL THEN NULL ELSE concat_ws('_', cl.agent, LOWER(br.name)) END as agent_id_brand,
 concat_ws('_', cl.id, LOWER(br.name)) as client_id_brand,
 concat_ws('_',  to_jsonb(marketing_info::json)->>'campaignId', LOWER(br.name)) as campaign_id_brand,
 (CASE WHEN  (extract(year from current_date)-extract(year from birth_date))>0 and  (extract(year from current_date)-extract(year from birth_date))<31 THEN '19-30'
 WHEN  (extract(year from current_date)-extract(year from birth_date))>30 and  (extract(year from current_date)-extract(year from birth_date))<41 THEN '31-40'
 WHEN  (extract(year from current_date)-extract(year from birth_date)) >40 and  (extract(year from current_date)-extract(year from birth_date))<51 THEN '41-50'
 WHEN  (extract(year from current_date)-extract(year from birth_date))>50 and  (extract(year from current_date)-extract(year from birth_date))<61 THEN '51-60'
 WHEN  (extract(year from current_date)-extract(year from birth_date))>60 and  (extract(year from current_date)-extract(year from birth_date))<71 THEN '61-70'
 WHEN  (extract(year from current_date)-extract(year from birth_date))>70 and  (extract(year from current_date)-extract(year from birth_date)) <81 THEN '71-80'
 WHEN  (extract(year from current_date)-extract(year from birth_date))>80 and  (extract(year from current_date)-extract(year from birth_date))<121 THEN '81+'
 ELSE 'Not in CRM'
 END) as age_group,
 NULL::bigint AS lead_atomix_id,
 CASE WHEN chat_client_id IS NOT NULL THEN true ELSE false END as client_in_atomix,
 NULL AS has_atomix,
 NULL AS client_conversations,
 ca.attempted_calls, 
 ca.answered_calls,
 NULL::bigint as answered_binary,
 NULL AS answered_call,
 NULL as refunded
FROM sales_uticen.clients cl
LEFT JOIN sales_uticen.uticen_calls_summary ca ON ca.client=cl.id
LEFT JOIN sales_uticen.uticen_first_caller fc ON fc.client=cl.id
LEFT JOIN sales_uticen.uticen_login_count lc ON lc.client=cl.id
LEFT JOIN sales_uticen.statuses st ON st.id=cl.status
LEFT JOIN sales_uticen.brands br ON br.id=cl.brand
LEFT JOIN sales_uticen.uticen_ftd_date  fd ON fd.client_id=cl.id
where
to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' NOT ilIKE '%test%'