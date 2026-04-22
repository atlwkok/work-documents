-- Splunk query - DB Alert: Temporary Reserve Locations W/ Inventory, But No Assignments
| dbxquery query="SELECT DISTINCT INVN.ORG_ID, INVN.LOCATION_ID, COUNT(DISTINCT(INVN.ITEM_ID)) COUNT 
FROM default_dcinventory.DCI_INVENTORY INVN 
LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = INVN.LOCATION_ID AND SUBSTR(LOC.PROFILE_ID,1,3) = INVN.ORG_ID 
WHERE INVN.LOCATION_ID NOT IN  
(SELECT DISTINCT ASSIGN.LOCATION_ID FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT ASSIGN WHERE ASSIGN.ORG_ID = INVN.ORG_ID AND ASSIGN.ITEM_ID IS NOT NULL) 
AND LOC.STORAGE_UOM_ID = 'LPN' 
AND LOC.SKU_DEDICATION_TYPE_ID = 'TEMPORARY' 
AND LOC.LOCATION_TYPE_ID = 'STORAGE' 
AND LOC.PROFILE_ID like 'PEN%' 
AND INVN.ILPN_ID NOT IN (with A as (select ORG_ID, ILPN_ID, COUNT(*) from default_dcinventory.DCI_INVENTORY where INVENTORY_CONTAINER_TYPE_ID = 'ILPN' and ORG_ID = 'PEN' group by 1, 2 having COUNT(*) > '1') select A.ILPN_ID from A)
GROUP BY  INVN.ORG_ID, INVN.LOCATION_ID 
ORDER BY  COUNT(DISTINCT(INVN.ITEM_ID)) DESC;
" connection="MAPRD_NEW"

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
    DISTINCT INVN.ORG_ID, 
    INVN.LOCATION_ID, 
    COUNT(DISTINCT(INVN.ITEM_ID)) 'COUNT'
FROM default_dcinventory.DCI_INVENTORY INVN 
    LEFT JOIN default_dcinventory.DCI_LOCATION LOC 
        ON LOC.LOCATION_ID = INVN.LOCATION_ID 
            AND SUBSTR(LOC.PROFILE_ID,1,3) = INVN.ORG_ID 
WHERE INVN.LOCATION_ID NOT IN  
    (SELECT DISTINCT ASSIGN.LOCATION_ID 
    FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT ASSIGN 
    WHERE ASSIGN.ORG_ID = INVN.ORG_ID 
        AND ASSIGN.ITEM_ID IS NOT NULL) 
AND LOC.STORAGE_UOM_ID = 'LPN' 
AND LOC.SKU_DEDICATION_TYPE_ID = 'TEMPORARY' 
AND LOC.LOCATION_TYPE_ID = 'STORAGE' 
AND LOC.PROFILE_ID like CONCAT($orgId, '%') 
AND INVN.ILPN_ID NOT IN (with A as 
                            (select 
                                ORG_ID, 
                                ILPN_ID, 
                                COUNT(*) 
                            from default_dcinventory.DCI_INVENTORY 
                            where INVENTORY_CONTAINER_TYPE_ID = 'ILPN' 
                                and ORG_ID = $orgId 
                            group by 1, 2 
                                having COUNT(*) > '1') 
                        select A.ILPN_ID 
                            from A)
GROUP BY  INVN.ORG_ID, INVN.LOCATION_ID 
ORDER BY  COUNT(DISTINCT(INVN.ITEM_ID)) DESC;


-- Flattening SQL query to single line (paste and copy from chrome search bar)
SELECT      DISTINCT INVN.ORG_ID,      INVN.LOCATION_ID,      COUNT(DISTINCT(INVN.ITEM_ID)) 'COUNT' FROM default_dcinventory.DCI_INVENTORY INVN      LEFT JOIN default_dcinventory.DCI_LOCATION LOC          ON LOC.LOCATION_ID = INVN.LOCATION_ID              AND SUBSTR(LOC.PROFILE_ID,1,3) = INVN.ORG_ID  WHERE INVN.LOCATION_ID NOT IN       (SELECT DISTINCT ASSIGN.LOCATION_ID      FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT ASSIGN      WHERE ASSIGN.ORG_ID = INVN.ORG_ID          AND ASSIGN.ITEM_ID IS NOT NULL)  AND LOC.STORAGE_UOM_ID = 'LPN'  AND LOC.SKU_DEDICATION_TYPE_ID = 'TEMPORARY'  AND LOC.LOCATION_TYPE_ID = 'STORAGE'  AND LOC.PROFILE_ID like CONCAT($orgId, '%')  AND INVN.ILPN_ID NOT IN (with A as                              (select                                  ORG_ID,                                  ILPN_ID,                                  COUNT(*)                              from default_dcinventory.DCI_INVENTORY                              where INVENTORY_CONTAINER_TYPE_ID = 'ILPN'                                  and ORG_ID = $orgId                              group by 1, 2                                  having COUNT(*) > '1')                          select A.ILPN_ID                              from A) GROUP BY  INVN.ORG_ID, INVN.LOCATION_ID  ORDER BY  COUNT(DISTINCT(INVN.ITEM_ID)) DESC;

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT DISTINCT INVN.ORG_ID, INVN.LOCATION_ID, COUNT(DISTINCT(INVN.ITEM_ID)) 'COUNT' FROM default_dcinventory.DCI_INVENTORY INVN LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = INVN.LOCATION_ID AND SUBSTR(LOC.PROFILE_ID,1,3) = INVN.ORG_ID WHERE INVN.LOCATION_ID NOT IN (SELECT DISTINCT ASSIGN.LOCATION_ID FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT ASSIGN WHERE ASSIGN.ORG_ID = INVN.ORG_ID AND ASSIGN.ITEM_ID IS NOT NULL) AND LOC.STORAGE_UOM_ID = 'LPN' AND LOC.SKU_DEDICATION_TYPE_ID = 'TEMPORARY' AND LOC.LOCATION_TYPE_ID = 'STORAGE' AND LOC.PROFILE_ID like CONCAT($orgId, '%') AND INVN.ILPN_ID NOT IN (with A as (select ORG_ID, ILPN_ID, COUNT(*) from default_dcinventory.DCI_INVENTORY where INVENTORY_CONTAINER_TYPE_ID = 'ILPN' and ORG_ID = $orgId group by 1, 2 having COUNT(*) > '1') select A.ILPN_ID from A) GROUP BY INVN.ORG_ID, INVN.LOCATION_ID ORDER BY COUNT(DISTINCT(INVN.ITEM_ID)) DESC;

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT DISTINCT INVN.ORG_ID, INVN.LOCATION_ID, COUNT(DISTINCT(INVN.ITEM_ID)) ''COUNT'' FROM default_dcinventory.DCI_INVENTORY INVN LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = INVN.LOCATION_ID AND SUBSTR(LOC.PROFILE_ID,1,3) = INVN.ORG_ID WHERE INVN.LOCATION_ID NOT IN (SELECT DISTINCT ASSIGN.LOCATION_ID FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT ASSIGN WHERE ASSIGN.ORG_ID = INVN.ORG_ID AND ASSIGN.ITEM_ID IS NOT NULL) AND LOC.STORAGE_UOM_ID = ''LPN'' AND LOC.SKU_DEDICATION_TYPE_ID = ''TEMPORARY'' AND LOC.LOCATION_TYPE_ID = ''STORAGE'' AND LOC.PROFILE_ID like CONCAT($orgId, ''%'') AND INVN.ILPN_ID NOT IN (with A as (select ORG_ID, ILPN_ID, COUNT(*) from default_dcinventory.DCI_INVENTORY where INVENTORY_CONTAINER_TYPE_ID = ''ILPN'' and ORG_ID = $orgId group by 1, 2 having COUNT(*) > ''1'') select A.ILPN_ID from A) GROUP BY INVN.ORG_ID, INVN.LOCATION_ID ORDER BY COUNT(DISTINCT(INVN.ITEM_ID)) DESC;

-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
SELECT DISTINCT INVN.ORG_ID, INVN.LOCATION_ID, COUNT(DISTINCT(INVN.ITEM_ID)) ''COUNT'' FROM default_dcinventory.DCI_INVENTORY INVN LEFT JOIN default_dcinventory.DCI_LOCATION LOC ON LOC.LOCATION_ID = INVN.LOCATION_ID AND SUBSTR(LOC.PROFILE_ID,1,3) = INVN.ORG_ID WHERE INVN.LOCATION_ID NOT IN (SELECT DISTINCT ASSIGN.LOCATION_ID FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT ASSIGN WHERE ASSIGN.ORG_ID = INVN.ORG_ID AND ASSIGN.ITEM_ID IS NOT NULL) AND LOC.STORAGE_UOM_ID = ''LPN'' AND LOC.SKU_DEDICATION_TYPE_ID = ''TEMPORARY'' AND LOC.LOCATION_TYPE_ID = ''STORAGE'' AND LOC.PROFILE_ID like CONCAT($orgId, ''%'') AND INVN.ILPN_ID NOT IN (with A as (select ORG_ID, ILPN_ID, COUNT(*) from default_dcinventory.DCI_INVENTORY where INVENTORY_CONTAINER_TYPE_ID = ''ILPN'' and ORG_ID = $orgId group by 1, 2 having COUNT(*) > ''1'') select A.ILPN_ID from A) GROUP BY INVN.ORG_ID, INVN.LOCATION_ID ORDER BY COUNT(DISTINCT(INVN.ITEM_ID)) DESC;

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

