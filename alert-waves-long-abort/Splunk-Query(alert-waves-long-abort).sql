-- Splunk query
| dbxquery query="select P.ORG_id, P.ORDER_PLANNING_RUN_ID, P.PLANNING_STRATEGY_ID, P.DESCRIPTION, P.STATUS, P.PIPELINE_ID,  P.CREATED_TIMESTAMP, P.CREATED_BY, 
 P.SELECTED_ORDERS, P.SELECTED_ORDER_LINES, P.SELECTED_UNITS, P.DESELECTED_ORDER_LINES, P.REPLENISHMENT_CREATED 
 from (
 select DOP.ORG_id, DOP.ORDER_PLANNING_RUN_ID,DOP.PLANNING_STRATEGY_ID, STATUS.DESCRIPTION, DOP.STATUS, DOP.PIPELINE_ID,  DOP.CREATED_TIMESTAMP, DOP.CREATED_BY, 
 DOP.SELECTED_ORDERS, DOP.SELECTED_ORDER_LINES, DOP.SELECTED_UNITS, DOP.DESELECTED_ORDER_LINES, DOP.REPLENISHMENT_CREATED
 from  default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP join default_dcorder.DCO_PLANNING_RUN_STATUS STATUS on DOP.STATUS = STATUS.PLANNING_RUN_STATUS_ID
 WHERE DOP.STATUS < 500 
  AND DOP.ORG_ID = 'ARK' AND DOP.CREATED_TIMESTAMP < DATE_SUB(now(), INTERVAL '15' MINUTE)
 UNION
 select DOP.ORG_id, DOP.ORDER_PLANNING_RUN_ID,DOP.PLANNING_STRATEGY_ID, STATUS.DESCRIPTION, DOP.STATUS, DOP.PIPELINE_ID,  DOP.CREATED_TIMESTAMP, DOP.CREATED_BY, 
 DOP.SELECTED_ORDERS, DOP.SELECTED_ORDER_LINES, DOP.SELECTED_UNITS, DOP.DESELECTED_ORDER_LINES, DOP.REPLENISHMENT_CREATED
 from  default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP join default_dcorder.DCO_PLANNING_RUN_STATUS STATUS on DOP.STATUS = STATUS.PLANNING_RUN_STATUS_ID
 WHERE DOP.STATUS = 400 
  AND DOP.ORG_ID = 'ARK' AND DOP.UPDATED_TIMESTAMP <= DATE_SUB(now(), INTERVAL '5' MINUTE))P
 ORDER BY P.CREATED_TIMESTAMP DESC" connection="MAPRD_NEW"

-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
-- ***Remember if property name is to be surrounded by single quotes, please use concat() instead as  cursor.execute() in getAlertData in wms-api
-- ***Remember to add query alias to all sub-queries if not complete (see item-rcpt-zero, where a "c" alias was added at the end which doesn't exist in splunk.)
-- ***Remember to escape double quotes is a json object is found within payload/sql query with double quotes surrounding keys!! (see script 57_Warehouse_Detail_DBalert_MissingItemLevelVerification.sql in wms-api)
  SELECT P.org_id,
       P.order_planning_run_id,
       P.planning_strategy_id,
       P.description,
       P.status,
       P.pipeline_id,
       P.created_timestamp,
       P.created_by,
       P.selected_orders,
       P.selected_order_lines,
       P.selected_units,
       P.deselected_order_lines,
       P.replenishment_created
FROM   (SELECT DOP.org_id,
               DOP.order_planning_run_id,
               DOP.planning_strategy_id,
               STATUS.description,
               DOP.status,
               DOP.pipeline_id,
               DOP.created_timestamp,
               DOP.created_by,
               DOP.selected_orders,
               DOP.selected_order_lines,
               DOP.selected_units,
               DOP.deselected_order_lines,
               DOP.replenishment_created
        FROM   default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP
               JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS
                 ON DOP.status = STATUS.planning_run_status_id
        WHERE  DOP.status < 500
               AND DOP.org_id = $orgId
               AND DOP.created_timestamp < Date_sub(Now(), INTERVAL '15' minute)
        UNION
        SELECT DOP.org_id,
               DOP.order_planning_run_id,
               DOP.planning_strategy_id,
               STATUS.description,
               DOP.status,
               DOP.pipeline_id,
               DOP.created_timestamp,
               DOP.created_by,
               DOP.selected_orders,
               DOP.selected_order_lines,
               DOP.selected_units,
               DOP.deselected_order_lines,
               DOP.replenishment_created
        FROM   default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP
               JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS
                 ON DOP.status = STATUS.planning_run_status_id
        WHERE  DOP.status = 400
               AND DOP.org_id = $orgId
               AND DOP.updated_timestamp <= Date_sub(Now(), INTERVAL '5' minute)
       ) P
ORDER  BY P.created_timestamp DESC;  


-- Flattening SQL query to single line (paste and copy from chrome search bar)
 SELECT P.org_id,        P.order_planning_run_id,        P.planning_strategy_id,        P.description,        P.status,        P.pipeline_id,        P.created_timestamp,        P.created_by,        P.selected_orders,        P.selected_order_lines,        P.selected_units,        P.deselected_order_lines,        P.replenishment_created FROM   (SELECT DOP.org_id,                DOP.order_planning_run_id,                DOP.planning_strategy_id,                STATUS.description,                DOP.status,                DOP.pipeline_id,                DOP.created_timestamp,                DOP.created_by,                DOP.selected_orders,                DOP.selected_order_lines,                DOP.selected_units,                DOP.deselected_order_lines,                DOP.replenishment_created         FROM   default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP                JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS                  ON DOP.status = STATUS.planning_run_status_id         WHERE  DOP.status < 500                AND DOP.org_id = $orgId                AND DOP.created_timestamp < Date_sub(Now(), INTERVAL '15' minute)         UNION         SELECT DOP.org_id,                DOP.order_planning_run_id,                DOP.planning_strategy_id,                STATUS.description,                DOP.status,                DOP.pipeline_id,                DOP.created_timestamp,                DOP.created_by,                DOP.selected_orders,                DOP.selected_order_lines,                DOP.selected_units,                DOP.deselected_order_lines,                DOP.replenishment_created         FROM   default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP                JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS                  ON DOP.status = STATUS.planning_run_status_id         WHERE  DOP.status = 400                AND DOP.org_id = $orgId                AND DOP.updated_timestamp <= Date_sub(Now(), INTERVAL '5' minute)        ) P ORDER  BY P.created_timestamp DESC;

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
 SELECT P.org_id, P.order_planning_run_id, P.planning_strategy_id, P.description, P.status, P.pipeline_id, P.created_timestamp, P.created_by, P.selected_orders, P.selected_order_lines, P.selected_units, P.deselected_order_lines, P.replenishment_created FROM (SELECT DOP.org_id, DOP.order_planning_run_id, DOP.planning_strategy_id, STATUS.description, DOP.status, DOP.pipeline_id, DOP.created_timestamp, DOP.created_by, DOP.selected_orders, DOP.selected_order_lines, DOP.selected_units, DOP.deselected_order_lines, DOP.replenishment_created FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS ON DOP.status = STATUS.planning_run_status_id WHERE DOP.status < 500 AND DOP.org_id = $orgId AND DOP.created_timestamp < Date_sub(Now(), INTERVAL '15' minute) UNION SELECT DOP.org_id, DOP.order_planning_run_id, DOP.planning_strategy_id, STATUS.description, DOP.status, DOP.pipeline_id, DOP.created_timestamp, DOP.created_by, DOP.selected_orders, DOP.selected_order_lines, DOP.selected_units, DOP.deselected_order_lines, DOP.replenishment_created FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS ON DOP.status = STATUS.planning_run_status_id WHERE DOP.status = 400 AND DOP.org_id = $orgId AND DOP.updated_timestamp <= Date_sub(Now(), INTERVAL '5' minute) ) P ORDER BY P.created_timestamp DESC;

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
 SELECT P.org_id, P.order_planning_run_id, P.planning_strategy_id, P.description, P.status, P.pipeline_id, P.created_timestamp, P.created_by, P.selected_orders, P.selected_order_lines, P.selected_units, P.deselected_order_lines, P.replenishment_created FROM (SELECT DOP.org_id, DOP.order_planning_run_id, DOP.planning_strategy_id, STATUS.description, DOP.status, DOP.pipeline_id, DOP.created_timestamp, DOP.created_by, DOP.selected_orders, DOP.selected_order_lines, DOP.selected_units, DOP.deselected_order_lines, DOP.replenishment_created FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS ON DOP.status = STATUS.planning_run_status_id WHERE DOP.status < 500 AND DOP.org_id = $orgId AND DOP.created_timestamp < Date_sub(Now(), INTERVAL ''15'' minute) UNION SELECT DOP.org_id, DOP.order_planning_run_id, DOP.planning_strategy_id, STATUS.description, DOP.status, DOP.pipeline_id, DOP.created_timestamp, DOP.created_by, DOP.selected_orders, DOP.selected_order_lines, DOP.selected_units, DOP.deselected_order_lines, DOP.replenishment_created FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS ON DOP.status = STATUS.planning_run_status_id WHERE DOP.status = 400 AND DOP.org_id = $orgId AND DOP.updated_timestamp <= Date_sub(Now(), INTERVAL ''5'' minute) ) P ORDER BY P.created_timestamp DESC;


-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
SELECT P.org_id, P.order_planning_run_id, P.planning_strategy_id, P.description, P.status, P.pipeline_id, P.created_timestamp, P.created_by, P.selected_orders, P.selected_order_lines, P.selected_units, P.deselected_order_lines, P.replenishment_created FROM (SELECT DOP.org_id, DOP.order_planning_run_id, DOP.planning_strategy_id, STATUS.description, DOP.status, DOP.pipeline_id, DOP.created_timestamp, DOP.created_by, DOP.selected_orders, DOP.selected_order_lines, DOP.selected_units, DOP.deselected_order_lines, DOP.replenishment_created FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS ON DOP.status = STATUS.planning_run_status_id WHERE DOP.status < 500 AND DOP.org_id = $orgId AND DOP.created_timestamp < Date_sub(Now(), INTERVAL ''15'' minute) UNION SELECT DOP.org_id, DOP.order_planning_run_id, DOP.planning_strategy_id, STATUS.description, DOP.status, DOP.pipeline_id, DOP.created_timestamp, DOP.created_by, DOP.selected_orders, DOP.selected_order_lines, DOP.selected_units, DOP.deselected_order_lines, DOP.replenishment_created FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY DOP JOIN default_dcorder.DCO_PLANNING_RUN_STATUS STATUS ON DOP.status = STATUS.planning_run_status_id WHERE DOP.status = 400 AND DOP.org_id = $orgId AND DOP.updated_timestamp <= Date_sub(Now(), INTERVAL ''5'' minute) ) P ORDER BY P.created_timestamp DESC;

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

