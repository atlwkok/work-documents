-- Splunk query
| dbxquery query="SELECT  SCB.ORG_ID, 'SHIP_CONFIRM_BATCH' AS  SHIP_CONFIRM_TYPE ,SCB.SHIP_CONFIRM_BATCH_ID, ' ' AS \"ORDER\", concat(SCBS.STATUS_ID,'-',SCBS.SHIP_CONFIRM_BATCH_STATUS_DESC) STATUS
 ,SCB.CREATED_TIMESTAMP, SCB.UPDATED_TIMESTAMP
 FROM default_shipconfirm.SHC_SHIP_CONFIRM_BATCH SCB
 LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.STATUS_ID = SCB.STATUS_ID
 WHERE SCB.STATUS_ID  <>  '3000'
 AND SCB.CREATED_TIMESTAMP > NOW() - INTERVAL 24 HOUR
 AND SCB.UPDATED_TIMESTAMP < NOW() - INTERVAL 20 MINUTE
 UNION ALL
 SELECT SCBE.ORG_ID, 'SHIP_CONFIRM_BATCH_ENTRY' AS SHIP_CONFIRM_TYPE, SCBE.SHIP_CONFIRM_BATCH_ID, SCBE.ORDER_ID AS \"ORDER\", concat(SCBS.STATUS_ID,'-',SCBS.SHIP_CONFIRM_BATCH_STATUS_DESC) AS STATUS
 ,SCBE.CREATED_TIMESTAMP, SCBE.UPDATED_TIMESTAMP
 FROM default_shipconfirm. SHC_SHIP_CONFIRM_ENTRY SCBE
 LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.STATUS_ID = SCBE.STATUS_ID
 WHERE SCBE.STATUS_ID not in ('3000','2000')
 AND SCBE.ORDER_ID  NOT IN (SELECT ORIGINAL_ORDER_ID FROM default_dcorder.DCO_ORIGINAL_ORDER WHERE MINIMUM_STATUS = '9000') 
 AND SCBE.ORDER_ID NOT IN (SELECT ORDER_ID FROM default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY WHERE STATUS_ID IN ('2000','3000'))
 AND SCBE.ORDER_ID NOT LIKE '%PICK%LIST%'
 AND SCBE.ORDER_ID NOT IN (SELECT ORDER_ID FROM default_pickpack.PPK_OLPN OLPN WHERE OLPN.ORG_ID = SCBE.ORG_ID AND OLPN.STATUS < 7900)
 AND SCBE.CREATED_TIMESTAMP > NOW() - INTERVAL 24 HOUR
 AND SCBE.UPDATED_TIMESTAMP < NOW() - INTERVAL 20 MINUTE
 " connection="MAPRD_NEW"
 "

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

 SELECT    SCB.org_id,
          'SHIP_CONFIRM_BATCH' AS 'SHIP_CONFIRM_TYPE' ,
          SCB.ship_confirm_batch_id,
          ' ' AS 'ORDER',
          Concat(SCBS.status_id,'-',SCBS.ship_confirm_batch_status_desc) 'STATUS' ,
          SCB.created_timestamp,
          SCB.updated_timestamp
FROM      default_shipconfirm.SHC_SHIP_CONFIRM_BATCH SCB
LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS
ON        SCBS.status_id = SCB.status_id
WHERE     SCB.status_id <> '3000'
AND       SCB.created_timestamp > Now() - INTERVAL 24 hour
AND       SCB.updated_timestamp < Now() - INTERVAL 20 minute
UNION ALL
SELECT    SCBE.org_id,
          'SHIP_CONFIRM_BATCH_ENTRY' AS 'SHIP_CONFIRM_TYPE',
          SCBE.ship_confirm_batch_id,
          SCBE.order_id AS 'ORDER',
          Concat(SCBS.status_id,'-',SCBS.ship_confirm_batch_status_desc) AS 'STATUS' ,
          SCBE.created_timestamp,
          SCBE.updated_timestamp
FROM      default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY SCBE
LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS
ON        SCBS.status_id = SCBE.status_id
WHERE     SCBE.status_id NOT IN ('3000',
                                 '2000')
AND       SCBE.order_id NOT IN
          (
                 SELECT original_order_id
                 FROM   default_dcorder.DCO_ORIGINAL_ORDER
                 WHERE  minimum_status = '9000')
AND       SCBE.order_id NOT IN
          (
                 SELECT order_id
                 FROM   default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY
                 WHERE  status_id IN ('2000',
                                      '3000'))
AND       SCBE.order_id NOT LIKE '%%PICK%%LIST%%'
AND       SCBE.order_id NOT IN
          (
                 SELECT order_id
                 FROM   default_pickpack.PPK_OLPN OLPN
                 WHERE  OLPN.org_id = SCBE.org_id
                 AND    OLPN.status < 7900)
AND       SCBE.created_timestamp > Now() - INTERVAL 24 hour
AND       SCBE.updated_timestamp < Now() - INTERVAL 20 minute;


-- Flattening SQL query to single line (paste and copy from chrome search bar)
SELECT    SCB.org_id,           'SHIP_CONFIRM_BATCH' AS 'SHIP_CONFIRM_TYPE' ,           SCB.ship_confirm_batch_id,           ' ' AS 'ORDER',           Concat(SCBS.status_id,'-',SCBS.ship_confirm_batch_status_desc) 'STATUS' ,           SCB.created_timestamp,           SCB.updated_timestamp FROM      default_shipconfirm.SHC_SHIP_CONFIRM_BATCH SCB LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON        SCBS.status_id = SCB.status_id WHERE     SCB.status_id <> '3000' AND       SCB.created_timestamp > Now() - INTERVAL 24 hour AND       SCB.updated_timestamp < Now() - INTERVAL 20 minute UNION ALL SELECT    SCBE.org_id,           'SHIP_CONFIRM_BATCH_ENTRY' AS 'SHIP_CONFIRM_TYPE',           SCBE.ship_confirm_batch_id,           SCBE.order_id AS 'ORDER',           Concat(SCBS.status_id,'-',SCBS.ship_confirm_batch_status_desc) AS 'STATUS' ,           SCBE.created_timestamp,           SCBE.updated_timestamp FROM      default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY SCBE LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON        SCBS.status_id = SCBE.status_id WHERE     SCBE.status_id NOT IN ('3000',                                  '2000') AND       SCBE.order_id NOT IN           (                  SELECT original_order_id                  FROM   default_dcorder.DCO_ORIGINAL_ORDER                  WHERE  minimum_status = '9000') AND       SCBE.order_id NOT IN           (                  SELECT order_id                  FROM   default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY                  WHERE  status_id IN ('2000',                                       '3000')) AND       SCBE.order_id NOT LIKE '%%PICK%%LIST%%' AND       SCBE.order_id NOT IN           (                  SELECT order_id                  FROM   default_pickpack.PPK_OLPN OLPN                  WHERE  OLPN.org_id = SCBE.org_id                  AND    OLPN.status < 7900) AND       SCBE.created_timestamp > Now() - INTERVAL 24 hour AND       SCBE.updated_timestamp < Now() - INTERVAL 20 minute;

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT SCB.org_id, 'SHIP_CONFIRM_BATCH' AS 'SHIP_CONFIRM_TYPE' , SCB.ship_confirm_batch_id, ' ' AS 'ORDER', Concat(SCBS.status_id,'-',SCBS.ship_confirm_batch_status_desc) 'STATUS' , SCB.created_timestamp, SCB.updated_timestamp FROM default_shipconfirm.SHC_SHIP_CONFIRM_BATCH SCB LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.status_id = SCB.status_id WHERE SCB.status_id <> '3000' AND SCB.created_timestamp > Now() - INTERVAL 24 hour AND SCB.updated_timestamp < Now() - INTERVAL 20 minute UNION ALL SELECT SCBE.org_id, 'SHIP_CONFIRM_BATCH_ENTRY' AS 'SHIP_CONFIRM_TYPE', SCBE.ship_confirm_batch_id, SCBE.order_id AS 'ORDER', Concat(SCBS.status_id,'-',SCBS.ship_confirm_batch_status_desc) AS 'STATUS' , SCBE.created_timestamp, SCBE.updated_timestamp FROM default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY SCBE LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.status_id = SCBE.status_id WHERE SCBE.status_id NOT IN ('3000', '2000') AND SCBE.order_id NOT IN ( SELECT original_order_id FROM default_dcorder.DCO_ORIGINAL_ORDER WHERE minimum_status = '9000') AND SCBE.order_id NOT IN ( SELECT order_id FROM default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY WHERE status_id IN ('2000', '3000')) AND SCBE.order_id NOT LIKE '%%PICK%%LIST%%' AND SCBE.order_id NOT IN ( SELECT order_id FROM default_pickpack.PPK_OLPN OLPN WHERE OLPN.org_id = SCBE.org_id AND OLPN.status < 7900) AND SCBE.created_timestamp > Now() - INTERVAL 24 hour AND SCBE.updated_timestamp < Now() - INTERVAL 20 minute;

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT P.org_id, P.pix_specification_id, PS.description, P.pix_event_payload_id, P.updated_timestamp, P.pk FROM default_pix.PIX_PIX_ENTRY P LEFT JOIN default_pix.PIX_PIX_STATUS PS ON PS.status_id = P.status_id WHERE P.status_id NOT IN ( ''9000'', ''8000'' ) AND P.updated_timestamp < Now() - INTERVAL 1 hour AND P.updated_timestamp > Now() - INTERVAL 1*24*365 hour ORDER BY P.updated_timestamp DESC;
SELECT SCB.org_id, ''SHIP_CONFIRM_BATCH'' AS ''SHIP_CONFIRM_TYPE'' , SCB.ship_confirm_batch_id, '' '' AS ''ORDER'', Concat(SCBS.status_id,''-'',SCBS.ship_confirm_batch_status_desc) ''STATUS'' , SCB.created_timestamp, SCB.updated_timestamp FROM default_shipconfirm.SHC_SHIP_CONFIRM_BATCH SCB LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.status_id = SCB.status_id WHERE SCB.status_id <> ''3000'' AND SCB.created_timestamp > Now() - INTERVAL 24 hour AND SCB.updated_timestamp < Now() - INTERVAL 20 minute UNION ALL SELECT SCBE.org_id, ''SHIP_CONFIRM_BATCH_ENTRY'' AS ''SHIP_CONFIRM_TYPE'', SCBE.ship_confirm_batch_id, SCBE.order_id AS ''ORDER'', Concat(SCBS.status_id,''-'',SCBS.ship_confirm_batch_status_desc) AS ''STATUS'' , SCBE.created_timestamp, SCBE.updated_timestamp FROM default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY SCBE LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.status_id = SCBE.status_id WHERE SCBE.status_id NOT IN (''3000'', ''2000'') AND SCBE.order_id NOT IN ( SELECT original_order_id FROM default_dcorder.DCO_ORIGINAL_ORDER WHERE minimum_status = ''9000'') AND SCBE.order_id NOT IN ( SELECT order_id FROM default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY WHERE status_id IN (''2000'', ''3000'')) AND SCBE.order_id NOT LIKE ''%%PICK%%LIST%%'' AND SCBE.order_id NOT IN ( SELECT order_id FROM default_pickpack.PPK_OLPN OLPN WHERE OLPN.org_id = SCBE.org_id AND OLPN.status < 7900) AND SCBE.created_timestamp > Now() - INTERVAL 24 hour AND SCBE.updated_timestamp < Now() - INTERVAL 20 minute;


-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
SELECT SCB.org_id, ''SHIP_CONFIRM_BATCH'' AS ''SHIP_CONFIRM_TYPE'' , SCB.ship_confirm_batch_id, '' '' AS ''ORDER'', Concat(SCBS.status_id,''-'',SCBS.ship_confirm_batch_status_desc) ''STATUS'' , SCB.created_timestamp, SCB.updated_timestamp FROM default_shipconfirm.SHC_SHIP_CONFIRM_BATCH SCB LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.status_id = SCB.status_id WHERE SCB.status_id <> ''3000'' AND SCB.created_timestamp > Now() - INTERVAL 24 hour AND SCB.updated_timestamp < Now() - INTERVAL 20 minute UNION ALL SELECT SCBE.org_id, ''SHIP_CONFIRM_BATCH_ENTRY'' AS ''SHIP_CONFIRM_TYPE'', SCBE.ship_confirm_batch_id, SCBE.order_id AS ''ORDER'', Concat(SCBS.status_id,''-'',SCBS.ship_confirm_batch_status_desc) AS ''STATUS'' , SCBE.created_timestamp, SCBE.updated_timestamp FROM default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY SCBE LEFT JOIN default_shipconfirm.SHC_SHIP_CONFIRM_BATCH_STATUS SCBS ON SCBS.status_id = SCBE.status_id WHERE SCBE.status_id NOT IN (''3000'', ''2000'') AND SCBE.order_id NOT IN ( SELECT original_order_id FROM default_dcorder.DCO_ORIGINAL_ORDER WHERE minimum_status = ''9000'') AND SCBE.order_id NOT IN ( SELECT order_id FROM default_shipconfirm.SHC_SHIP_CONFIRM_ENTRY WHERE status_id IN (''2000'', ''3000'')) AND SCBE.order_id NOT LIKE ''%%PICK%%LIST%%'' AND SCBE.order_id NOT IN ( SELECT order_id FROM default_pickpack.PPK_OLPN OLPN WHERE OLPN.org_id = SCBE.org_id AND OLPN.status < 7900) AND SCBE.created_timestamp > Now() - INTERVAL 24 hour AND SCBE.updated_timestamp < Now() - INTERVAL 20 minute;

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

