select *
from app.warehouselocationdetail
where description like '%tmp-inv-no-resv%';

-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-item-wt-large.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-item-wt-large' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);







-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselocation
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-item-wt-large')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:

--  db-alert-item-wt-large.
 
--  Named queries (only (ALL) as of writing)
--   ALL
update app.warehouselocationdetail set payload = '{
    "alertName":"MAWM - Items Weight With Large Dimensions",
    "dataSource":"MAWM",
    "database":{
        "connection":"MAPRD_NEW",
        "type":"MySQL",
        "uri":"jdbc:{host}:{port}/information_schema"
    },
    "email":{
        "subject":"Splunk Alert: $name$",
        "body":"",
        "fromEmail":"wms-tools-noreply@rndc-usa.com",
        "toEmail":"wmsinternal@RNDC-USA.COM, anamburi@manh.com, DL_RNDC_MAWM_CSO@manh.com, mcurtis@manh.com, WMSMSPSupport@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com",
        "ccEmail":"",
        "footer":"",
        "attachment":["link-to-alert","link-to-results", "inline-table"]
    },
    "sql":"SELECT ORG, COUNT(*) AS ''ORG_COUNT'', JSON_ARRAYAGG( JSON_OBJECT( ''ItemId'', ITEM_ID, ''StandardQuantityUomIdDisplay'', STANDARD_QUANTITY_UOM_ID, ''UomId'', UOM_ID, ''Quantity'', QUANTITY ) ) AS ''SPLUNK'' FROM ( SELECT LEFT(II.PROFILE_ID, 3) AS ''ORG'', II.ITEM_ID, II.DESCRIPTION, IP.VOLUME, IP.WEIGHT, IP.QUANTITY, IP.STANDARD_QUANTITY_UOM_ID, IP.UOM_ID FROM default_item_master.ITE_ITEM_PACKAGE IP JOIN default_item_master.ITE_ITEM II ON IP.ITEM_PK = II.PK WHERE IP.STANDARD_QUANTITY_UOM_ID IN (''PACK'', ''UNIT'') AND IP.WEIGHT > ''100000'' AND CONCAT(LEFT(II.PROFILE_ID,3), II.ITEM_ID) IN (SELECT CONCAT(ORG_ID, ITEM_ID) FROM default_dcinventory.DCI_INVENTORY) ) package GROUP BY ORG ORDER BY ORG;"
}' where requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-item-wt-large');







-- (Unnamed)
--  Disabled queries



 

-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-item-wt-large'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-item-wt-large'
and wld.payload is not null
order by wld.lastupdatedon



select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-item-wt-large'
and wld.payload is not null
order by wl.warehouseshortname


-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-item-wt-large'
) t 
where (payload::jsonb IS NOT NULL);
