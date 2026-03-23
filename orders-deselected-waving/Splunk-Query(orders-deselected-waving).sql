-- Splunk query
 | dbxquery query="SELECT DE.org_id,
       DE.order_id,
       O.ext_route_id,
       DE.order_planning_run_id,
       DE.deselected_orders,
       DE.deselected_order_lines,
       DE.updated_by,
       DE.created_timestamp
FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE
       join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA
         ON DE.order_planning_run_id = PLA.order_planning_run_id
            AND PLA.org_id = DE.org_id
       left join default_dcorder.DCO_ORDER O
              ON O.order_id = DE.order_id
                 AND O.org_id = DE.org_id
WHERE  1 = 1
       AND DE.created_timestamp >= Now() - interval 15 minute
       AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%'
       AND DE.deselected_order_lines > '0'
       AND DE.org_id = 'OAH'" 
connection="MAPRD_NEW"


-- *****Remember there is 1 more different group of enabled Splunk queries of queries!!!!
-- Converting to SQL query with aliases (no aliases this time)
SELECT DE.org_id,
       DE.order_id,
       O.ext_route_id,
       DE.order_planning_run_id,
       DE.deselected_orders,
       DE.deselected_order_lines,
       DE.updated_by,
       DE.created_timestamp
FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE
       join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA
         ON DE.order_planning_run_id = PLA.order_planning_run_id
            AND PLA.org_id = DE.org_id
       left join default_dcorder.DCO_ORDER O
              ON O.order_id = DE.order_id
                 AND O.org_id = DE.org_id
WHERE  1 = 1
       AND DE.created_timestamp >= Now() - interval 15 minute
       AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%'
       AND DE.deselected_order_lines > '0'
       AND DE.org_id = 'OAH';


-- Converting to SQL query without aliases (no aliases this time) and replacing variables if any
SELECT DE.org_id,
       DE.order_id,
       O.ext_route_id,
       DE.order_planning_run_id,
       DE.deselected_orders,
       DE.deselected_order_lines,
       DE.updated_by,
       DE.created_timestamp
FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE
       join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA
         ON DE.order_planning_run_id = PLA.order_planning_run_id
            AND PLA.org_id = DE.org_id
       left join default_dcorder.DCO_ORDER O
              ON O.order_id = DE.order_id
                 AND O.org_id = DE.org_id
WHERE  1 = 1
       AND DE.created_timestamp >= Now() - interval 15 minute
       AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%'
       AND DE.deselected_order_lines > '0'
       AND DE.org_id = $orgId;


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%' AND DE.deselected_order_lines > '0' AND DE.org_id = $orgId;"
 
 insert into table (V)
 set payload = "SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%' AND DE.deselected_order_lines > '0' AND DE.org_id = $orgId;"

-- BELOW: FOR 2ND GROUP OF QUERIES (PEN WHICH IS SIGNIFICANTLY DIFFERENT)
-- *****Remember there is 1 more different group of enabled Splunk queries of queries!!!!
-- Converting to SQL query with aliases (no aliases this time)

-- Splunk query
 | dbxquery query="SELECT DE.org_id,
       DE.order_id,
       O.ext_route_id,
       DE.order_planning_run_id,
       DE.deselected_orders,
       DE.deselected_order_lines,
       DE.updated_by,
       DE.created_timestamp
FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE
       join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA
         ON DE.order_planning_run_id = PLA.order_planning_run_id
            AND PLA.org_id = DE.org_id
       left join default_dcorder.DCO_ORDER O
              ON O.order_id = DE.order_id
                 AND O.org_id = DE.org_id
WHERE  1 = 1
       AND DE.created_timestamp >= Now() - interval 15 minute
       AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%'
       AND DE.deselected_order_lines > '0'
       AND DE.org_id = 'OAH'" 
connection="MAPRD_NEW"


-- *****Remember there are 2 more different groups of enabled Splunk queries of queries!!!!
-- Converting to SQL query with aliases (no aliases this time)
SELECT DE.org_id,
       DE.order_id,
       O.ext_route_id,
       DE.order_planning_run_id,
       DE.deselected_orders,
       DE.deselected_order_lines,
       DE.updated_by,
       DE.created_timestamp
FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE
       join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA
         ON DE.order_planning_run_id = PLA.order_planning_run_id
            AND PLA.org_id = DE.org_id
       left join default_dcorder.DCO_ORDER O
              ON O.order_id = DE.order_id
                 AND O.org_id = DE.org_id
WHERE  1 = 1
       AND DE.created_timestamp >= Now() - interval 15 minute
       AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%'
       AND DE.deselected_order_lines > '0'
       AND DE.org_id = 'OAH';


-- Converting to SQL query without aliases (no aliases this time) and replacing variables if any
SELECT DE.org_id,
       DE.order_id,
       O.ext_route_id,
       DE.order_planning_run_id,
       DE.deselected_orders,
       DE.deselected_order_lines,
       DE.updated_by,
       DE.created_timestamp
FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE
       join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA
         ON DE.order_planning_run_id = PLA.order_planning_run_id
            AND PLA.org_id = DE.org_id
       left join default_dcorder.DCO_ORDER O
              ON O.order_id = DE.order_id
                 AND O.org_id = DE.org_id
WHERE  1 = 1
       AND DE.created_timestamp >= Now() - interval 15 minute
       AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%'
       AND DE.deselected_order_lines > '0'
       AND DE.org_id = $orgId;


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
"SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%' AND DE.deselected_order_lines > '0' AND DE.org_id = $orgId;"
 
 insert into table (V)
 set payload = "SELECT DE.org_id, DE.order_id, O.ext_route_id, DE.order_planning_run_id, DE.deselected_orders, DE.deselected_order_lines, DE.updated_by, DE.created_timestamp FROM   default_dcorder.DCO_PLAN_RUN_DESELECT_COUNT DE join default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON DE.order_planning_run_id = PLA.order_planning_run_id AND PLA.org_id = DE.org_id left join default_dcorder.DCO_ORDER O ON O.order_id = DE.order_id AND O.org_id = DE.org_id WHERE  1 = 1 AND DE.created_timestamp >= Now() - interval 15 minute AND Upper(PLA.planning_strategy_id) LIKE 'STANDARD%%' AND DE.deselected_order_lines > '0' AND DE.org_id = $orgId;"




 
