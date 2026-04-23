-- Splunk query - DB Alert: MAWM - Olpns W/ Multiple Details Of The Same Item
| dbxquery query="select INV.ORG_ID, L.STATUS, L.PARENT_LPN_ID as PALLET, INV.ON_HAND AS PLT_QTY, INV.ALLOCATED AS PLT_ALLOCATED_QTY ,INV.TO_BE_FILLED AS PLT_TBF, INV.LOCATION_ID AS PLT_LOCATION, L.ILPN_ID AS CHILD_LPN , INV.ITEM_ID
from default_dcinventory.DCI_INVENTORY INV
LEFT JOIN default_dcinventory.DCI_ILPN L ON L.PARENT_LPN_ID = INV.ILPN_ID AND L.ORG_ID = INV.ORG_ID
where L.PARENT_LPN_ID  IN (SELECT ILPN_ID FROM default_dcinventory.DCI_INVENTORY)
and L.PARENT_LPN_ID IN (SELECT ILPN_ID FROM default_dcinventory.DCI_ILPN where status not in ('9000','11000')
);" connection="MAPRD_NEW"

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
select 
        INV.ORG_ID, 
        L.STATUS, 
        L.PARENT_LPN_ID as 'PALLET', 
        INV.ON_HAND AS 'PLT_QTY', 
        INV.ALLOCATED AS 'PLT_ALLOCATED_QTY', 
        INV.TO_BE_FILLED AS 'PLT_TBF', 
        INV.LOCATION_ID AS 'PLT_LOCATION', 
        L.ILPN_ID AS 'CHILD_LPN', 
        INV.ITEM_ID
from default_dcinventory.DCI_INVENTORY INV
        LEFT JOIN default_dcinventory.DCI_ILPN L 
                ON L.PARENT_LPN_ID = INV.ILPN_ID 
                AND L.ORG_ID = INV.ORG_ID
where L.PARENT_LPN_ID  IN (SELECT ILPN_ID 
                                FROM default_dcinventory.DCI_INVENTORY)
and L.PARENT_LPN_ID IN (SELECT ILPN_ID 
                        FROM default_dcinventory.DCI_ILPN 
                        where status not in ('9000','11000'));


-- Flattening SQL query to single line (paste and copy from chrome search bar)
select          INV.ORG_ID,          L.STATUS,          L.PARENT_LPN_ID as 'PALLET',          INV.ON_HAND AS 'PLT_QTY',          INV.ALLOCATED AS 'PLT_ALLOCATED_QTY',          INV.TO_BE_FILLED AS 'PLT_TBF',          INV.LOCATION_ID AS 'PLT_LOCATION',          L.ILPN_ID AS 'CHILD_LPN',          INV.ITEM_ID from default_dcinventory.DCI_INVENTORY INV         LEFT JOIN default_dcinventory.DCI_ILPN L                  ON L.PARENT_LPN_ID = INV.ILPN_ID                  AND L.ORG_ID = INV.ORG_ID where L.PARENT_LPN_ID  IN (SELECT ILPN_ID                                  FROM default_dcinventory.DCI_INVENTORY) and L.PARENT_LPN_ID IN (SELECT ILPN_ID                          FROM default_dcinventory.DCI_ILPN                          where status not in ('9000','11000'));

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
select INV.ORG_ID, L.STATUS, L.PARENT_LPN_ID as 'PALLET', INV.ON_HAND AS 'PLT_QTY', INV.ALLOCATED AS 'PLT_ALLOCATED_QTY', INV.TO_BE_FILLED AS 'PLT_TBF', INV.LOCATION_ID AS 'PLT_LOCATION', L.ILPN_ID AS 'CHILD_LPN', INV.ITEM_ID from default_dcinventory.DCI_INVENTORY INV LEFT JOIN default_dcinventory.DCI_ILPN L ON L.PARENT_LPN_ID = INV.ILPN_ID AND L.ORG_ID = INV.ORG_ID where L.PARENT_LPN_ID IN (SELECT ILPN_ID FROM default_dcinventory.DCI_INVENTORY) and L.PARENT_LPN_ID IN (SELECT ILPN_ID FROM default_dcinventory.DCI_ILPN where status not in ('9000','11000'));

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
select INV.ORG_ID, L.STATUS, L.PARENT_LPN_ID as ''PALLET'', INV.ON_HAND AS ''PLT_QTY'', INV.ALLOCATED AS ''PLT_ALLOCATED_QTY'', INV.TO_BE_FILLED AS ''PLT_TBF'', INV.LOCATION_ID AS ''PLT_LOCATION'', L.ILPN_ID AS ''CHILD_LPN'', INV.ITEM_ID from default_dcinventory.DCI_INVENTORY INV LEFT JOIN default_dcinventory.DCI_ILPN L ON L.PARENT_LPN_ID = INV.ILPN_ID AND L.ORG_ID = INV.ORG_ID where L.PARENT_LPN_ID IN (SELECT ILPN_ID FROM default_dcinventory.DCI_INVENTORY) and L.PARENT_LPN_ID IN (SELECT ILPN_ID FROM default_dcinventory.DCI_ILPN where status not in (''9000'',''11000''));

-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
select INV.ORG_ID, L.STATUS, L.PARENT_LPN_ID as ''PALLET'', INV.ON_HAND AS ''PLT_QTY'', INV.ALLOCATED AS ''PLT_ALLOCATED_QTY'', INV.TO_BE_FILLED AS ''PLT_TBF'', INV.LOCATION_ID AS ''PLT_LOCATION'', L.ILPN_ID AS ''CHILD_LPN'', INV.ITEM_ID from default_dcinventory.DCI_INVENTORY INV LEFT JOIN default_dcinventory.DCI_ILPN L ON L.PARENT_LPN_ID = INV.ILPN_ID AND L.ORG_ID = INV.ORG_ID where L.PARENT_LPN_ID IN (SELECT ILPN_ID FROM default_dcinventory.DCI_INVENTORY) and L.PARENT_LPN_ID IN (SELECT ILPN_ID FROM default_dcinventory.DCI_ILPN where status not in (''9000'',''11000''));

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

