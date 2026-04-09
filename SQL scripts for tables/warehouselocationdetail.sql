
-- do $$
-- BEGIN
 
-- 	END IF;





 
 
SELECT * 
FROM app.warehouselocationdetail wld JOIN app.warehouselocation wl ON wld.warehouseid = wl.warehouseid 
WHERE wld.requesttypeid = (select rt.requesttypeid 
                            from app.requesttype rt 
                            where rt.description = 'db-alert-inv-adj-miss-rc') 
                                AND wl.warehouseshortname = 'ATL' 
ORDER BY warehousedetailid ASC


SELECT *
FROM APP.WAREHOUSELOCATIONDETAIL

select * 
from app.warehouselocationdetail wld join app.warehouselocation wl on wld.warehouseid = wl.warehouseid
where description ='db-alert-inv-adj-miss-rc'  and payload is not null
order by wld.description asc, wld.warehouseid asc;

select *
from app.warehouselocationdetail
order by requesttypeid


SELECT *
FROM APP.WAREHOUSELOCATIONDETAIL wld join app.warehouselocation wl
	on wld.warehouseid = wl.warehouseid
WHERE wld.REQUESTTYPEID=71

	and wl.warehouseshortname = 'ELP' 




--Ensure empty result to not re-insert records 
select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, wld.payload, 'sysuser', 'sysuser' 
	from app.warehouselocation w, app.requesttype rt, app.warehouselocationdetail wld
	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
	and rt.description = 'db-alert-static-route-missing-threshold' 
	and not exists (select 1 from app.warehouselocationdetail r 
						where r.requesttypeid = rt.requesttypeid 
						and r.warehouseid = w.warehouseid);
 

--Check payload of unnamed queries 
select w.warehouseshortname, rt.description, rt.description, w.warehouseid,  rt.requesttypeid, wld.payload, 'sysuser', 'sysuser' 
	from app.warehouselocation w, app.requesttype rt,  app.warehouselocationdetail wld 
	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
	and w.warehouseshortname not in ('ASH', 'POR', 'SAA', 'WSD', 'PEN')
	and rt.description = 'db-alert-static-route-missing-threshold' 
	and wld.warehouseid = w.warehouseid
	and wld.requesttypeid = rt.requesttypeid



-- Fix issue from script #52, where attachment is missing value in payload of unnamed queries
-- Unnamed queries update attachment in payload
update app.warehouselocationdetail set payload = '{
	"alertName":"STATIC ROUTE MISSING THRESHOLD VALUE",
	"dataSource":"MAWM",
	"database":{
		"connection":"MAPRD_NEW",
		"type":"MySQL",
		"uri":"jdbc:{host}:{port}/information_schema"
	},
	"email":{
		"subject":"Splunk Alert: $alertName$",
		"body":"<pre>The alert condition for ''$name$'' was triggered.</pre>",
		"fromEmail":"wms-tools-noreply@rndc-usa.com",
		"toEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM",
		"ccEmail":"",
		"footer":"",
		"attachment":["link-to-alert","link-to-results", "inline-table"]
	},
	"sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = ''$orgId_Org_Profile'' "
}' 
where warehouseid in (select wl.warehouseid
			from app.warehouselocation wl  
			where wl.warehouseshortname not in  ('ASH', 'POR', 'SAA', 'WSD', 'PEN'))
	and requesttypeid=(select rt.requesttypeid
				from app.requesttype rt 
				where rt.description='db-alert-static-route-missing-threshold');



-- Ensure named query payloads are not affected
select w.warehouseshortname, rt.description, rt.description, w.warehouseid,  rt.requesttypeid, wld.payload, 'sysuser', 'sysuser' 
	from app.warehouselocation w, app.requesttype rt,  app.warehouselocationdetail wld 
	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
	and w.warehouseshortname in ('ASH', 'POR', 'SAA', 'WSD', 'PEN')
	and rt.description = 'db-alert-static-route-missing-threshold' 
	and wld.warehouseid = w.warehouseid
	and wld.requesttypeid = rt.requesttypeid




-- Ensure unnamed query payloads are updated with the right payload attachment
select w.warehouseshortname, rt.description, rt.description, w.warehouseid,  rt.requesttypeid, wld.payload, 'sysuser', 'sysuser' 
	from app.warehouselocation w, app.requesttype rt,  app.warehouselocationdetail wld 
	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
	and w.warehouseshortname not in ('ASH', 'POR', 'SAA', 'WSD', 'PEN')
	and rt.description = 'db-alert-static-route-missing-threshold' 
	and wld.warehouseid = w.warehouseid
	and wld.requesttypeid = rt.requesttypeid


-- Ensure unrelated records not affected
select w.warehouseshortname, rt.description, rt.description, w.warehouseid,  rt.requesttypeid, wld.payload, 'sysuser', 'sysuser' 
	from app.warehouselocation w, app.requesttype rt,  app.warehouselocationdetail wld 
	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV')  
	and rt.description != 'db-alert-static-route-missing-threshold' 
	and wld.warehouseid = w.warehouseid
	and wld.requesttypeid = rt.requesttypeid


-- Identify all records related to db-alert-static-route-missing-threshold
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	WHERE wd.longdescription = 'db-alert-static-route-missing-threshold'
) t
WHERE rn BETWEEN 4 AND 43


-- Ensure issue does not exist for all records related to db-alert-static-route-missing-threshold
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	WHERE wd.longdescription = 'db-alert-static-route-missing-threshold'
) t
WHERE rn BETWEEN 4 AND 43
AND (payload::jsonb IS NOT NULL);



-- Error found when checking records != 'db-alert-static-route-missing-threshold'
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	WHERE wd.longdescription != 'db-alert-static-route-missing-threshold'
) t
WHERE (payload::jsonb IS NOT NULL);



-- To resolve error
-- ERROR:  invalid input syntax for type json
-- Character with value 0x0a must be escaped. 

-- SQL state: 22P02
-- Detail: Character with value 0x0a must be escaped.
-- Context: JSON data, line 13: ...lain2@RNDC-USA.COM, Keith.McKinzie@RNDC-USA.COM, 

-- From script #59 (issue was with line feed/having emails toEmails overflow to newline)
-- (JES)
update app.warehouselocationdetail set payload = '{
    "alertName":"INVENTORY ADJUSTMENT PIX MISSING REASON CODE",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"Richard.Chamberlain2@RNDC-USA.COM, Keith.McKinzie@RNDC-USA.COM, Tony.Derin@RNDC-USA.COM, Zeke.Mercer@RNDC-USA.COM, Constant.Kellam@RNDC-USA.COM,Jose.Moreno@RNDC-USA.COM, James.Stone@rndc-usa.com, Michael.Clark@rndc-usa.com",
        "ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT PE.org_id, PE.created_timestamp, PE.item_id, CASE WHEN PE.adjusted_type = ''SUBTRACT'' THEN -PE.quantity WHEN PE.adjusted_type = ''ADD'' THEN PE.quantity END AS ''quantity'' , PE.reason_code_id , PE.sync_batch_id, PE.pix_specification_id, Concat(PE.status_id,''-'',PS.description) ''status'', PE.created_by FROM default_pix.PIX_PIX_ENTRY PE LEFT JOIN default_pix.PIX_PIX_STATUS PS ON PS.status_id = PE.status_id WHERE PE.pix_specification_id = ''Inventory Adjustment'' AND PE.created_timestamp BETWEEN Now() + interval 15 minute AND now() + interval 1455 minute AND reason_code_id IS NULL AND PE.org_id = $orgId;"
}' where warehouseid = (select w.warehouseid 
                        from app.warehouselocation w 
                        where w.warehouseshortname='JES') 
    and requesttypeid=(select rt.requesttypeid 
                        from app.requesttype rt 
                        where rt.description='db-alert-inv-adj-miss-rc');



SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	WHERE wd.longdescription != 'db-alert-static-route-missing-threshold'
) t
WHERE (payload::jsonb IS NOT NULL);



-- Check db-alerts that are not static-route-missing-threshold
-- 473 rows total
-- each db-alert comes in rows of 43
-- identified that it's db-alert-routes-multi-wave
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn,
		w.*
    FROM app.warehouselocationdetail wd, app.warehouselocation w
	WHERE wd.longdescription not in(
	'db-alert-static-route-missing-threshold',
	'db-alert-inv-adj-miss-rc',
	'db-alert-lia-pack-uom',
	'db-alert-order-no-desig',
	'db-alert-order-no-desig-assign',
	'db-alert-orders-deselected-waving',
	'db-alert-order-stuck-15m')
	and wd.longdescription like '%db-alert%' 
	and wd.longdescription = 'db-alert-routes-multi-wave'
	and wd.warehouseid = w.warehouseid 
	order by wd.lastupdatedon, w.warehouseshortname
) t
WHERE rn BETWEEN 1 AND 100
and (payload::jsonb IS NOT NULL);




-- issue found for db-alert-routes-multi-wave, 'TAM'
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn,
		w.*
    FROM app.warehouselocationdetail wd, app.warehouselocation w
	WHERE wd.longdescription = 'db-alert-routes-multi-wave'
	and w.warehouseshortname = 'TAM'
	and wd.warehouseid = w.warehouseid 
	order by wd.lastupdatedon, w.warehouseshortname
) t
where (payload::jsonb IS NOT NULL);
-- (incrementally increase using row number)


---No issues for db-alert-routes-multi-wave != 'TAM'
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn,
		w.*
    FROM app.warehouselocationdetail wd, app.warehouselocation w
	WHERE wd.longdescription = 'db-alert-routes-multi-wave'
	and w.warehouseshortname != 'TAM'
	and wd.warehouseid = w.warehouseid 
	order by wd.lastupdatedon, w.warehouseshortname
) t
where (payload::jsonb IS NOT NULL);




-- Issue found in script #58
-- ERROR:  invalid input syntax for type json
-- Character with value 0x0a must be escaped. 

-- SQL state: 22P02
-- Detail: Character with value 0x0a must be escaped.

-- Fix issue for db-alert-routes-multi-wave , 'TAM' (issue was with line feed/having emails toEmails overflow to newline)
update app.warehouselocationdetail set payload = '{
    "alertName":"ROUTES WITH MULTIPLE WAVE NUMBERS",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Description:<br />A user has waved this route across two different wave numbers. Sortation software is not able to process a route correctly that is waved across two different WMS wave numbers.  Cases will be missing if the IT Service Desk is not called.  Please stop what you are doing immediately and call the Service Desk to correct this condition.  <br /><br />Phone: 866-RNDC-HLP (866-763-2457)<br /><br />***MSP TO CLEAN UP***<br />Configure the necessary values in the Static Route UI<br /><br /><br /></pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"stephen.king@rndc-usa.com,doug.lepkowski@rndc-usa.com,lawrence.french@rndc-usa.com,torey.thomas@rndc-usa.com,kenneth.harms@rndc-usa.com, Eduardo.Gutierrez@rndc-usa.com",
        "ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com,WMSMSPSupport@rndc-usa.com",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":" SELECT T.org_id, T.ext_route_id, Count(DISTINCT T.wave_nbr) ''WAVE_NBR'' FROM (SELECT OL.org_id, OL.original_order_id, OL.designated_shipment_id, O.ext_route_id, OL.original_order_line_id, OL.status_change_date_time, PLA.created_timestamp, OL.original_order_planning_run_id, OL.order_planning_run_id, CASE WHEN OL.original_order_planning_run_id IS NULL THEN OL.order_planning_run_id ELSE OL.original_order_planning_run_id END AS ''WAVE_NBR'', OL.status FROM default_dcorder.DCO_ORDER_LINE OL join default_dcorder.DCO_ORDER O ON OL.order_id = O.order_id AND O.org_id = $orgId AND O.pipeline_id = ''RNDC_Standard_Order_Pipeline'' join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON ( CASE WHEN OL.original_order_planning_run_id IS NULL THEN OL.order_planning_run_id ELSE OL.original_order_planning_run_id END ) = PLA.order_planning_run_id WHERE 1 = 1 AND Upper(PLA.planning_strategy_id) LIKE ''%%STANDARD%%'' AND PLA.status <> ''900'' AND OL.status IN ( ''CREATED'', ''READY'', ''WORKINPROGRESS'', ''WORKCOMPLETED'' , ''ALLOCATED'', ''FAILED'', ''PACKING'', ''PACKED'', ''STAGED'', ''MANIFESTED'' ) AND OL.original_order_id IN (SELECT original_order_id FROM default_dcorder.DCO_ORDER WHERE order_type = ''Standard'') AND OL.org_id = $orgId AND ( OL.original_order_planning_run_id IN (SELECT run_id FROM default_dcallocation.DCA_ALLOCATION_RUN WHERE created_timestamp > Now() - interval 8 hour) OR OL.order_planning_run_id IN (SELECT run_id FROM default_dcallocation.DCA_ALLOCATION_RUN WHERE created_timestamp > Now() - interval 8 hour) )) T GROUP BY T.org_id, T.ext_route_id HAVING Count(DISTINCT wave_nbr) > 1; "
}' where warehouseid = (select w.warehouseid 
                        from app.warehouselocation w 
                        where w.warehouseshortname='TAM') 
    and requesttypeid=(select rt.requesttypeid 
                        from app.requesttype rt 
                        where rt.description='db-alert-routes-multi-wave');



-- Ensure issue resolved for db-alert-routes-multi-wave, 'TAM'
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn,
		w.*
    FROM app.warehouselocationdetail wd, app.warehouselocation w
	WHERE wd.longdescription = 'db-alert-routes-multi-wave'
	and w.warehouseshortname = 'TAM'
	and wd.warehouseid = w.warehouseid 
	order by wd.lastupdatedon, w.warehouseshortname
) t
where (payload::jsonb IS NOT NULL);




-- Ensure no issues in other db-alert records (that I created seen in longdescription list below)
-- Get DB-alerts using this query
-- SELECT description 
-- FROM app.warehouselocationdetail
-- where longdescription like '%db-alert%'
-- group by description
-- ORDER BY description ASC 
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn,
		w.*
    FROM app.warehouselocationdetail wd, app.warehouselocation w
	WHERE wd.longdescription in(
	'db-alert-inv-adj-miss-rc',
	'db-alert-lia-pack-uom',
	'db-alert-order-no-desig',
	'db-alert-order-no-desig-assign',	
	'db-alert-orders-deselected-waving',
	'db-alert-order-stuck-15m',
	'db-alert-routes-multi-wave',
	'db-alert-route-ui-dflt-miss',
	'db-alert-static-route-missing-threshold')  
	and wd.warehouseid = w.warehouseid 
	order by wd.lastupdatedon, w.warehouseshortname
) t
WHERE rn BETWEEN 1 AND 1000
and (payload::jsonb IS NOT NULL);




-- Ensure no issues with non-db-alerts
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn,
		w.*
    FROM app.warehouselocationdetail wd, app.warehouselocation w
	WHERE wd.longdescription not like '%db-alert%'
	and wd.warehouseid = w.warehouseid 
	order by wd.lastupdatedon, w.warehouseshortname
) t 
where (payload::jsonb IS NOT NULL);



-- Ensure no issues with db-alerts
-- ERROR:  invalid input syntax for type json
-- Token "AsnId" is invalid. 

-- SQL state: 22P02
-- Detail: Token "AsnId" is invalid.
-- Context: JSON data, line 10: .../receiving/api/receiving/asn/save<br>{<br> "AsnId...
-- (seems to be issue with script #57 done by Jifeng)
SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn,
		w.*
    FROM app.warehouselocationdetail wd, app.warehouselocation w
	WHERE wd.longdescription like '%db-alert%'
	and wd.warehouseid = w.warehouseid 
	order by wd.lastupdatedon, w.warehouseshortname
) t 
where (payload::jsonb IS NOT NULL);



-- Acceptance criteria - no issues when running this:
select 
wd.payload::jsonb
from app.warehouselocationdetail wd







