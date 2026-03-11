-- Splunk query
dbxquery query="SELECT
 OO.ORG_ID,
 OO.CREATED_TIMESTAMP,
 OO.BILLING_ACCOUNT_NUMBER,
 OO.ORIGINAL_ORDER_ID,
 OO.ORDER_TYPE,
 OO.MAXIMUM_STATUS,
 STATUS.DESCRIPTION,
 OO.CANCELLED,
 OO.BILL_TO_NAME,
 OO.EXT_ROUTE_ID,
 OO.EXT_SHIPMENT_STOP_NUMBER
 FROM
 default_dcorder.DCO_ORIGINAL_ORDER OO
 JOIN default_dcorder.DCO_ORDER_STATUS STATUS ON OO.MAXIMUM_STATUS = STATUS.ORDER_STATUS_ID
 WHERE
 1=1
 AND (OO.MAXIMUM_STATUS = '0000' or OO.MAXIMUM_STATUS = '0000')
 AND OO.CREATED_TIMESTAMP <= DATE_SUB(now(), INTERVAL '10' MINUTE);
 " connection="MAPRD_NEW"
  |rename ORG_ID as "Org ID", CREATED_TIMESTAMP AS "Created Timestamp", BILLING_ACCOUNT_NUMBER AS "Billing Acct #", ORIGINAL_ORDER_ID AS "Original Order ID", ORDER_TYPE AS "Order Type", MAXIMUM_STATUS AS "Maximum Status", DESCRIPTION AS "Description", CANCELLED AS "Cancelled", BILL_TO_NAME AS "Bill-to Name", EXT_ROUTE_ID AS "Ext Route ID", EXT_SHIPMENT_STOP_NUMBER AS "Ext Shipment Stop #"
 |table "Org ID", "Created Timestamp", "Billing Acct #", "Original Order ID", "Order Type", "Maximum Status", "Description", "Cancelled", "Bill-to Name", "Ext Route ID", "Ext Shipment Stop #"


-- Converting to SQL query with aliases
SELECT
    OO.ORG_ID 'Org ID',
    OO.CREATED_TIMESTAMP 'Created Timestamp',
    OO.BILLING_ACCOUNT_NUMBER 'Billing Acct #',
    OO.ORIGINAL_ORDER_ID 'Original Order ID',
    OO.ORDER_TYPE 'Order Type',
    OO.MAXIMUM_STATUS 'Maximum Status',
    STATUS.DESCRIPTION 'Description',
    OO.CANCELLED 'Cancelled',
    OO.BILL_TO_NAME 'Bill-to Name',
    OO.EXT_ROUTE_ID 'Ext Route ID',
    OO.EXT_SHIPMENT_STOP_NUMBER 'Ext Shipment Stop #'
 FROM 
    default_dcorder.DCO_ORIGINAL_ORDER OO
    JOIN default_dcorder.DCO_ORDER_STATUS STATUS ON OO.MAXIMUM_STATUS = STATUS.ORDER_STATUS_ID
 WHERE
    1=1
    AND (OO.MAXIMUM_STATUS = '0000' or OO.MAXIMUM_STATUS = '0000')
    AND OO.CREATED_TIMESTAMP <= DATE_SUB(now(), INTERVAL '10' MINUTE);


-- Converting to SQL query without aliases 
SELECT
 OO.ORG_ID,
 OO.CREATED_TIMESTAMP,
 OO.BILLING_ACCOUNT_NUMBER,
 OO.ORIGINAL_ORDER_ID,
 OO.ORDER_TYPE,
 OO.MAXIMUM_STATUS,
 STATUS.DESCRIPTION,
 OO.CANCELLED,
 OO.BILL_TO_NAME,
 OO.EXT_ROUTE_ID,
 OO.EXT_SHIPMENT_STOP_NUMBER
 FROM
 default_dcorder.DCO_ORIGINAL_ORDER OO
 JOIN default_dcorder.DCO_ORDER_STATUS STATUS ON OO.MAXIMUM_STATUS = STATUS.ORDER_STATUS_ID
 WHERE
 1=1
 AND (OO.MAXIMUM_STATUS = '0000' or OO.MAXIMUM_STATUS = '0000')
 AND OO.CREATED_TIMESTAMP <= DATE_SUB(now(), INTERVAL '10' MINUTE);


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
"SELECT OO.ORG_ID 'Org ID', OO.CREATED_TIMESTAMP 'Created Timestamp',OO.BILLING_ACCOUNT_NUMBER 'Billing Acct #', OO.ORIGINAL_ORDER_ID 'Original Order ID', OO.ORDER_TYPE 'Order Type', OO.MAXIMUM_STATUS 'Maximum Status', STATUS.DESCRIPTION 'Description', OO.CANCELLED 'Cancelled', OO.BILL_TO_NAME 'Bill-to Name', OO.EXT_ROUTE_ID 'Ext Route ID', OO.EXT_SHIPMENT_STOP_NUMBER 'Ext Shipment Stop #' FROM default_dcorder.DCO_ORIGINAL_ORDER OO JOIN default_dcorder.DCO_ORDER_STATUS STATUS ON OO.MAXIMUM_STATUS = STATUS.ORDER_STATUS_ID WHERE 1=1 AND (OO.MAXIMUM_STATUS = '0000' or OO.MAXIMUM_STATUS = '0000') AND OO.CREATED_TIMESTAMP <= DATE_SUB(now(), INTERVAL '10' MINUTE);"
 
 insert into table (V)
 set payload = "SELECT OO.ORG_ID 'Org ID', OO.CREATED_TIMESTAMP 'Created Timestamp',OO.BILLING_ACCOUNT_NUMBER 'Billing Acct #', OO.ORIGINAL_ORDER_ID 'Original Order ID', OO.ORDER_TYPE 'Order Type', OO.MAXIMUM_STATUS 'Maximum Status', STATUS.DESCRIPTION 'Description', OO.CANCELLED 'Cancelled', OO.BILL_TO_NAME 'Bill-to Name', OO.EXT_ROUTE_ID 'Ext Route ID', OO.EXT_SHIPMENT_STOP_NUMBER 'Ext Shipment Stop #' FROM default_dcorder.DCO_ORIGINAL_ORDER OO JOIN default_dcorder.DCO_ORDER_STATUS STATUS ON OO.MAXIMUM_STATUS = STATUS.ORDER_STATUS_ID WHERE 1=1 AND (OO.MAXIMUM_STATUS = '0000' or OO.MAXIMUM_STATUS = '0000') AND OO.CREATED_TIMESTAMP <= DATE_SUB(now(), INTERVAL '10' MINUTE);"





 
