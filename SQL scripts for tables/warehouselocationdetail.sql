select *
from app.warehouselocationdetail
where description like '%tmp-inv-no-resv%';

-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-olpn-multi-det.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-olpn-multi-det' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);







-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselocation
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-olpn-multi-det')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:

--  db-alert-olpn-multi-det.
 
--  Named queries (only (ALL) as of writing)
--   ALL
update app.warehouselocationdetail set payload = '{
    "alertName":"MAWM - Olpns W/ Multiple Details Of The Same Item",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br />Note: Manhattan case 7977755 is opened for this.  Review Cubing Strategy Cube to Capacity Break Criteria<br />Note: Manhattan case 7107223 is opened and closed for this. New case 7977755 is now opened to track this issue.  Review Cubing Strategy Cube to Capacity Break Criteria</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"WMSInternal@rndc-usa.com, WMSConsultant@rndc-usa.com , DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID, COUNT(DISTINCT OLPN_DETAIL_ID) ''LPN_DTL_COUNT'' FROM ( SELECT OLPN.ORG_ID, OLPN.PICK_LOCATION_ID, LOC.STORAGE_UOM_ID, LOC.TASK_MOVEMENT_ZONE_ID, LOC.PICK_ALLOCATION_ZONE_ID, OLPN.LPN_TYPE, OLPN.OLPN_ID, OLPN.TOTAL_LPN_QTY, OLPN.OLPN_CREATION_CODE_ID, CONCAT(OLPN.STATUS, ''-'', STAT.DESCRIPTION) ''STATUS'', OLPN.ORDER_PLANNING_RUN_ID, OLPN.ORDER_TYPE, SHIPMENT_ID, STOP_ID, OD.PICKED_QUANTITY, OD.INITIAL_QUANTITY, OD.ORIGINAL_ORDER_LINE_ID, OD.ITEM_ID, OD.OLPN_DETAIL_ID FROM default_pickpack.PPK_OLPN OLPN LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = OLPN.STATUS LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = PICK_LOCATION_ID AND OLPN.ORG_ID = SUBSTR(LOC.PROFILE_ID, 1, 3) LEFT JOIN default_pickpack.PPK_OLPN_DETAIL OD ON OD.OLPN_PK = OLPN.PK AND OD.ORG_ID = OLPN.ORG_ID AND OD.STATUS <> ''9000'' WHERE 1 = 1 AND OLPN.CREATED_TIMESTAMP >= NOW() - INTERVAL 6 HOUR AND OLPN.ORDER_PLANNING_RUN_ID IN (SELECT ORDER_PLANNING_RUN_ID FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY OPS WHERE UPPER(DESCRIPTION) LIKE ''STANDARD%%'' AND OPS.ORG_ID = OLPN.ORG_ID) ) A GROUP BY ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID HAVING COUNT(DISTINCT OLPN_DETAIL_ID) > 1;"
}' where requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-olpn-multi-det');





-- (Unnamed)
--  Disabled queries

 

-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-olpn-multi-det'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-olpn-multi-det'
and wld.payload is not null
order by wld.lastupdatedon



select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-olpn-multi-det'
and wld.payload is not null
order by wl.warehouseshortname


-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-olpn-multi-det'
) t 
where (payload::jsonb IS NOT NULL);
