 

-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-matm-spo-import.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-matm-spo-import' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);







-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselo
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-matm-spo-import')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:

-- Named queries (enabled only (RNDC) as of writing)
update app.warehouselocationdetail set payload = '{
    "alertName":"MATM - SPO Import Failure",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />This alert highlights PO import errors in TMS. POs will not tender to a carrier until the data condition mentioned in the alert is corrected and the PO successfully imports into TMS.</pre>",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"IBTransportation@rndc-usa.com, InventoryPlanners-SupplyChain@rndc-usa.com, newsupplier@rndc-usa.com",
        "ccEmail":"TMSTeam@RNDC-USA.COM, Tonja.Speegle@RNDC-USA.COM, Brenda.Weeks@RNDC-USA.COM, Bobby.Grant@RNDC-USA.COM, WMSMSPSupport@rndc-usa.com, Helena.Yates@rndc-usa.com, pam.thomas@rndc-usa.com, wmsinternal@rndc-usa.com",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"WITH t AS (SELECT CFM.created_timestamp, Substring_index(CFM.payload ->> ''$.PurchaseRequestId'', ''_'', 1) AS ''MARKET'', Substring_index(CFM.payload ->> ''$.PurchaseRequestId'', ''_'', -1) AS ''PO_NUMBER'', CFM.payload ->> ''$.BillingMethodId'' AS ''BILLING_METHOD'', CFM.payload ->> ''$.Extended.Buyer'' AS ''BUYER'', CFM.payload ->> ''$.Extended.SupplierCode'' AS ''SUPPLIER_CODE'', CFM.payload ->> ''$.Extended.SupplierName'' AS ''SUPPLIER_NAME'', CFM.error_message AS ''ERROR_CODE'', CFM.exception_messages ->> ''$[0].Description'' AS ''DESCRIPTION'' FROM default_commonutil.CUT_FAILED_MESSAGE CFM WHERE org_id = ''RNDC'' AND queue_name = ''XNT_VEN_PurchaseRequest'' AND error_code = ''VCO::171'' AND created_timestamp >= Now() - interval 1 day) SELECT * FROM t WHERE t.billing_method = ''Collect'' ORDER BY market;"
}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='RNDC') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-matm-spo-import');




-- (Unnamed)
-- unused as only 1 query enabled for RNDC orgId at this time and nothing else.
 


-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-matm-spo-import'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-matm-spo-import'
and wld.payload is not null
order by wld.lastupdatedon



-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-matm-spo-import'
) t 
where (payload::jsonb IS NOT NULL);
