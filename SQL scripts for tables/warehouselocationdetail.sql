
-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-waves-long-abort.
 
insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-routed-cancelled' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);









-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselo
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-routed-cancelled')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:

-- Named queries (enabled only - PEN, POR, WSD, DFB, [LOU excluded for now as it uses Oracle] as of writing)
-- (PEN)
update app.warehouselocationdetail set payload = '{
    "alertName":"ROUTED ORDERS CANCELLED",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />Description: <br />Verify in Driver Check-In that product was physically shipped to customer. Generate non-WMS invoice to customer to create positive *F transaction as cancelled invoice in Alpha and Oracle will relieve pending shipment and customer''s A/R will be credited automatically. Corresponding offset will be negative cycle count since product was never systematically shipped from WM.<br /></pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"Ryan.Metz@rndc-usa.com, John.Hall@rndc-usa.com, Anthony.Coleman@rndc-usa.com, Dazzle.Keyser@rndc-usa.com, Douglas.Garner@rndc-usa.com",
        "ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type, O.billing_account_number, O.bill_to_name AS ''CUSTOMER'' , Concat(O.maximum_status,''-'',DS.description) ''ORDER_STATUS'', OLI.original_order_planning_run_id , OLI.item_id ''SKU'', OLI.description ''SKU_DESCRIPTION'' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = ''STANDARD'' AND O.maximum_status = ''9000'' AND O.updated_timestamp >= Now() - INTERVAL 1 day;"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='PEN') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-routed-cancelled');


-- (POR)
update app.warehouselocationdetail set payload = '{
    "alertName":"ROUTED ORDERS CANCELLED",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />Description: <br />Verify in Driver Check-In that product was physically shipped to customer. Generate non-WMS invoice to customer to create positive *F transaction as cancelled invoice in Alpha and Oracle will relieve pending shipment and customer''s A/R will be credited automatically. Corresponding offset will be negative cycle count since product was never systematically shipped from WM.<br /></pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"bryce.meyer@rndc-usa.com, Michael.Ferdinand@Penske.com, abel.paucardelacruz@rndc-usa.com, Sara.Farrington@Penske.com, Matthew.Chavez@Penske.com,Jesse.Butler@Penske.com, Brian.Bontemps@penske.com",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type, O.billing_account_number, O.bill_to_name AS ''CUSTOMER'' , Concat(O.maximum_status,''-'',DS.description) ''ORDER_STATUS'', OLI.original_order_planning_run_id , OLI.item_id ''SKU'', OLI.description ''SKU_DESCRIPTION'' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = ''STANDARD'' AND O.maximum_status = ''9000'' AND O.updated_timestamp >= Now() - INTERVAL 1 day;"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='POR') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-routed-cancelled');



-- (WSD)
update app.warehouselocationdetail set payload = '{
    "alertName":"ROUTED ORDERS CANCELLED",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />Description: <br />Verify in Driver Check-In that product was physically shipped to customer. Generate non-WMS invoice to customer to create positive *F transaction as cancelled invoice in Alpha and Oracle will relieve pending shipment and customer''s A/R will be credited automatically. Corresponding offset will be negative cycle count since product was never systematically shipped from WM.<br /></pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"demetrius.dever@rndc-usa.com,Michael.Clark@RNDC-USA.com,guy.sriwatcharakul@rndc-usa.com,hank.dryden@rndc-usa.com",
        "ccEmail":"wmsinternal@rndc-usa.com",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type, O.billing_account_number, O.bill_to_name AS ''CUSTOMER'' , Concat(O.maximum_status,''-'',DS.description) ''ORDER_STATUS'', OLI.original_order_planning_run_id , OLI.item_id ''SKU'', OLI.description ''SKU_DESCRIPTION'' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = ''STANDARD'' AND O.maximum_status = ''9000'' AND O.updated_timestamp >= Now() - INTERVAL 1 day;"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-routed-cancelled');



-- (DFB)
update app.warehouselocationdetail set payload = '{
    "alertName":"ROUTED ORDERS CANCELLED",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />Description: <br />Verify in Driver Check-In that product was physically shipped to customer. Generate non-WMS invoice to customer to create positive *F transaction as cancelled invoice in Alpha and Oracle will relieve pending shipment and customer''s A/R will be credited automatically. Corresponding offset will be negative cycle count since product was never systematically shipped from WM.<br /></pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"Frank.Ryan@RNDC-USA.COM,  Jamil.Tate@rndc-usa.com, Angel.Gutierrez@RNDC-USA.COM, David.Gould2@rndc-usa.com, don.hamlin@rndc-usa.com",
        "ccEmail":"WMSInternal@rndc-usa.com",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type, O.billing_account_number, O.bill_to_name AS ''CUSTOMER'' , Concat(O.maximum_status,''-'',DS.description) ''ORDER_STATUS'', OLI.original_order_planning_run_id , OLI.item_id ''SKU'', OLI.description ''SKU_DESCRIPTION'' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = ''STANDARD'' AND O.maximum_status = ''9000'' AND O.updated_timestamp >= Now() - INTERVAL 1 day;"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='DFB') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-routed-cancelled');




 -- (Unnamed)
update app.warehouselocationdetail set payload = '{
    "alertName":"ROUTED ORDERS CANCELLED",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />Description: <br />Verify in Driver Check-In that product was physically shipped to customer. Generate non-WMS invoice to customer to create positive *F transaction as cancelled invoice in Alpha and Oracle will relieve pending shipment and customer''s A/R will be credited automatically. Corresponding offset will be negative cycle count since product was never systematically shipped from WM.<br /></pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type, O.billing_account_number, O.bill_to_name AS ''CUSTOMER'' , Concat(O.maximum_status,''-'',DS.description) ''ORDER_STATUS'', OLI.original_order_planning_run_id , OLI.item_id ''SKU'', OLI.description ''SKU_DESCRIPTION'' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = ''STANDARD'' AND O.maximum_status = ''9000'' AND O.updated_timestamp >= Now() - INTERVAL 1 day;"
}' 
where warehouseid in (select wl.warehouseid
            from app.warehouselocation wl  
            where wl.warehouseshortname not in  ('PEN', 'POR', 'WSD', 'DFB'))
    and requesttypeid=(select rt.requesttypeid
                from app.requesttype rt 
                where rt.description='db-alert-routed-cancelled');


-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-routed-cancelled'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-routed-cancelled'
and wld.payload is not null
order by wld.lastupdatedon



-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-routed-cancelled'
) t 
where (payload::jsonb IS NOT NULL);
