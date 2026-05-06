select *
from app.warehouselocationdetail
where description like '%olpn-cons-loc%';

-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-olpn-cons-loc.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-olpn-cons-loc' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);







-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselocation
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-olpn-cons-loc')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:


--  Named queries (enabled (SAA, POR) as of writing)
--   SAA
update app.warehouselocationdetail set payload = '{
    "alertName":"Shipped Olpn W/ Consolidation Location Assignment",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br />Manhattan Case 8435111 is open for this.<br /><br />***MSP TO CLEAN UP***<br /><br />Steps to Clear:<br /><br />Delete the consolidation location assignments using the following endpoint.<br /><br /><br />DELETE {{app_host}}/dcconsolidation/api/stagingLocationAssignment/locationCapacityTracking/{{PK}}<br /><br /><br /><br /><br />***MSP TO CLEAN UP*** <br /><br />Description: <br />1. Location Inventory UI – Rebuild the location<br />2. Location Item Assignments UI – Delete the Location Item Assignment<br /><br />Note: Manhattan Case 7092460 is opened for this.</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"select CLIA.ORG_ID, CLIA.LPN_ID, CLIA.LOCATION_ID, CLIA.PK, CLIA.UPDATED_TIMESTAMP, CONCAT(O.STATUS,''-'',STAT.DESCRIPTION) ''OLPN_STATUS'' from default_dcconsolidation.SLA_LPN_LOCATION_ASSIGNMENT CLIA LEFT JOIN default_pickpack.PPK_OLPN O ON O.ORG_ID = CLIA.ORG_ID AND CLIA.LPN_ID = O.OLPN_ID LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = O.STATUS WHERE CLIA.ORG_ID = $orgId AND O.STATUS = ''8000'';"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='SAA') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-olpn-cons-loc');




--   POR
update app.warehouselocationdetail set payload = '{
    "alertName":"Shipped Olpn W/ Consolidation Location Assignment",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br />Manhattan Case 8435111 is open for this.<br /><br />***MSP TO CLEAN UP***<br /><br />Steps to Clear:<br /><br />Delete the consolidation location assignments using the following endpoint.<br /><br /><br />DELETE {{app_host}}/dcconsolidation/api/stagingLocationAssignment/locationCapacityTracking/{{PK}}<br /><br /><br /><br /><br />***MSP TO CLEAN UP*** <br /><br />Description: <br />1. Location Inventory UI – Rebuild the location<br />2. Location Item Assignments UI – Delete the Location Item Assignment<br /><br />Note: Manhattan Case 7092460 is opened for this.</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"select CLIA.ORG_ID, CLIA.LPN_ID, CLIA.LOCATION_ID, CLIA.PK, CLIA.UPDATED_TIMESTAMP, CONCAT(O.STATUS,''-'',STAT.DESCRIPTION) ''OLPN_STATUS'' from default_dcconsolidation.SLA_LPN_LOCATION_ASSIGNMENT CLIA LEFT JOIN default_pickpack.PPK_OLPN O ON O.ORG_ID = CLIA.ORG_ID AND CLIA.LPN_ID = O.OLPN_ID LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = O.STATUS WHERE CLIA.ORG_ID = $orgId AND O.STATUS = ''8000'';"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='POR') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-olpn-cons-loc');







-- (Unnamed)
--  Disabled queries
update app.warehouselocationdetail set payload = '{
    "alertName":"Shipped Olpn W/ Consolidation Location Assignment",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br />Manhattan Case 8435111 is open for this.<br /><br />***MSP TO CLEAN UP***<br /><br />Steps to Clear:<br /><br />Delete the consolidation location assignments using the following endpoint.<br /><br /><br />DELETE {{app_host}}/dcconsolidation/api/stagingLocationAssignment/locationCapacityTracking/{{PK}}<br /><br /><br /><br /><br />***MSP TO CLEAN UP*** <br /><br />Description: <br />1. Location Inventory UI – Rebuild the location<br />2. Location Item Assignments UI – Delete the Location Item Assignment<br /><br />Note: Manhattan Case 7092460 is opened for this.</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"select CLIA.ORG_ID, CLIA.LPN_ID, CLIA.LOCATION_ID, CLIA.PK, CLIA.UPDATED_TIMESTAMP, CONCAT(O.STATUS,''-'',STAT.DESCRIPTION) ''OLPN_STATUS'' from default_dcconsolidation.SLA_LPN_LOCATION_ASSIGNMENT CLIA LEFT JOIN default_pickpack.PPK_OLPN O ON O.ORG_ID = CLIA.ORG_ID AND CLIA.LPN_ID = O.OLPN_ID LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = O.STATUS WHERE CLIA.ORG_ID = $orgId AND O.STATUS = ''8000'';"
}' 
where warehouseid in (select wl.warehouseid
            from app.warehouselocation wl  
            where wl.warehouseshortname not in  ('SAA', 'POR'))
    and requesttypeid=(select rt.requesttypeid
                from app.requesttype rt 
                where rt.description='db-alert-olpn-cons-loc');


 

-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-olpn-cons-loc'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-olpn-cons-loc'
and wld.payload is not null
order by wld.lastupdatedon



select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-olpn-cons-loc'
and wld.payload is not null
order by wl.warehouseshortname


-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-olpn-cons-loc'
) t 
where (payload::jsonb IS NOT NULL);
