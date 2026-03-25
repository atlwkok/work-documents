-- insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby)
-- select rt.description, rt.description, w.warehouseid, rt.requesttypeid, 'sysuser', 'sysuser' 
-- 	from app.warehouselocation w, app.requesttype rt 
-- 	where w.warehouseshortname not in ('DEFAULTS', 'PRODEV')
-- 		and rt.description in ('orders-deselected-waving')
-- 		and not exists (select 1 from app.warehouselocationdetail r 
-- 						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid);


-- select *
-- 	from app.warehouselocationdetail wld, app.warehouselocation wl
-- 	where wld.description = 'orders-deselected-waving'
-- 	AND wld.warehouseid = wl.warehouseid
-- 	AND wl.warehouseshortname in ('OAH')


-- select *
-- from app.warehouselocationdetail;

-- select * 
-- from app.warehouselocationdetail  
-- where description='orders-deselected-waving';


-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Teppi.Waxman@RNDC-USA.COM, stanley.monis@rndc-usa.com, SeoFoo.Dang@RNDC-USA.COM, Vincent.Labasan@RNDC-USA.COM, Amorsolo.Angco@rndc-usa.com, Wallace.Moniz@RNDC-USA.COM, Reoben.Aquino@RNDC-USA.COM, ashlyn.javier@rndc-usa.com CC: wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.dco_plan_run_deselect_count DE join default_dcorder.dco_order_plan_run_strategy PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.dco_order O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
-- where warehouseid=(select wl.warehouseid
--                     from app.warehouselocationdetail wld, app.warehouselocation wl
--                     where wld.description = 'orders-deselected-waving'
--                     AND wld.warehouseid = wl.warehouseid
--                     AND wl.warehouseshortname in ('OAH'));



-- SELECT wld.warehousedetailid, wld.description, wld.warehouseid, wl.warehouseshortname, wld.payload
-- FROM app.warehouselocationdetail wld, app.warehouselocation wl
-- where description='db-alert-order-stuck-15m' and wld.warehouseid = wl.warehouseid
-- ORDER BY wld.payload, wl.warehouseshortname ASC 




-- select *
-- from app.warehouselocationdetail 
-- where description = 'db-alert-lia-pack-uom'
-- and warehouseid in (42, 31);










-- select *
-- 	from app.warehouselocationdetail wld, app.warehouselocation wl
-- 	where wld.description like ('%stuck%')
-- 	AND wld.warehouseid = wl.warehouseid 
-- 	order by wld.warehouseid


-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"ORDERS STUCK IN CREATED STATUS > 15 MINUTES","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre><br />The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br /><br />Note: Manhattan Case 8199748 is created.<br /><br />Description: <br />1. Go to System Management>Tranlog Summary>XNT_DCO_OriginalOrders <br />2. Type in the Order Number for the Order Stuck in Created Status<br />3. Pull the JSON for the order and Put it in this API, but do not run Yet<br />            {{app_host}}/dcorder/api/dcorder/originalOrder/save<br />4. Delete the Original Order Using this API, Replace XXX with the House, and update the Order_Id<br />            {{app_host}}/dcorder/api/dcorder/originalOrder/bulkDelete<br />                {<br />    ''Data'': [<br />        {<br />            ''OrderId'': ''123123'',<br />            ''OriginFacilityId'': ''XXX''<br />        }<br />    ]<br />}<br />5. Delete the Order Using this API, Replace XXX with the House, and update the Order_Id<br />                {{app_host}}/dcorder/api/dcorder/order/bulkDelete<br />                {<br />    ''Data'': [<br />        {<br />            ''OriginalOrderId'': ''123123'',<br />            ''OriginFacilityId'': ''XXX''<br />        }<br />    ]<br />}<br />6. Reimport the Order using the JSON from Step 3<br /></body><br /></pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"wmsinternal@RNDC-USA.COM, WMSConsultant@rndc-usa.com, Mcurtis@manh.com, WMSMSPSupport@RNDC-USA.COM,DL_MANH_RNDC_MAWM_PSO@manh.com,DL_RNDC_MAWM_CSO@manh.com", "ccEmail": "","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT OO.ORG_ID ''Org ID'', OO.CREATED_TIMESTAMP ''Created Timestamp'',OO.BILLING_ACCOUNT_NUMBER ''Billing Acct #'', OO.ORIGINAL_ORDER_ID ''Original Order ID'', OO.ORDER_TYPE ''Order Type'', OO.MAXIMUM_STATUS ''Maximum Status'', STATUS.DESCRIPTION ''Description'', OO.CANCELLED ''Cancelled'', OO.BILL_TO_NAME ''Bill-to Name'', OO.EXT_ROUTE_ID ''Ext Route ID'', OO.EXT_SHIPMENT_STOP_NUMBER ''Ext Shipment Stop #'' FROM default_dcorder.DCO_ORIGINAL_ORDER OO JOIN default_dcorder.DCO_ORDER_STATUS STATUS ON OO.MAXIMUM_STATUS = STATUS.ORDER_STATUS_ID WHERE 1=1 AND (OO.MAXIMUM_STATUS = ''0000'' or OO.MAXIMUM_STATUS = ''0000'') AND OO.CREATED_TIMESTAMP <= DATE_SUB(now(), INTERVAL ''10'' MINUTE);"}'
-- where requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-order-stuck-15m');









-- select wl.warehouseid, wl.warehouseshortname
-- from app.warehouselocationdetail wld, app.warehouselocation wl
-- where wld.description = 'orders-deselected-waving'
-- AND wld.warehouseid = wl.warehouseid
-- AND wl.warehouseshortname not in ('ABQ, ASH, ATL, DEN, DFB, HAW, IND, KAP, KAU, MAU, OAH, PEN, POR');




-- do $$
-- BEGIN

--     IF NOT EXISTS(SELECT 1
--         FROM   information_schema.tables WHERE  table_schema = 'app' AND table_name = 'warehouselocationdetail')
--     THEN
-- 		CREATE TABLE app.warehouselocationdetail (
-- 	        warehousedetailid BIGSERIAL PRIMARY KEY NOT NULL,
-- 	        Description varchar NOT NULL,
--             longdescription varchar NOT NULL,
-- 			warehouseid int2 references app.warehouselocation(warehouseid),
-- 			requesttypeid int2 references app.RequestType,
-- 			payload varchar, -- this is the json string for specific request per warehouse
-- 			CreatedBy varchar not null, 
-- 			CreatedOn timestamp not null default CURRENT_TIMESTAMP,
-- 			LastUpdatedBy varchar not null,
-- 			LastUpdatedOn timestamp not null default CURRENT_TIMESTAMP
--         );
-- 	END IF;
--     IF EXISTS(SELECT 1
--         FROM   information_schema.tables WHERE  table_schema = 'app' AND table_name = 'warehouselocationdetail')
--     THEN
	
-- 		-- orders-deselected-waving. 
-- 		insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby)
-- 		select rt.description, rt.description, w.warehouseid, rt.requesttypeid, 'sysuser', 'sysuser' 
-- 			from app.warehouselocation w, app.requesttype rt 
-- 			where w.warehouseshortname not in ('DEFAULTS', 'PRODEV')
-- 				and rt.description in ('orders-deselected-waving')
-- 				and not exists (select 1 from app.warehouselocationdetail r 
-- 								where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid);
		

 

       
 


 

--         -- Named, enabled queries group 1 
--         -- OAH
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Teppi.Waxman@RNDC-USA.COM, stanley.monis@rndc-usa.com, SeoFoo.Dang@RNDC-USA.COM, Vincent.Labasan@RNDC-USA.COM, Amorsolo.Angco@rndc-usa.com, Wallace.Moniz@RNDC-USA.COM, Reoben.Aquino@RNDC-USA.COM, ashlyn.javier@rndc-usa.com, wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","ccEmail":"","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('OAH'));


--         -- DFB/IND (identical except email)
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Description: <br />This alert displays routed orders that were deselected from the WMS wave.  Please call the IT Service Desk immediately to correct this condition.  <br /><br />Phone: 866-RNDC-HLP (866-763-2457)</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Frank.Ryan@RNDC-USA.COM, David.Gould2@rndc-usa.com, Don.Hamlin@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com,wmsconsultant@rndc-usa.com   , WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table","attach-csv"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('DFB'));

--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Description: <br />This alert displays routed orders that were deselected from the WMS wave.  Please call the IT Service Desk immediately to correct this condition.  <br /><br />Phone: 866-RNDC-HLP (866-763-2457)</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Stanley.FitzwaterJr@rndc-usa.com, Leroy.Chambers@RNDC-USA.COM, Michael.Clifton@RNDC-USA.COM, Raymond.Craig@RNDC-USA.COM, Patrick.Heath@rndc-usa.com, Russell.Mangel@rndc-usa.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table","attach-csv"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('IND'));


--         -- POR
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre><br />The alert condition for ''$name$'' was triggered.<br />***MSP TO CLEAN UP*** Description: This alert displays routed orders that were deselected from the WMS wave.  Please call the IT Service Desk immediately to correct this condition.  Phone: 866-RNDC-HLP (866-763-2457)<br /></pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"bryce.meyer@rndc-usa.com, Michael.Ferdinand@Penske.com, abel.paucardelacruz@rndc-usa.com, Sara.Farrington@Penske.com, Matthew.Chavez@Penske.com,Jesse.Butler@Penske.com, Brian.Bontemps@penske.com","ccEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com","footer":"","attachment":["link-to-alert","link-to-results","inline-table","attach-csv"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('POR'));


--         -- HAW/KAP/KAU/MAU/PEN (identical except email)
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Teppi.Waxman@RNDC-USA.COM, Jesse.Kahalioumi@RNDC-USA.COM, Mark.Carriaga@rndc-usa.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('HAW'));


--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Teppi.Waxman@RNDC-USA.COM, Titus.Manipon@rndc-usa.com, Reoben.Aquino@RNDC-USA.COM, ashlyn.javier@rndc-usa.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('KAP'));

--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Teppi.Waxman@RNDC-USA.COM, Derrik.Vuylsteke@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('KAU'));

--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Teppi.Waxman@RNDC-USA.COM, Kevin.Shiroma@RNDC-USA.COM, Darren.Aguinaldo@rndc-usa.com, marlon.guzman@rndc-usa.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('MAU'));

--         -- Named, enabled queries group 2 (PEN only; only this org has different query, but asked to use same query anyway)
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Ryan.Metz@rndc-usa.com, John.Hall@rndc-usa.com, Anthony.Coleman@rndc-usa.com, Dazzle.Keyser@rndc-usa.com, Douglas.Garner@rndc-usa.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('PEN'));





--         -- Named, disabled queries 
--         -- ABQ/ASH/DEN (identical except email)
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Description: <br />This alert displays routed orders that were deselected from the WMS wave.  Please call the IT Service Desk immediately to correct this condition.  <br /><br />Phone: 866-RNDC-HLP (866-763-2457)</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"ryan.mchenry@rndc-usa.com,franco.flores@rndc-usa.com,McHenry@rndc-usa.com,BENJAMIN.SUTTON@RNDC-USA.COM,Antonio.Larez@RNDC-USA.COM,wmsinternal@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table","attach-csv"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('ABQ'));
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Description: <br />This alert displays routed orders that were deselected from the WMS wave.  Please call the IT Service Desk immediately to correct this condition.  <br /><br />Phone: 866-RNDC-HLP (866-763-2457)</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Jonathan.Snell@RNDC-USA.COM, Preston.Mccauley@RNDC-USA.COM, Rob.Garcia@RNDC-USA.COM, Jordan.Stoll@rndc-usa.com, Richard.Gay@RNDC-USA.COM, Billy.Calloway@RNDC-USA.COM, Ryan.Black@rndc-usa.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table","attach-csv"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('ASH'));
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Description: <br />This alert displays routed orders that were deselected from the WMS wave.  Please call the IT Service Desk immediately to correct this condition.  <br /><br />Phone: 866-RNDC-HLP (866-763-2457)</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Larry.Ayres@RNDC-USA.COM,Ray.Burris@RNDC-USA.COM,Josh.Gevara@RNDC-USA.COM,JESSE.JORDAN@RNDC-USA.COM,JAMIA.DIXON@RNDC-USA.COM,Jake.OBrien@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com, chuck.kehoe@rndc-usa.com,Dakota.Hall@RNDC-USA.COM,Anthony.Gallegos@RNDC-USA.COM","ccEmail":"wmsinternal@RNDC-USA.COM , WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table","attach-csv"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('DEN'));


--         -- ATL
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"wmsinternal@RNDC-USA.COM, WMSadmin@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM","ccEmail":"","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid=(select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname in ('ATL'));



--         -- Unnamed queries (all other org ids)
--         update app.warehouselocationdetail 
--         set payload = '{"alertName":"STANDARD ORDERS DESELECTED DURING WAVING","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"wmsinternal@RNDC-USA.COM, WMSadmin@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM","ccEmail":"","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE ''STANDARD%%'' AND DE.deselected_order_lines > ''0'' AND DE.org_id = $orgId;"}'
--         where warehouseid in (select wl.warehouseid
--                             from app.warehouselocationdetail wld, app.warehouselocation wl
--                             where wld.description = 'orders-deselected-waving'
--                             AND wld.warehouseid = wl.warehouseid
--                             AND wl.warehouseshortname not in ('ABQ, ASH, ATL, DEN, DFB, HAW, IND, KAP, KAU, MAU, OAH, PEN, POR'));


-- 	END IF;
-- END
-- $$;

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
-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br /><br />Note: Manhattan Case 8479040 is opened for this.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Roxanne.Bernal@RNDC-USA.COM;John.Hay@RNDC-USA.COM;Jeffrey.Meyer@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.shp_shipment S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
-- where warehouseid=(select wl.warehouseid
-- 					from app.warehouselocationdetail wld, app.warehouselocation wl
-- 					where wld.description = 'db-alert-order-no-desig-assign'
-- 					AND wld.warehouseid = wl.warehouseid
-- 					AND wl.warehouseshortname in ('SIO')); 


					
--  -- (ASH)
-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Call the ServiceDesk to correct this condition.  866-RNDC-HLP (866-763-2457)<br /><br />Note: Manhattan Case 8479040 is opened for this.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Jonathan.Snell@RNDC-USA.COM, Preston.Mccauley@RNDC-USA.COM, Rob.Garcia@RNDC-USA.COM, Jordan.Stoll@rndc-usa.com, Billy.Calloway@RNDC-USA.COM, Ryan.Black@rndc-usa.com, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.shp_shipment S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
-- where warehouseid=(select wl.warehouseid
-- 					from app.warehouselocationdetail wld, app.warehouselocation wl
-- 					where wld.description = 'db-alert-order-no-desig-assign'
-- 					AND wld.warehouseid = wl.warehouseid
-- 					AND wl.warehouseshortname in ('ASH')); 
-- -- (DEN)
-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />Call the ServiceDesk to correct this condition.  866-RNDC-HLP (866-763-2457)<br /><br />Note: Manhattan Case 8479040 is opened for this.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"ray.burris@rndc-usa.com,larry.ayres@rndc-usa.com,josh.gevara@rndc-usa.com,jake.obrien@rndc-usa.com, jesse.jordan@rndc-usa.com, jamia.dixon@rndc-usa.com, chuck.kehoe@rndc-usa.com, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com,Dakota.Hall@RNDC-USA.COM,Anthony.Gallegos@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.shp_shipment S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
-- where warehouseid=(select wl.warehouseid
-- 					from app.warehouselocationdetail wld, app.warehouselocation wl
-- 					where wld.description = 'db-alert-order-no-desig-assign'
-- 					AND wld.warehouseid = wl.warehouseid
-- 					AND wl.warehouseshortname in ('DEN')); 


-- -- (POR)
-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />The helpdesk should be called to rectify the problem as soon as possible.  If the helpdesk is not called, then there is a chance that the orders will not make the truck.  It is also imperative to call immediately and hold processing in sortation vendor (Shiraz/IndaGO/Dematic/CSD) in order to make sure you plan the original route number and new route numbers back-to-back as it makes it easier to load the truck.  866-RNDC-HLP (866-763-2457) Note: Manhattan Case 7428226 is opened for this</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"bryce.meyer@rndc-usa.com, Michael.Ferdinand@Penske.com, abel.paucardelacruz@rndc-usa.com, Sara.Farrington@Penske.com, Matthew.Chavez@Penske.com,Jesse.Butler@Penske.com, Brian.Bontemps@penske.com","ccEmail":"wmsinternal@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM, DL_MANH_RNDC_MAWM_PSO@manh.com, DL_RNDC_MAWM_CSO@manh.com","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.shp_shipment S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
-- where warehouseid=(select wl.warehouseid
-- 					from app.warehouselocationdetail wld, app.warehouselocation wl
-- 					where wld.description = 'db-alert-order-no-desig-assign'
-- 					AND wld.warehouseid = wl.warehouseid
-- 					AND wl.warehouseshortname in ('POR')); 


-- -- (SAA)
-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.<br /><br />***MSP TO CLEAN UP***<br />The helpdesk should be called to rectify the problem as soon as possible.  If the helpdesk is not called, then there is a chance that the orders will not make the truck.  It is also imperative to call immediately and hold processing in sortation vendor (Shiraz/IndaGO/Dematic/CSD) in order to make sure you plan the original route number and new route numbers back-to-back as it makes it easier to load the truck.  866-RNDC-HLP (866-763-2457) Note: Manhattan Case 7428226 is opened for this</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"Travis.Eldridge@rndc-usa.com,Alex.Rios@rndc-usa.com,joseph.duran@rndc-usa.com,travis.gusler@rndc-usa.com,christopher.gonzales@rndc-usa.com,Larry.Shelton@RNDC-USA.COM,Octavio.Chavez@RNDC-USA.COM, ameron.phipps@rndc-usa.com, andre.dockery@rndc-usa.com, amanda.santos@rndc-usa.com, Armando.Granados@RNDC-USA.COM","ccEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.shp_shipment S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
-- where warehouseid=(select wl.warehouseid
-- 					from app.warehouselocationdetail wld, app.warehouselocation wl
-- 					where wld.description = 'db-alert-order-no-desig-assign'
-- 					AND wld.warehouseid = wl.warehouseid
-- 					AND wl.warehouseshortname in ('SAA')); 



-- Unnamed queries (all other org ids)
-- update app.warehouselocationdetail 
-- set payload = '{"alertName":"STANDARD ORDERS W/ NO DESIGNATED OR ASSIGNED SHIPMENTS CREATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $alertName$","body":"<pre>The alert condition for ''$name$'' was triggered.</pre>","fromEmail":"wms-tools-noreply@rndc-usa.com","toEmail":"wmsinternal@RNDC-USA.COM, WMSadmin@RNDC-USA.COM, WMSMSPSupport@RNDC-USA.COM","ccEmail":"","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT DISTINCT O.org_id, O.original_order_id, O.order_type, Concat(O.maximum_status, ''-'', MAX_STAT.description) ''MAX_STATUS'', Concat(O.minimum_status, ''-'', MIN_STAT.description) ''MIN_STATUS'', O.designated_shipment_id ''SHIPMENT'', O.created_timestamp, OLI.assigned_shipment_id FROM default_dcorder.dco_original_order O LEFT JOIN default_dcorder.dco_order_status MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.dco_order_status MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.dco_order_line OLI ON O.original_order_id = OLI.original_order_id AND O.org_id = OLI.org_id WHERE 1 = 1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''7800'' AND OLI.status NOT IN ( ''CANCELLED'' ) AND O.created_timestamp <= Now() - INTERVAL 15 minute AND ( O.designated_shipment_id NOT IN (SELECT DISTINCT shipment_id FROM default_shipment.shp_shipment S WHERE S.org_id = O.org_id) OR OLI.assigned_shipment_id IS NULL );"}'
-- where warehouseid in (select wl.warehouseid
-- 					from app.warehouselocationdetail wld, app.warehouselocation wl
-- 					where wld.description = 'db-alert-order-no-desig-assign'
-- 					AND wld.warehouseid = wl.warehouseid
-- 					AND wl.warehouseshortname not in ('SIO, ASH, DEN, POR, SAA'));