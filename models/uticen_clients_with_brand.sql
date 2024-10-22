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
 col.country,
 (CASE WHEN occupation='Analyst ' then 'Analyst'
 WHEN INITCAP(occupation)='Centro' then NULL
 WHEN INITCAP(occupation)='Enegry Company' then 'Energy Company'
 WHEN INITCAP(occupation)='Insulation Worker' then 'Isolation Worker'
 WHEN INITCAP(occupation) IN ('Pregnant','Maternity Leave') then 'Unemployed'
 WHEN INITCAP(occupation)='New Media / Tv' then 'New Media Or Tv'
 WHEN INITCAP(occupation)='New Media/Tv' then 'New Media Or Tv'
 WHEN occupation='' then NULL
 else
 INITCAP(occupation) END) as formatted_occupation,
 occupation as initial_occupation,
 (CASE
 WHEN INITCAP(occupation) IN ('Accountant','Accountant11','Accoвмвuntant','Benefits','Business Man','Project Manager','Bank','Banker','Insurance Employee',
									'Insurance Industry','Payroll Department','Treasurer', 'Analyst ', 'Financial Industry',  'Management', 'Manager',
									 'KazakhstanAccountant', 'Kazakhstanaccountant') THEN 'Accounting & Finance'
  		WHEN INITCAP(occupation) IN ('Administration','Office Staff','Receptionist', ' Payroll Department', 'Hr', 'Government Worker', 'Translator', 'Supervisor ') 
  									THEN 'Administration'
        WHEN INITCAP(occupation) IN ('Agricultural','Agriculture','Agronomist','Farmer', 'Fisherman') THEN 'Agriculture & Fishing'
  		WHEN INITCAP(occupation) IN ('Art','Art Field','Ceramic Artist','Designer','Painter') THEN 'Art & Design'
  		WHEN INITCAP(occupation) IN ('Automobiles Sector','Car Rental','Car Wash','Driver','Mechanic') THEN 'Automotive'
  		WHEN INITCAP(occupation) IN ('Airport Staff','Aviation','Courier Driver','Logistics','Railways','Shipping / Delivery','Shipping Industry',
									'Shipping Or Delivery','Site Coordinator','Warehouse Worker', ' Catering Airlines', 'Currier Driver', 'Delivery Boy',
											'Export Product', 'Logistic', 'Logistics', 'logistics', 'Post Man', 'Railway', 'Roads', 'Sailor', 'Warehouse Industry') 
  									THEN 'Transportation & Logistics'
  		WHEN INITCAP(occupation) IN ('Bartender','Catering Airlines','Chef','Chef / Cook','Gastronomie','Gastronomy','Hotel Industry','Waiter','bartender ', 
											  'Cook Line', 'Cooker', 'Line Cook', 'Restaurant Industry', 'Waiter ') 
  									THEN 'Hospitality'
        WHEN INITCAP(occupation) IN ('Builder', 'Builder ', 'Constraction','Construction Filler','Construction Industry','Construction Worker','Maintenance','Plumber',
											'Repairs And Maintenance','Site Coordinator','Welder', 'Road', 'Architecture', 'Builder', 'Carpenter', 'constraction ', 
											 'Engeneer', 'Engineer', 'Insulation Worker', 'Laborer', 'Leborer', 'Landscaping', 'Maintanance', 'Machine Operator', 
											'Pest Control', 'Plumber', 'Technician', 'Plumber ', 'Constraction ', 'Plantation Worker') 
  									THEN 'Construction & Maintenance'
  		WHEN INITCAP(occupation) IN ('Music Teacher','Teacher','Trainer', 'Science') THEN 'Education'
  		WHEN INITCAP(occupation) IN ('Caregiver','Care Giver','Caregiver Pensioner','Doctor','Medicinal Worker','Nurse','Physical Therapy',
										'Reflexologist','Therapist', 'Nature Care Or Vet','Nature Care / Vet', 'Chemist', 'Medical', 'Medicial Worker', 'Patients Service') 
  									THEN 'Healthcare and Medical'
  		WHEN INITCAP(occupation) IN ('Analyst','Computers','Computers / IT','I.T','Programmer', 'Computers / It') THEN 'IT'
  		WHEN INITCAP(occupation) IN ('Law','Law Field','Policeman','Police / Military','Police / Military / Emergency Service',
										'Police Or Military Or Emergency Service') THEN 'Legal & Law Enforcement'
  		WHEN INITCAP(occupation) IN ('Factory Worker','Manufacturing Industry','Manufacture Industry','Plastic Factory Worker', ' Oil Industry',
											 'Electrical Industry', 'Energy Company', 'Enegry Company', 'Mines') 
  								THEN 'Manufacture & Power Industry'
 		WHEN INITCAP(occupation) IN ('Marketing And Advertising','Sales','Sales1','Sales Industry','Sales (Israeli)','Supermarket Management') 
  								THEN 'Marketing & Sales'
  		WHEN INITCAP(occupation) IN ('Security Officer','Soldier') THEN 'Military & Security'
  		WHEN INITCAP(occupation) IN ('Call Center Agent','Concierge','Customer Service','Custumer Service','Support Agent', 'Concierge ', 'Costomer Service',
											'Costumer Service', 'House Keeping') 
  								THEN 'Customer Support'
  		WHEN INITCAP(occupation) IN ('Entrepreneur','Freelance','Self Employed','Isolation Worker', 'Youtuber', 'Forest Guide', 'Youtuber ') THEN 'Self-Employed'
  		WHEN INITCAP(occupation) IN ('Charity','Church Worker','Community Service','Social Worker', 'Cherity', 'Pastor') THEN 'Social Services'
  		WHEN INITCAP(occupation) IN ('Professional Sport','Sport','Sports Instructor', 'Casino Dealer', 'Casino Sector') THEN 'Sports & Gaming Industry'
 		WHEN INITCAP(occupation) IN ('Student','Student - & Part - Time (Cashier)','Student - Part Time Job-Pizza Hut','Student- Part Time Retail',
									 	'Student Unemployed','Student W/A Part Time Job - Pizza House', ' Student w/a part time job - pizza house', 'Student ',
											'Student - Part Time Job-Pizza Hut ', 'Student Unemployeed', 'Student-  part time retail', 'Student w/a part time job -McDonalds',
                                            ' Student w/a part time job - pizza house') 
  								THEN 'Student'
 		WHEN INITCAP(occupation) IN ('Tourism', 'Musician', 'New media / Tv', 'New Media Or Tv', 'new media / tv') THEN 'Entertainment & Tourism'
  		WHEN INITCAP(occupation) IN ('Trading') THEN 'Trading'
  		WHEN INITCAP(occupation) IN ('Own Business', 'Business', 'Business Owner') THEN 'Business Owner'
 		WHEN INITCAP(occupation) IN ('Real Estate ', 'Real Estate', 'Real Estate Broker') THEN 'Real Estate'
  		WHEN INITCAP(occupation) IN ('Retail','Retails','Butcher','Cashier', 'Furniture Inspector ', 'Florist', 'Laundry Shop Staff ') THEN 'Retail'
  		WHEN INITCAP(occupation) IN ('Unemployed','Unemployed Student','Unemployed (Was A Driver)','House Wife', 'Unemployed ') 
  									THEN 'Unemployed'
  		WHEN INITCAP(occupation) IN ('Retied Factory Worker','Retired','Retired Builder','Retired Driver','Retired Farmer','Retired Nurse',
											'Retired Office Depot Employee','Retired Sales Supervisor','Retired Telephone Repairman','Disability Benefit',
											 'Disability Benefits','Disability Benenfits','Disability Pensions','Dissability Benefits', ' Disability Benefits', 
											 ' Dissability Benefits', ' Retired Sales Supervisor','Caregiver Pensioner', 'Disability Benefits ', 'Disability Benefits', 
											 'Mental Disability', 'Military Disability Benefits', 'Pensioner', 'Pregnant', 'Retired ', 'Retired Builder ', 
											 'Semi Retired', 'Maternity Leave', 'Caregiver Pensioner ') 
  									THEN 'Retired & Benefits'
  		WHEN INITCAP(occupation) IN ('Part Time','Part Time Caregiver','Part Time Cleaner','Part Time Electrician','Part Time Petrol Station',
									'Part Time Worker Support', 'Part Time Petrol Station', 'part time  petrol station') THEN 'Part-Time'
  		WHEN INITCAP(occupation) IN ('Beautician', 'Beautician / Hair Style', 'Beautician Or  Hair Style', 'Beautician Or Hair Style', 'Cleaner', 'Cutting Grass',
											'Hairdresser', 'Massuese') 
  									THEN 'Beauty & Personal Care'
        WHEN INITCAP(occupation) IN ('other incomes', 'Other incomes', 'Other Incomes') 
  									THEN 'Passive Incomes'
									ELSE 'Unspecified Profession'								
  END) AS occupation_group,
 (extract(year from current_date)-extract(year from birth_date)) as age,
 to_jsonb(general_info::json)->>'maritalStatus' as initial_marital_status,
 to_jsonb(address::json)->>'zipCode' as zip_code,
 to_jsonb(address::json)->>'city' as city,
 to_jsonb(address::json)->>'state' as state,
 0 AS cpa,
 false as depositor,
 lead_id AS brm_id,
 (to_jsonb(general_info::json)->>'dialerLeadId')::bigint as dialer_id,
 NULL AS email,
 CASE WHEN cl.ftd_date IS NULL THEN fd.ftd_date
 WHEN cast(cl.created_date as date)>cast(cl.ftd_date as date) THEN cl.created_date
 ELSE cl.ftd_date END AS ftd_date,
 0 AS deposit_amount,
 0 AS withdrawal_amount,
 ca.last_call_date,
 'Client' AS entry_type,
 null as verified,
 st.name as status,
 CASE WHEN to_jsonb(hierarchy_log::json)->-1->'changes'->>'team'='EN CY'  IS NOT NULL THEN
 CASE WHEN to_jsonb(hierarchy_log::json)->-1->'changes'->>'team'='EN CY' THEN 'English Desk' ELSE to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' END 
 ELSE
 'Not Assigned' 
 END as pool,
 cl.created_date,
 (to_jsonb(marketing_info::json)->>'campaignId')::bigint as campaign_id,
 to_jsonb(marketing_info::json)->>'marketingCampaignName' as campaign_name,
 NULL AS referral,
 NULL::date AS converted_date,
 true as is_ftd,
 LOWER(br.name) as brand_name,
 lc.login_count,
 la.login_array,
 CASE WHEN fc.first_pool IS NOT NULL THEN fc.first_pool
 WHEN fc.first_pool IS NULL AND to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' IS NOT NULL THEN
 (CASE WHEN to_jsonb(hierarchy_log::json)->-1->'changes'->>'team'='EN CY' THEN 'English Desk' ELSE to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' END)
 WHEN fc.first_pool IS NULL AND to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' IS NULL THEN 'Not Assigned'
 END AS first_calling_pool_transformed, --ATENTION WAITING FOR FIX
 INITCAP(to_jsonb(hierarchy_log::json)->-1->'changes'->>'division') as desk_manager, --ATENTION
 CASE WHEN cl.language='en' THEN 'ENG' else cl.language END AS pool_language,
 fc.first_agent AS first_calling_agent,
 agent AS retention_agent,
 ll.language,
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
 NULL AS refunded,
 to_jsonb(lead_data::json)->>'educationLevel' AS education_level,
 NULL AS home_owner,
 to_jsonb(marketing_info::json)->>'utmSource' as UTMSource,
 to_jsonb(marketing_info::json)->>'utmMedium' as UTMMedium
FROM sales_uticen.clients cl
LEFT JOIN sales_uticen.uticen_calls_summary ca ON ca.client=cl.id
LEFT JOIN sales_uticen.uticen_first_caller fc ON fc.client=cl.id
LEFT JOIN sales_uticen.uticen_login_count lc ON lc.client=cl.id
LEFT JOIN sales_uticen.uticen_login_array la ON la.client=cl.id
LEFT JOIN sales_uticen.statuses st ON st.id=cl.status
LEFT JOIN sales_uticen.brands br ON br.id=cl.brand
LEFT JOIN sales_uticen.uticen_ftd_date fd ON fd.client_id=cl.id
LEFT JOIN sales_uticen.uticen_country_list col ON col.iso=to_jsonb(address::json)->>'country'
LEFT JOIN sales_uticen.uticen_language_list ll ON ll.language_code=cl.language
where
(
    to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' NOT ILIKE '%test%'
    OR to_jsonb(hierarchy_log::json)->-1->'changes'->>'team' IS NULL
  )