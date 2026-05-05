select *
from app.warehouselocationdetail
where description like '%static-route-missing%';

-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-static-route-missing-threshold.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-static-route-missing-threshold' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);







-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselo
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-static-route-missing-threshold')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:

-- Named queries (enabled (only PEN, POR, SAA, WSD as of writing) + disabled)

-- (ASH)
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
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Configure the necessary values in the Static Route UI</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"Jonathan.Snell@RNDC-USA.COM, Preston.Mccauley@RNDC-USA.COM, Rob.Garcia@RNDC-USA.COM, Jordan.Stoll@rndc-usa.com, Richard.Gay@RNDC-USA.COM, Billy.Calloway@RNDC-USA.COM, Ryan.Black@rndc-usa.com",
        "ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = concat($orgId, ''_Org_Profile'');"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='ASH') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-static-route-missing-threshold');

-- (POR)
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
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Configure the necessary values in the Static Route UI</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = concat($orgId, ''_Org_Profile'');"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='POR') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-static-route-missing-threshold');


-- (SAA)
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
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Configure the necessary values in the Static Route UI</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"Travis.Eldridge@rndc-usa.com,joseph.duran@rndc-usa.com,travis.gusler@rndc-usa.com,christopher.gonzales@rndc-usa.com,Larry.Shelton@RNDC-USA.COM, Octavio.Chavez@RNDC-USA.COM, kameron.phipps@rndc-usa.com,",
        "ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = concat($orgId, ''_Org_Profile'');"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='SAA') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-static-route-missing-threshold');



-- (WSD)
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
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Configure the necessary values in the Static Route UI</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"demetrius.dever@rndc-usa.com,Michael.Clark@RNDC-USA.com,clarence.hall@rndc-usa.com,brian.bowen@rndc-usa.com,barbara.jackson@rndc-usa.com,rodney.williams@rndc-usa.com",
        "ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = concat($orgId, ''_Org_Profile'');"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-static-route-missing-threshold');


-- (PEN)
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
        "toEmail":"Ryan.Metz@rndc-usa.com, John.Hall@rndc-usa.com, Anthony.Coleman@rndc-usa.com, Dazzle.Keyser@rndc-usa.com, Douglas.Garner@rndc-usa.com",
        "ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = concat($orgId, ''_Org_Profile'');"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='PEN') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-static-route-missing-threshold');

-- (Unnamed)
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
    "sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = concat($orgId, ''_Org_Profile'');"
}' 
where warehouseid in (select wl.warehouseid
            from app.warehouselocation wl  
            where wl.warehouseshortname not in  ('ASH', 'POR', 'SAA', 'WSD', 'PEN'))
    and requesttypeid=(select rt.requesttypeid
                from app.requesttype rt 
                where rt.description='db-alert-static-route-missing-threshold');


-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-static-route-missing-threshold'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-static-route-missing-threshold'
and wld.payload is not null
order by wld.lastupdatedon



select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-static-route-missing-threshold'
and wld.payload is not null
order by wl.warehouseshortname


-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-static-route-missing-threshold'
) t 
where (payload::jsonb IS NOT NULL);
