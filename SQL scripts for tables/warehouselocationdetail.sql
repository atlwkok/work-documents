select *
from app.warehouselocationdetail
where description like '%multi-ord-lines%';

-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-multi-ord-lines.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-multi-ord-lines' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);







-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselocation
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-multi-ord-lines')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:

--  db-alert-multi-ord-lines.

--  Named queries (only (ALL) as of writing)
--   ALL
update app.warehouselocationdetail set payload = '{
    "alertName":"MAWM - Multiple Order Lines Per Original Order Line",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br />Note: Manhattan Case 7639712 is opened for this.</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@rndc-usa.com",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"select distinct (org_id), order_id, case when order_planning_run_id is not null then order_planning_run_id else shorted_order_planning_run_id end as ''wave_nbr'', order_type, original_order_line_id, item_id, count(order_line_id) from ( select o.org_id, o.order_id, o.order_type, oli.original_order_line_id, oli.order_line_id, oli.item_id, oli.order_planning_run_id, oli.shorted_order_planning_run_id, oli.status, oli.shortage_line, oli.ext_original_order_line_quantity, oli.ext_allocation_strategy, oli.packed_quantity, o.updated_timestamp from default_dcorder.DCO_ORDER_LINE oli join default_dcorder.DCO_ORDER o on oli.original_order_id = o.order_id and o.org_id = oli.org_id where oli.pipeline_status > 1000 and oli.updated_timestamp >= now() - INTERVAL 12 HOUR ) a group by org_id, order_id, wave_nbr, order_type, original_order_line_id, item_id having count(order_line_id) > 1 order by org_id, order_id, original_order_line_id;"
}' where requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-multi-ord-lines');






-- (Unnamed)
--  Disabled queries

 

-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-multi-ord-lines'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-multi-ord-lines'
and wld.payload is not null
order by wld.lastupdatedon



select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-multi-ord-lines'
and wld.payload is not null
order by wl.warehouseshortname


-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-multi-ord-lines'
) t 
where (payload::jsonb IS NOT NULL);
