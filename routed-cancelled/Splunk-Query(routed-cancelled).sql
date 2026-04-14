-- Splunk query
| dbxquery query="SELECT O.ORG_ID, O.ORIGINAL_ORDER_ID AS \"ORDER\",O.ORDER_TYPE, O.BILLING_ACCOUNT_NUMBER, O.BILL_TO_NAME AS CUSTOMER
 , CONCAT(O.MAXIMUM_STATUS,'-',DS.DESCRIPTION) ORDER_STATUS, OLI.ORIGINAL_ORDER_PLANNING_RUN_ID
 , OLI.ITEM_ID SKU, OLI.DESCRIPTION SKU_DESCRIPTION
 , O.UPDATED_TIMESTAMP, O.UPDATED_BY
 FROM default_dcorder.DCO_ORIGINAL_ORDER O
 LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.ORDER_STATUS_ID = O.MAXIMUM_STATUS
 LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.ORIGINAL_ORDER_ID = O.ORIGINAL_ORDER_ID AND O.ORG_ID = OLI.ORG_ID
 WHERE 1=1
 AND O.ORG_ID = 'PEN'
 AND UPPER(O.ORDER_TYPE) = 'STANDARD'
 AND O.MAXIMUM_STATUS = '9000'
 AND O.UPDATED_TIMESTAMP >= NOW() - INTERVAL 1 DAY;" connection="MAPRD_NEW"
"
-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
-- ***Remember if property name is to be surrounded by single quotes, please use concat() instead as  cursor.execute() in getAlertData in wms-api
-- ***Remember to add query alias to all sub-queries if not complete (see item-rcpt-zero, where a "c" alias was added at the end which doesn't exist in splunk.)
-- ***Remember to escape double quotes is a json object is found within payload/sql query with double quotes surrounding keys!! (see script 57_Warehouse_Detail_DBalert_MissingItemLevelVerification.sql in wms-api)
  SELECT    O.org_id,
          O.original_order_id AS 'ORDER',
          O.order_type,
          O.billing_account_number,
          O.bill_to_name AS 'CUSTOMER' ,
          Concat(O.maximum_status,'-',DS.description) 'ORDER_STATUS',
          OLI.original_order_planning_run_id ,
          OLI.item_id     'SKU',
          OLI.description 'SKU_DESCRIPTION' ,
          O.updated_timestamp,
          O.updated_by
FROM      default_dcorder.DCO_ORIGINAL_ORDER O
LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS
ON        DS.order_status_id = O.maximum_status
LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI
ON        OLI.original_order_id = O.original_order_id
AND       O.org_id = OLI.org_id
WHERE     1=1
AND       O.org_id = $orgId
AND       Upper(O.order_type) = 'STANDARD'
AND       O.maximum_status = '9000'
AND       O.updated_timestamp >= Now() - INTERVAL 1 day;  


-- Flattening SQL query to single line (paste and copy from chrome search bar)
SELECT    O.org_id,           O.original_order_id AS 'ORDER',           O.order_type,           O.billing_account_number,           O.bill_to_name AS 'CUSTOMER' ,           Concat(O.maximum_status,'-',DS.description) 'ORDER_STATUS',           OLI.original_order_planning_run_id ,           OLI.item_id     'SKU',           OLI.description 'SKU_DESCRIPTION' ,           O.updated_timestamp,           O.updated_by FROM      default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON        DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON        OLI.original_order_id = O.original_order_id AND       O.org_id = OLI.org_id WHERE     1=1 AND       O.org_id = $orgId AND       Upper(O.order_type) = 'STANDARD' AND       O.maximum_status = '9000' AND       O.updated_timestamp >= Now() - INTERVAL 1 day;

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT O.org_id, O.original_order_id AS 'ORDER', O.order_type, O.billing_account_number, O.bill_to_name AS 'CUSTOMER' , Concat(O.maximum_status,'-',DS.description) 'ORDER_STATUS', OLI.original_order_planning_run_id , OLI.item_id 'SKU', OLI.description 'SKU_DESCRIPTION' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = 'STANDARD' AND O.maximum_status = '9000' AND O.updated_timestamp >= Now() - INTERVAL 1 day;

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type, O.billing_account_number, O.bill_to_name AS ''CUSTOMER'' , Concat(O.maximum_status,''-'',DS.description) ''ORDER_STATUS'', OLI.original_order_planning_run_id , OLI.item_id ''SKU'', OLI.description ''SKU_DESCRIPTION'' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = ''STANDARD'' AND O.maximum_status = ''9000'' AND O.updated_timestamp >= Now() - INTERVAL 1 day;

-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type, O.billing_account_number, O.bill_to_name AS ''CUSTOMER'' , Concat(O.maximum_status,''-'',DS.description) ''ORDER_STATUS'', OLI.original_order_planning_run_id , OLI.item_id ''SKU'', OLI.description ''SKU_DESCRIPTION'' , O.updated_timestamp, O.updated_by FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS DS ON DS.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_LINE OLI ON OLI.original_order_id = O.original_order_id AND O.org_id = OLI.org_id WHERE 1=1 AND O.org_id = $orgId AND Upper(O.order_type) = ''STANDARD'' AND O.maximum_status = ''9000'' AND O.updated_timestamp >= Now() - INTERVAL 1 day;

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

