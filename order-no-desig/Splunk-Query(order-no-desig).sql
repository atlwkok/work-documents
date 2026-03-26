-- Splunk query
| dbxquery query="SELECT O.ORG_ID, O.ORIGINAL_ORDER_ID AS \"ORDER\", O.ORDER_TYPE
 ,CONCAT(O.MAXIMUM_STATUS,'-',MAX_STAT.DESCRIPTION) MAX_STATUS
 ,CONCAT(O.MINIMUM_STATUS,'-',MIN_STAT.DESCRIPTION) MIN_STATUS
 , O.DESIGNATED_SHIPMENT_ID SHIPMENT, O.CREATED_TIMESTAMP
 FROM default_dcorder.DCO_ORIGINAL_ORDER O
 LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.ORDER_STATUS_ID = O.MAXIMUM_STATUS
 LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.ORDER_STATUS_ID = O.MAXIMUM_STATUS
 WHERE 1=1
 AND O.ORG_ID = 'IND'
 AND O.ORDER_TYPE = 'Standard'
 AND O.MINIMUM_STATUS < '8000'
 AND O.CREATED_TIMESTAMP <= NOW() - INTERVAL 15 MINUTE
 AND O.DESIGNATED_SHIPMENT_ID NOT IN (SELECT DISTINCT SHIPMENT_ID FROM default_shipment.SHP_SHIPMENT S WHERE S.ORG_ID = O.ORG_ID)" connection="MAPRD_NEW"


"

-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
SELECT    O.org_id,
          O.original_order_id AS 'ORDER',
          O.order_type ,
          Concat(O.maximum_status,'-',MAX_STAT.description) 'MAX_STATUS' ,
          Concat(O.minimum_status,'-',MIN_STAT.description) 'MIN_STATUS' ,
          O.designated_shipment_id 'SHIPMENT',
          O.created_timestamp
FROM      default_dcorder.DCO_ORIGINAL_ORDER O
LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT
ON        MAX_STAT.order_status_id = O.maximum_status
LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT
ON        MIN_STAT.order_status_id = O.maximum_status
WHERE     1=1
AND       O.org_id = $orgId
AND       O.order_type = 'Standard'
AND       O.minimum_status < '8000'
AND       O.created_timestamp <= Now()  - INTERVAL 15 minute
AND       O.designated_shipment_id NOT IN
                                           (
                                           SELECT DISTINCT shipment_id
                                           FROM            default_shipment.SHP_SHIPMENT S
                                           WHERE           S.org_id = O.org_id);


-- Flattening SQL query to single line (paste and copy from chrome search bar)
 SELECT    O.org_id, O.original_order_id AS 'ORDER', O.order_type , Concat(O.maximum_status,'-',MAX_STAT.description) 'MAX_STATUS' , Concat(O.minimum_status,'-',MIN_STAT.description) 'MIN_STATUS' , O.designated_shipment_id 'SHIPMENT', O.created_timestamp FROM      default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON        MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON        MIN_STAT.order_status_id = O.maximum_status WHERE     1=1 AND       O.org_id = $orgId AND       O.order_type = 'Standard' AND       O.minimum_status < '8000' AND       O.created_timestamp <= Now()  - INTERVAL 15 minute AND       O.designated_shipment_id NOT IN ( SELECT DISTINCT shipment_id FROM            default_shipment.SHP_SHIPMENT S WHERE           S.org_id = O.org_id);

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
 SELECT O.org_id, O.original_order_id AS 'ORDER', O.order_type , Concat(O.maximum_status,'-',MAX_STAT.description) 'MAX_STATUS' , Concat(O.minimum_status,'-',MIN_STAT.description) 'MIN_STATUS' , O.designated_shipment_id 'SHIPMENT', O.created_timestamp FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status WHERE 1=1 AND O.org_id = $orgId AND O.order_type = 'Standard' AND O.minimum_status < '8000' AND O.created_timestamp <= Now() - INTERVAL 15 minute AND O.designated_shipment_id NOT IN ( SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id);

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
 SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type , Concat(O.maximum_status,''-'',MAX_STAT.description) ''MAX_STATUS'' , Concat(O.minimum_status,''-'',MIN_STAT.description) ''MIN_STATUS'' , O.designated_shipment_id ''SHIPMENT'', O.created_timestamp FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status WHERE 1=1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''8000'' AND O.created_timestamp <= Now() - INTERVAL 15 minute AND O.designated_shipment_id NOT IN ( SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id);


-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
 SELECT O.org_id, O.original_order_id AS ''ORDER'', O.order_type , Concat(O.maximum_status,''-'',MAX_STAT.description) ''MAX_STATUS'' , Concat(O.minimum_status,''-'',MIN_STAT.description) ''MIN_STATUS'' , O.designated_shipment_id ''SHIPMENT'', O.created_timestamp FROM default_dcorder.DCO_ORIGINAL_ORDER O LEFT JOIN default_dcorder.DCO_ORDER_STATUS MAX_STAT ON MAX_STAT.order_status_id = O.maximum_status LEFT JOIN default_dcorder.DCO_ORDER_STATUS MIN_STAT ON MIN_STAT.order_status_id = O.maximum_status WHERE 1=1 AND O.org_id = $orgId AND O.order_type = ''Standard'' AND O.minimum_status < ''8000'' AND O.created_timestamp <= Now() - INTERVAL 15 minute AND O.designated_shipment_id NOT IN ( SELECT DISTINCT shipment_id FROM default_shipment.SHP_SHIPMENT S WHERE S.org_id = O.org_id);

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

