
-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-pix-spec-gt1h.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-pix-spec-gt1h' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);








-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselo
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-pix-spec-gt1h')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:


-- Named queries (enabled only (ALL) as of writing)
update app.warehouselocationdetail set payload = '{
    "alertName":"MAWM PIX Specification Found > 1 Hour",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br /><br />Manhattan Case:  8461889<br /><br />Clean-Up Steps:<br /><br />1) Use the following API & payload to clear this alert.<br /><br />POST {{app_host}}/pix/api/pix/pixEntry/save<br /><br />{<br />    \"PK\": \"{{PK}}\",<br />    \"StatusId\": \"9000\"<br />}<br /></pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@RNDC-USA.COM, WMSConsultant@RNDC-USA.COM, fargueta@manh.com, mcurtis@manh.com, anamburi@manh.com, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com, WMSMSPSupport@RNDC-USA.COM",
        "ccEmail":"wmsinternal@RNDC-USA.COM, WMSConsultant@RNDC-USA.COM, fargueta@manh.com, mcurtis@manh.com, anamburi@manh.com, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com, WMSMSPSupport@RNDC-USA.COM",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT P.org_id, P.pix_specification_id, PS.description, P.pix_event_payload_id, P.updated_timestamp, P.pk FROM default_pix.PIX_PIX_ENTRY P LEFT JOIN default_pix.PIX_PIX_STATUS PS ON PS.status_id = P.status_id WHERE P.status_id NOT IN ( ''9000'', ''8000'' ) AND P.updated_timestamp < Now() - INTERVAL 1 hour AND P.updated_timestamp > Now() - INTERVAL 1*24*365 hour ORDER BY P.updated_timestamp DESC;"
}' where requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-pix-spec-gt1h');





 -- (Unnamed)
 


-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-pix-spec-gt1h'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-pix-spec-gt1h'
and wld.payload is not null
order by wld.lastupdatedon



-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-pix-spec-gt1h'
) t 
where (payload::jsonb IS NOT NULL);
