
-- do $$
-- BEGIN
 
-- 	END IF;
 
		

  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%desig%')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname


-- insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby)
-- select rt.description, rt.description, w.warehouseid, rt.requesttypeid, 'sysuser', 'sysuser' 
-- 	from app.warehouselocation w, app.requesttype rt 
-- 	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV')
-- 		and rt.description in ('db-alert-order-no-desig-assign')
-- 		and not exists (select 1 from app.warehouselocationdetail r 
-- 						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid);

 
-- Named queries
-- (SIO)
update app.warehouselocationdetail 
set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br /><br />Note: Manhattan Case 8479040 is opened for this.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Roxanne.Bernal@RNDC-USA.COM;John.Hay@RNDC-USA.COM;Jeffrey.Meyer@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
where warehouseid=(select wl.warehouseid
                    from app.warehouselocationdetail wld, app.warehouselocation wl
                    where wld.description = 'db-alert-order-no-desig-assign'
                    AND wld.warehouseid = wl.warehouseid
                    AND wl.warehouseshortname in ('SIO')); 


-- (ASH)
update app.warehouselocationdetail 
set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Call the ServiceDesk to correct this condition.  866-RNDC-HLP (866-763-2457)<br /><br />Note: Manhattan Case 8479040 is opened for this.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Jonathan.Snell@RNDC-USA.COM, Preston.Mccauley@RNDC-USA.COM, Rob.Garcia@RNDC-USA.COM, Jordan.Stoll@rndc-usa.com, Billy.Calloway@RNDC-USA.COM, Ryan.Black@rndc-usa.com, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
where warehouseid=(select wl.warehouseid
                    from app.warehouselocationdetail wld, app.warehouselocation wl
                    where wld.description = 'db-alert-order-no-desig-assign'
                    AND wld.warehouseid = wl.warehouseid
                    AND wl.warehouseshortname in ('ASH')); 
-- (DEN)
update app.warehouselocationdetail 
set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Call the ServiceDesk to correct this condition.  866-RNDC-HLP (866-763-2457)<br /><br />Note: Manhattan Case 8479040 is opened for this.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"ray.burris@rndc-usa.com,larry.ayres@rndc-usa.com,josh.gevara@rndc-usa.com,jake.obrien@rndc-usa.com, jesse.jordan@rndc-usa.com, jamia.dixon@rndc-usa.com, chuck.kehoe@rndc-usa.com, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com,Dakota.Hall@RNDC-USA.COM,Anthony.Gallegos@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
where warehouseid=(select wl.warehouseid
                    from app.warehouselocationdetail wld, app.warehouselocation wl
                    where wld.description = 'db-alert-order-no-desig-assign'
                    AND wld.warehouseid = wl.warehouseid
                    AND wl.warehouseshortname in ('DEN')); 


-- (POR)
update app.warehouselocationdetail 
set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />The helpdesk should be called to rectify the problem as soon as possible.  If the helpdesk is not called, then there is a chance that the orders will not make the truck.  It is also imperative to call immediately and hold processing in sortation vendor (Shiraz/IndaGO/Dematic/CSD) in order to make sure you plan the original route number and new route numbers back-to-back as it makes it easier to load the truck.  866-RNDC-HLP (866-763-2457) Note: Manhattan Case 7428226 is opened for this</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"bryce.meyer@rndc-usa.com, Michael.Ferdinand@Penske.com, abel.paucardelacruz@rndc-usa.com, Sara.Farrington@Penske.com, Matthew.Chavez@Penske.com,Jesse.Butler@Penske.com, Brian.Bontemps@penske.com","ccEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
where warehouseid=(select wl.warehouseid
                    from app.warehouselocationdetail wld, app.warehouselocation wl
                    where wld.description = 'db-alert-order-no-desig-assign'
                    AND wld.warehouseid = wl.warehouseid
                    AND wl.warehouseshortname in ('POR')); 


-- (SAA)
update app.warehouselocationdetail 
set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />The helpdesk should be called to rectify the problem as soon as possible.  If the helpdesk is not called, then there is a chance that the orders will not make the truck.  It is also imperative to call immediately and hold processing in sortation vendor (Shiraz/IndaGO/Dematic/CSD) in order to make sure you plan the original route number and new route numbers back-to-back as it makes it easier to load the truck.  866-RNDC-HLP (866-763-2457) Note: Manhattan Case 7428226 is opened for this</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Travis.Eldridge@rndc-usa.com,Alex.Rios@rndc-usa.com,joseph.duran@rndc-usa.com,travis.gusler@rndc-usa.com,christopher.gonzales@rndc-usa.com,Larry.Shelton@RNDC-USA.COM,Octavio.Chavez@RNDC-USA.COM, ameron.phipps@rndc-usa.com, andre.dockery@rndc-usa.com, amanda.santos@rndc-usa.com, Armando.Granados@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
where warehouseid=(select wl.warehouseid
                    from app.warehouselocationdetail wld, app.warehouselocation wl
                    where wld.description = 'db-alert-order-no-desig-assign'
                    AND wld.warehouseid = wl.warehouseid
                    AND wl.warehouseshortname in ('SAA')); 




-- Unnamed queries (all other org ids)
update app.warehouselocationdetail 
set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"wmsinternal@RNDC-USA.COM, WMSadmin@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM","ccEmail":"","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
where warehouseid in (select wl.warehouseid
                    from app.warehouselocationdetail wld, app.warehouselocation wl
                    where wld.description = 'db-alert-order-no-desig-assign'
                    AND wld.warehouseid = wl.warehouseid
                    AND wl.warehouseshortname not in ('SIO, ASH, DEN, POR, SAA'));