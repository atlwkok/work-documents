-- Splunk query
| dbxquery query="SELECT PE.ORG_ID, PE.CREATED_TIMESTAMP, PE.ITEM_ID, 
     CASE WHEN PE.ADJUSTED_TYPE = 'SUBTRACT' THEN -PE.QUANTITY 
         WHEN PE.ADJUSTED_TYPE = 'ADD' THEN PE.QUANTITY 
         END AS QUANTITY
    , PE.REASON_CODE_ID ,PE.SYNC_BATCH_ID,  PE.PIX_SPECIFICATION_ID, CONCAT(PE.STATUS_ID,'-',PS.DESCRIPTION) STATUS, PE.CREATED_BY 
FROM default_pix.PIX_PIX_ENTRY  PE
LEFT JOIN default_pix.PIX_PIX_STATUS PS ON PS.STATUS_ID = PE.STATUS_ID
WHERE PE.PIX_SPECIFICATION_ID = 'Inventory Adjustment' 
AND PE.CREATED_TIMESTAMP between  NOW() + INTERVAL 15 minute  and now() + interval 1455 minute 
AND REASON_CODE_ID IS NULL 
AND PE.ORG_ID = 'ARK'" connection="MAPRD_NEW"

-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
-- ***Remember if property name is to be surrounded by single quotes, please use concat() instead as  cursor.execute() in getAlertData in wms-api
  

 SELECT    PE.org_id,
          PE.created_timestamp,
          PE.item_id,
          CASE
                    WHEN PE.adjusted_type = 'SUBTRACT' THEN -PE.quantity
                    WHEN PE.adjusted_type = 'ADD' THEN PE.quantity
          END AS 'quantity' ,
          PE.reason_code_id ,
          PE.sync_batch_id,
          PE.pix_specification_id,
          Concat(PE.status_id,'-',PS.description) 'status',
          PE.created_by
FROM      default_pix.PIX_PIX_ENTRY PE
LEFT JOIN default_pix.PIX_PIX_STATUS PS
ON        PS.status_id = PE.status_id
WHERE     PE.pix_specification_id = 'Inventory Adjustment'
AND       PE.created_timestamp BETWEEN Now() + interval 15 minute AND       now() + interval 1455 minute
AND       reason_code_id IS NULL
AND       PE.org_id = $orgId;



-- Flattening SQL query to single line (paste and copy from chrome search bar)
SELECT    PE.org_id,           PE.created_timestamp,           PE.item_id,           CASE                     WHEN PE.adjusted_type = 'SUBTRACT' THEN -PE.quantity                     WHEN PE.adjusted_type = 'ADD' THEN PE.quantity           END AS 'quantity' ,           PE.reason_code_id ,           PE.sync_batch_id,           PE.pix_specification_id,           Concat(PE.status_id,'-',PS.description) 'status',           PE.created_by FROM      default_pix.PIX_PIX_ENTRY PE LEFT JOIN default_pix.PIX_PIX_STATUS PS ON        PS.status_id = PE.status_id WHERE     PE.pix_specification_id = 'Inventory Adjustment' AND       PE.created_timestamp BETWEEN Now() + interval 15 minute AND       now() + interval 1455 minute AND       reason_code_id IS NULL AND       PE.org_id = $orgId;

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT PE.org_id, PE.created_timestamp, PE.item_id, CASE WHEN PE.adjusted_type = 'SUBTRACT' THEN -PE.quantity WHEN PE.adjusted_type = 'ADD' THEN PE.quantity END AS 'quantity' , PE.reason_code_id , PE.sync_batch_id, PE.pix_specification_id, Concat(PE.status_id,'-',PS.description) 'status', PE.created_by FROM default_pix.PIX_PIX_ENTRY PE LEFT JOIN default_pix.PIX_PIX_STATUS PS ON PS.status_id = PE.status_id WHERE PE.pix_specification_id = 'Inventory Adjustment' AND PE.created_timestamp BETWEEN Now() + interval 15 minute AND now() + interval 1455 minute AND reason_code_id IS NULL AND PE.org_id = $orgId;

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT PE.org_id, PE.created_timestamp, PE.item_id, CASE WHEN PE.adjusted_type = ''SUBTRACT'' THEN -PE.quantity WHEN PE.adjusted_type = ''ADD'' THEN PE.quantity END AS ''quantity'' , PE.reason_code_id , PE.sync_batch_id, PE.pix_specification_id, Concat(PE.status_id,''-'',PS.description) ''status'', PE.created_by FROM default_pix.PIX_PIX_ENTRY PE LEFT JOIN default_pix.PIX_PIX_STATUS PS ON PS.status_id = PE.status_id WHERE PE.pix_specification_id = ''Inventory Adjustment'' AND PE.created_timestamp BETWEEN Now() + interval 15 minute AND now() + interval 1455 minute AND reason_code_id IS NULL AND PE.org_id = $orgId;

-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
SELECT PE.org_id, PE.created_timestamp, PE.item_id, CASE WHEN PE.adjusted_type = ''SUBTRACT'' THEN -PE.quantity WHEN PE.adjusted_type = ''ADD'' THEN PE.quantity END AS ''quantity'' , PE.reason_code_id , PE.sync_batch_id, PE.pix_specification_id, Concat(PE.status_id,''-'',PS.description) ''status'', PE.created_by FROM default_pix.PIX_PIX_ENTRY PE LEFT JOIN default_pix.PIX_PIX_STATUS PS ON PS.status_id = PE.status_id WHERE PE.pix_specification_id = ''Inventory Adjustment'' AND PE.created_timestamp BETWEEN Now() + interval 15 minute AND now() + interval 1455 minute AND reason_code_id IS NULL AND PE.org_id = $orgId;

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

