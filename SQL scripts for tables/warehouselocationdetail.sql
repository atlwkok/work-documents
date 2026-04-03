
-- do $$
-- BEGIN
 
-- 	END IF;
 



select * 
from app.warehouselocationdetail wld join app.warehouselocation wl on wld.warehouseid = wl.warehouseid
where description ='db-alert-static-route-missing-threshold'
order by wld.description asc, wld.warehouseid asc;



-- db-alert-static-route-missing-threshold. 
-- insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
-- 	select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
-- 		from app.warehouselocation w, app.requesttype rt 
-- 		where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
-- 		and rt.description = 'db-alert-static-route-missing-threshold' 
-- 		and not exists (select 1 from app.warehouselocationdetail r 
-- 							where r.requesttypeid = rt.requesttypeid 
-- 							and r.warehouseid = w.warehouseid);


-- update app.warehouselocationdetail set payload = '{
-- 	"alertName":"STATIC ROUTE MISSING THRESHOLD VALUE",
-- 	"dataSource":"MAWM",
-- 	"database":{
-- 		"connection":"MAPRD_NEW",
-- 		"type":"MySQL",
-- 		"uri":"jdbc:{host}:{port}/information_schema"
-- 	},
-- 	"email":{
-- 		"subject":"Splunk Alert: $alertName$",
-- 		"body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Configure the necessary values in the Static Route UI</pre>",
-- 		"fromEmail":"wms-tools-noreply@rndc-usa.com",
-- 		"toEmail":"Jonathan.Snell@RNDC-USA.COM, Preston.Mccauley@RNDC-USA.COM, Rob.Garcia@RNDC-USA.COM, Jordan.Stoll@rndc-usa.com, Richard.Gay@RNDC-USA.COM, Billy.Calloway@RNDC-USA.COM, Ryan.Black@rndc-usa.com",
-- 		"ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
-- 		"footer":"",
-- 		"attachment":["link-to-alert","link-to-results", "inline-table"]
-- 	},
-- 	"sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = ''$orgId_Org_Profile'' "
-- }' where warehouseid = (select w.warehouseid 
-- 						from app.warehouselocation w 
-- 						where w.warehouseshortname='ASH') 
-- 	and requesttypeid=(select rt.requesttypeid 
-- 						from app.requesttype rt 
-- 						where rt.description='db-alert-static-route-missing-threshold');


-- (POR)
-- update app.warehouselocationdetail set payload = '{
-- 	"alertName":"STATIC ROUTE MISSING THRESHOLD VALUE",
-- 	"dataSource":"MAWM",
-- 	"database":{
-- 		"connection":"MAPRD_NEW",
-- 		"type":"MySQL",
-- 		"uri":"jdbc:{host}:{port}/information_schema"
-- 	},
-- 	"email":{
-- 		"subject":"Splunk Alert: $alertName$",
-- 		"body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Configure the necessary values in the Static Route UI</pre>",
-- 		"fromEmail":"wms-tools-noreply@rndc-usa.com",
-- 		"toEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM",
-- 		"ccEmail":"",
-- 		"footer":"",
-- 		"attachment":["link-to-alert","link-to-results", "inline-table"]
-- 	},
-- 	"sql":"SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = ''$orgId_Org_Profile'' "
-- }' where warehouseid = (select w.warehouseid 
-- 						from app.warehouselocation w 
-- 						where w.warehouseshortname='POR') 
-- 		and requesttypeid=(select rt.requesttypeid 
-- 							from app.requesttype rt 
-- 							where rt.description='db-alert-static-route-missing-threshold');






