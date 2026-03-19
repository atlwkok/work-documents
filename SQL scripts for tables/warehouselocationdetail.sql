-- insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby)
-- select rt.description, rt.description, w.warehouseid, rt.requesttypeid, 'sysuser', 'sysuser' 
-- 	from app.warehouselocation w, app.requesttype rt 
-- 	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV')
-- 		and rt.description in ('orders-deselected-waving')
-- 		and not exists (select 1 from app.warehouselocationdetail r 
-- 						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid);


select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description = 'orders-deselected-waving'
	AND wld.warehouseid = wl.warehouseid
	AND wl.warehouseshortname in ('OAH')


select *
from app.warehouselocationdetail;

select * 
from app.warehouselocationdetail  
where description='orders-deselected-waving';


update app.warehouselocationdetail 
set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Teppi.Waxman@RNDC-USA.COM, stanley.monis@rndc-usa.com, SeoFoo.Dang@RNDC-USA.COM, Vincent.Labasan@RNDC-USA.COM, Amorsolo.Angco@rndc-usa.com, Wallace.Moniz@RNDC-USA.COM, Reoben.Aquino@RNDC-USA.COM, ashlyn.javier@rndc-usa.com CC: wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.dco_plan_run_deselect_count DE join default_dcorder.dco_order_plan_run_strategy PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.dco_order O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
where warehouseid=(select wl.warehouseid
                    from app.warehouselocationdetail wld, app.warehouselocation wl
                    where wld.description = 'orders-deselected-waving'
                    AND wld.warehouseid = wl.warehouseid
                    AND wl.warehouseshortname in ('OAH'));



-- SELECT wld.warehousedetailid, wld.description, wld.warehouseid, wl.warehouseshortname, wld.payload
-- FROM app.warehouselocationdetail wld, app.warehouselocation wl
-- where description='db-alert-order-stuck-15m' and wld.warehouseid = wl.warehouseid
-- ORDER BY wld.payload, wl.warehouseshortname ASC 