-- Splunk query - DB Alert: MAWM - Olpns W/ Multiple Details Of The Same Item
| dbxquery query="SELECT 
 ORG_ID, 
 OLPN_ID, 
 STATUS, 
 ORDER_PLANNING_RUN_ID, 
 ITEM_ID, 
 COUNT(DISTINCT OLPN_DETAIL_ID) LPN_DTL_COUNT 
 FROM 
 (
 SELECT 
 OLPN.ORG_ID, 
 OLPN.PICK_LOCATION_ID, 
 LOC.STORAGE_UOM_ID, 
 LOC.TASK_MOVEMENT_ZONE_ID, 
 LOC.PICK_ALLOCATION_ZONE_ID, 
 OLPN.LPN_TYPE, 
 OLPN.OLPN_ID, 
 OLPN.TOTAL_LPN_QTY, 
 OLPN.OLPN_CREATION_CODE_ID, 
 CONCAT(
 OLPN.STATUS, '-', STAT.DESCRIPTION
 ) STATUS, 
 OLPN.ORDER_PLANNING_RUN_ID, 
 OLPN.ORDER_TYPE, 
 SHIPMENT_ID, 
 STOP_ID, 
 OD.PICKED_QUANTITY, 
 OD.INITIAL_QUANTITY, 
 OD.ORIGINAL_ORDER_LINE_ID, 
 OD.ITEM_ID, 
 OD.OLPN_DETAIL_ID 
 FROM 
 default_pickpack.PPK_OLPN OLPN 
 LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = OLPN.STATUS 
 LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = PICK_LOCATION_ID 
 AND OLPN.ORG_ID = SUBSTR(LOC.PROFILE_ID, 1, 3) 
 LEFT JOIN default_pickpack.PPK_OLPN_DETAIL OD ON OD.OLPN_PK = OLPN.PK 
 AND OD.ORG_ID = OLPN.ORG_ID 
 AND OD.STATUS <> '9000'
 WHERE 
 1 = 1 
 AND OLPN.CREATED_TIMESTAMP >= NOW() - INTERVAL 6 HOUR 
 AND OLPN.ORDER_PLANNING_RUN_ID IN (
 SELECT 
 ORDER_PLANNING_RUN_ID 
 FROM 
 default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY OPS 
 WHERE 
 UPPER(DESCRIPTION) LIKE 'STANDARD%' 
 AND OPS.ORG_ID = OLPN.ORG_ID
 )
 ) A 
 GROUP BY 
 ORG_ID, 
 OLPN_ID, 
 STATUS, 
 ORDER_PLANNING_RUN_ID, 
 ITEM_ID 
 HAVING 
 COUNT(DISTINCT OLPN_DETAIL_ID) > 1" connection="MAPRD_NEW"

-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
-- ***Remember if property name is to be surrounded by single quotes, please use concat() instead as  cursor.execute() in getAlertData in wms-api 
-- will replace it with another duplicate set of  unnecessary single quotes 
-- ***Remember to add query alias to all sub-queries if not complete (see item-rcpt-zero, where a "c" alias was added at the end which doesn't exist in splunk.)
-- ***Remember to escape double quotes is a json object is found within mail body payload/sql query with double quotes surrounding keys!! (see script 57_Warehouse_Detail_DBalert_MissingItemLevelVerification.sql in wms-api)
-- Correct ’ in email payload body and replace it with ''
-- Remember to test in MySQL Workbench before proceeding!!!
SELECT 
        ORG_ID, 
        OLPN_ID, 
        STATUS, 
        ORDER_PLANNING_RUN_ID, 
        ITEM_ID, 
        COUNT(DISTINCT OLPN_DETAIL_ID) 'LPN_DTL_COUNT' 
FROM (
        SELECT 
                OLPN.ORG_ID, 
                OLPN.PICK_LOCATION_ID, 
                LOC.STORAGE_UOM_ID, 
                LOC.TASK_MOVEMENT_ZONE_ID, 
                LOC.PICK_ALLOCATION_ZONE_ID, 
                OLPN.LPN_TYPE, 
                OLPN.OLPN_ID, 
                OLPN.TOTAL_LPN_QTY, 
                OLPN.OLPN_CREATION_CODE_ID, 
                CONCAT(OLPN.STATUS, '-', STAT.DESCRIPTION) 'STATUS', 
                OLPN.ORDER_PLANNING_RUN_ID, 
                OLPN.ORDER_TYPE, 
                SHIPMENT_ID, 
                STOP_ID, 
                OD.PICKED_QUANTITY, 
                OD.INITIAL_QUANTITY, 
                OD.ORIGINAL_ORDER_LINE_ID, 
                OD.ITEM_ID, 
                OD.OLPN_DETAIL_ID 
        FROM default_pickpack.PPK_OLPN OLPN 
                LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT 
                        ON STAT.OLPN_STATUS_ID = OLPN.STATUS 
                LEFT JOIN default_dcinventory.DCI_LOCATION LOC 
                        ON LOC.LOCATION_ID = PICK_LOCATION_ID 
                        AND OLPN.ORG_ID = SUBSTR(LOC.PROFILE_ID, 1, 3) 
                LEFT JOIN default_pickpack.PPK_OLPN_DETAIL OD 
                        ON OD.OLPN_PK = OLPN.PK 
                        AND OD.ORG_ID = OLPN.ORG_ID 
                        AND OD.STATUS <> '9000'
        WHERE 1 = 1 
                AND OLPN.CREATED_TIMESTAMP >= NOW() - INTERVAL 6 HOUR 
                AND OLPN.ORDER_PLANNING_RUN_ID IN (SELECT ORDER_PLANNING_RUN_ID 
                                                        FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY OPS 
                                                        WHERE UPPER(DESCRIPTION) LIKE 'STANDARD%%' 
                                                                AND OPS.ORG_ID = OLPN.ORG_ID)
        ) A 
GROUP BY 
        ORG_ID, 
        OLPN_ID, 
        STATUS, 
        ORDER_PLANNING_RUN_ID, 
        ITEM_ID 
HAVING 
        COUNT(DISTINCT OLPN_DETAIL_ID) > 1;


-- Flattening SQL query to single line (paste and copy from chrome search bar)
SELECT          ORG_ID,          OLPN_ID,          STATUS,          ORDER_PLANNING_RUN_ID,          ITEM_ID,          COUNT(DISTINCT OLPN_DETAIL_ID) 'LPN_DTL_COUNT'  FROM (         SELECT                  OLPN.ORG_ID,                  OLPN.PICK_LOCATION_ID,                  LOC.STORAGE_UOM_ID,                  LOC.TASK_MOVEMENT_ZONE_ID,                  LOC.PICK_ALLOCATION_ZONE_ID,                  OLPN.LPN_TYPE,                  OLPN.OLPN_ID,                  OLPN.TOTAL_LPN_QTY,                  OLPN.OLPN_CREATION_CODE_ID,                  CONCAT(OLPN.STATUS, '-', STAT.DESCRIPTION) 'STATUS',                  OLPN.ORDER_PLANNING_RUN_ID,                  OLPN.ORDER_TYPE,                  SHIPMENT_ID,                  STOP_ID,                  OD.PICKED_QUANTITY,                  OD.INITIAL_QUANTITY,                  OD.ORIGINAL_ORDER_LINE_ID,                  OD.ITEM_ID,                  OD.OLPN_DETAIL_ID          FROM default_pickpack.PPK_OLPN OLPN                  LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT                          ON STAT.OLPN_STATUS_ID = OLPN.STATUS                  LEFT JOIN default_dcinventory.DCI_LOCATION LOC                          ON LOC.LOCATION_ID = PICK_LOCATION_ID                          AND OLPN.ORG_ID = SUBSTR(LOC.PROFILE_ID, 1, 3)                  LEFT JOIN default_pickpack.PPK_OLPN_DETAIL OD                          ON OD.OLPN_PK = OLPN.PK                          AND OD.ORG_ID = OLPN.ORG_ID                          AND OD.STATUS <> '9000'         WHERE 1 = 1                  AND OLPN.CREATED_TIMESTAMP >= NOW() - INTERVAL 6 HOUR                  AND OLPN.ORDER_PLANNING_RUN_ID IN (SELECT ORDER_PLANNING_RUN_ID                                                          FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY OPS                                                          WHERE UPPER(DESCRIPTION) LIKE 'STANDARD%%'                                                                  AND OPS.ORG_ID = OLPN.ORG_ID)         ) A  GROUP BY          ORG_ID,          OLPN_ID,          STATUS,          ORDER_PLANNING_RUN_ID,          ITEM_ID  HAVING          COUNT(DISTINCT OLPN_DETAIL_ID) > 1;

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID, COUNT(DISTINCT OLPN_DETAIL_ID) 'LPN_DTL_COUNT' FROM ( SELECT OLPN.ORG_ID, OLPN.PICK_LOCATION_ID, LOC.STORAGE_UOM_ID, LOC.TASK_MOVEMENT_ZONE_ID, LOC.PICK_ALLOCATION_ZONE_ID, OLPN.LPN_TYPE, OLPN.OLPN_ID, OLPN.TOTAL_LPN_QTY, OLPN.OLPN_CREATION_CODE_ID, CONCAT(OLPN.STATUS, '-', STAT.DESCRIPTION) 'STATUS', OLPN.ORDER_PLANNING_RUN_ID, OLPN.ORDER_TYPE, SHIPMENT_ID, STOP_ID, OD.PICKED_QUANTITY, OD.INITIAL_QUANTITY, OD.ORIGINAL_ORDER_LINE_ID, OD.ITEM_ID, OD.OLPN_DETAIL_ID FROM default_pickpack.PPK_OLPN OLPN LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = OLPN.STATUS LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = PICK_LOCATION_ID AND OLPN.ORG_ID = SUBSTR(LOC.PROFILE_ID, 1, 3) LEFT JOIN default_pickpack.PPK_OLPN_DETAIL OD ON OD.OLPN_PK = OLPN.PK AND OD.ORG_ID = OLPN.ORG_ID AND OD.STATUS <> '9000' WHERE 1 = 1 AND OLPN.CREATED_TIMESTAMP >= NOW() - INTERVAL 6 HOUR AND OLPN.ORDER_PLANNING_RUN_ID IN (SELECT ORDER_PLANNING_RUN_ID FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY OPS WHERE UPPER(DESCRIPTION) LIKE 'STANDARD%%' AND OPS.ORG_ID = OLPN.ORG_ID) ) A GROUP BY ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID HAVING COUNT(DISTINCT OLPN_DETAIL_ID) > 1;

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID, COUNT(DISTINCT OLPN_DETAIL_ID) ''LPN_DTL_COUNT'' FROM ( SELECT OLPN.ORG_ID, OLPN.PICK_LOCATION_ID, LOC.STORAGE_UOM_ID, LOC.TASK_MOVEMENT_ZONE_ID, LOC.PICK_ALLOCATION_ZONE_ID, OLPN.LPN_TYPE, OLPN.OLPN_ID, OLPN.TOTAL_LPN_QTY, OLPN.OLPN_CREATION_CODE_ID, CONCAT(OLPN.STATUS, ''-'', STAT.DESCRIPTION) ''STATUS'', OLPN.ORDER_PLANNING_RUN_ID, OLPN.ORDER_TYPE, SHIPMENT_ID, STOP_ID, OD.PICKED_QUANTITY, OD.INITIAL_QUANTITY, OD.ORIGINAL_ORDER_LINE_ID, OD.ITEM_ID, OD.OLPN_DETAIL_ID FROM default_pickpack.PPK_OLPN OLPN LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = OLPN.STATUS LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = PICK_LOCATION_ID AND OLPN.ORG_ID = SUBSTR(LOC.PROFILE_ID, 1, 3) LEFT JOIN default_pickpack.PPK_OLPN_DETAIL OD ON OD.OLPN_PK = OLPN.PK AND OD.ORG_ID = OLPN.ORG_ID AND OD.STATUS <> ''9000'' WHERE 1 = 1 AND OLPN.CREATED_TIMESTAMP >= NOW() - INTERVAL 6 HOUR AND OLPN.ORDER_PLANNING_RUN_ID IN (SELECT ORDER_PLANNING_RUN_ID FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY OPS WHERE UPPER(DESCRIPTION) LIKE ''STANDARD%%'' AND OPS.ORG_ID = OLPN.ORG_ID) ) A GROUP BY ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID HAVING COUNT(DISTINCT OLPN_DETAIL_ID) > 1;

-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
SELECT ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID, COUNT(DISTINCT OLPN_DETAIL_ID) ''LPN_DTL_COUNT'' FROM ( SELECT OLPN.ORG_ID, OLPN.PICK_LOCATION_ID, LOC.STORAGE_UOM_ID, LOC.TASK_MOVEMENT_ZONE_ID, LOC.PICK_ALLOCATION_ZONE_ID, OLPN.LPN_TYPE, OLPN.OLPN_ID, OLPN.TOTAL_LPN_QTY, OLPN.OLPN_CREATION_CODE_ID, CONCAT(OLPN.STATUS, ''-'', STAT.DESCRIPTION) ''STATUS'', OLPN.ORDER_PLANNING_RUN_ID, OLPN.ORDER_TYPE, SHIPMENT_ID, STOP_ID, OD.PICKED_QUANTITY, OD.INITIAL_QUANTITY, OD.ORIGINAL_ORDER_LINE_ID, OD.ITEM_ID, OD.OLPN_DETAIL_ID FROM default_pickpack.PPK_OLPN OLPN LEFT JOIN default_pickpack.PPK_OLPN_STATUS STAT ON STAT.OLPN_STATUS_ID = OLPN.STATUS LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = PICK_LOCATION_ID AND OLPN.ORG_ID = SUBSTR(LOC.PROFILE_ID, 1, 3) LEFT JOIN default_pickpack.PPK_OLPN_DETAIL OD ON OD.OLPN_PK = OLPN.PK AND OD.ORG_ID = OLPN.ORG_ID AND OD.STATUS <> ''9000'' WHERE 1 = 1 AND OLPN.CREATED_TIMESTAMP >= NOW() - INTERVAL 6 HOUR AND OLPN.ORDER_PLANNING_RUN_ID IN (SELECT ORDER_PLANNING_RUN_ID FROM default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY OPS WHERE UPPER(DESCRIPTION) LIKE ''STANDARD%%'' AND OPS.ORG_ID = OLPN.ORG_ID) ) A GROUP BY ORG_ID, OLPN_ID, STATUS, ORDER_PLANNING_RUN_ID, ITEM_ID HAVING COUNT(DISTINCT OLPN_DETAIL_ID) > 1;

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

