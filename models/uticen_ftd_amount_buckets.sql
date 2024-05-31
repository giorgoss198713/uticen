SELECT
DISTINCT 
twb.client_id_brand,
twb.language,
twb.pool_final,
min(twb.approved_date ),
sum(round(cast(twb.usd_amount as numeric),0)) as ftd_usd_amount,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<100
THEN '01. $1-99'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=100 AND sum(round(cast(twb.usd_amount as numeric),0))<150
THEN '02. $100-149'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=150 AND sum(round(cast(twb.usd_amount as numeric),0))<200
THEN '03. $150-199'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=200 AND sum(round(cast(twb.usd_amount as numeric),0))<300
THEN '04. $200-299'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=300 AND sum(round(cast(twb.usd_amount as numeric),0))<400
THEN '05. $300-399'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=400 AND sum(round(cast(twb.usd_amount as numeric),0))<500
THEN '06. $400-499'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=500
THEN '07. $500+'
END) AS ftd_bucket,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<300
THEN '01. $0-299'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=300
THEN '02. $300+'
END) AS ftd_bucket_2,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>=40 AND sum(round(cast(twb.usd_amount as numeric),0))<61
THEN '01. $40-60'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=90 AND sum(round(cast(twb.usd_amount as numeric),0))<111
THEN '02. $90-110'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=240 AND sum(round(cast(twb.usd_amount as numeric),0))<261
THEN '03. $240-260'
END) AS ftd_bucket_3,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<=150
THEN '$100'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>150 AND sum(round(cast(twb.usd_amount as numeric),0))<=250
THEN '$250'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>250 AND sum(round(cast(twb.usd_amount as numeric),0))<=350
THEN '$300'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>350 AND sum(round(cast(twb.usd_amount as numeric),0))<=450
THEN '$400'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>450 AND sum(round(cast(twb.usd_amount as numeric),0))<=550
THEN '$500'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>550 
THEN '$550+'
END) as ftd_bucket_4,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<200
AND twb.language IN ('ARAB','BRZ','ENG')
THEN '$0-199'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=200 AND twb.language  IN ('ARAB','BRZ','ENG')
THEN '$200+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<300
AND twb.language IN ('AZR','TUR', 'FR')
THEN '$0-299'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=300
AND twb.language IN ('AZR','TUR','FR')
THEN '$300+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<100
AND twb.language IN ('RU')
THEN '$0-99'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=100
AND twb.language IN ('RU')
THEN '$100+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<150
AND twb.language IN ('THAI')
THEN '$0-149'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=150
AND twb.language IN ('THAI')
THEN '$150+'
END) AS ftd_bucket_5,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<200
AND twb.pool_final IN ('BRZ DESK 2', 'BRZ DESK 3', 'AFF CHM', 'English Desk')
THEN '$0-199'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=200
AND twb.pool_final IN ('BRZ DESK 2', 'BRZ DESK 5', 'AFF CHM', 'English Desk')
THEN '$200+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<300
AND twb.pool_final IN ('NV-DESK', 'Azer Desk', 'FRENCH DESK TLV 1', 'FRENCH DESK TLV 4')
THEN '$0-299'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=300
AND twb.pool_final IN ('NV-DESK', 'FRENCH DESK TLV 2', 'FRENCH DESK TLV 3', 'AFF TURKISH - EN')
THEN '$300+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<100
AND twb.pool_final IN ('Russian Desk', 'Sho Ru Pool', 'AFF TL ARABIC', 'Thai Desk - EN')
THEN '$0-99'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=100
AND twb.pool_final IN ('Russian Desk', 'Sho Ru Pool', 'AFF TL ARABIC', 'Thai Desk - EN')
THEN '$100+'
END) AS ftd_bucket_6,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<=99
AND twb.language IN ('AZR','BRZ','ENG','FR','RU','THAI','TUR')
THEN '01. $0-99'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>99 AND sum(round(cast(twb.usd_amount as numeric),0))<=200
AND twb.language IN ('AZR','BRZ','ENG','RU','THAI','TUR')
THEN '02. $99.1-200'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>99 AND sum(round(cast(twb.usd_amount as numeric),0))<=235
AND twb.language IN ('FR')
THEN '02. $99.1-235'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>200 AND sum(round(cast(twb.usd_amount as numeric),0))<=390
AND twb.language IN ('AZR','BRZ')
THEN '03. $200.1-390'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>200 AND sum(round(cast(twb.usd_amount as numeric),0))=380
AND twb.language IN ('ENG','RU')
THEN '03. $200.1-380'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=200
AND twb.language IN ('THAI','TUR')
THEN '03. $200.1+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>235 AND sum(round(cast(twb.usd_amount as numeric),0))<=275
AND twb.language IN ('FR')
THEN '03. $235.1-275'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>275 AND sum(round(cast(twb.usd_amount as numeric),0))<=349
AND twb.language IN ('FR')
THEN '04. $275.1-349'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>349 AND sum(round(cast(twb.usd_amount as numeric),0))<=435
AND twb.language IN ('FR')
THEN '05. $349.1-435'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>435
AND twb.language IN ('FR')
THEN '06. $435.1+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>390
AND twb.language IN ('AZR','BRZ')
THEN '04. $390.1+'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>380
AND twb.language IN ('ENG','RU')
THEN '04. $380.1+'
END) as ftd_bucket_7,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<=60
THEN '01. $0-60'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=95 AND sum(round(cast(twb.usd_amount as numeric),0))<=105
THEN '02. $95-105'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=240 AND sum(round(cast(twb.usd_amount as numeric),0))<=260
THEN '03. $240-260'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>=390 AND sum(round(cast(twb.usd_amount as numeric),0))<=410
THEN '04. $390-410'
END) AS ftd_bucket_8,
(CASE WHEN sum(round(cast(twb.usd_amount as numeric),0))>0 AND sum(round(cast(twb.usd_amount as numeric),0))<=199
THEN '01. $100'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>199 AND sum(round(cast(twb.usd_amount as numeric),0))<=349
THEN '02. $250'
WHEN sum(round(cast(twb.usd_amount as numeric),0))>349
THEN '03. $400'
END) AS ftd_bucket_9
FROM
  sales_uticen.uticen_transactions_with_brand twb
WHERE
  twb.is_ftd is true
  AND twb.type ='Deposit'
  GROUP BY
  client_id_brand, twb.language, twb.pool_final