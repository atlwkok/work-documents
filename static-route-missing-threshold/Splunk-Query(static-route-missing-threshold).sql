-- Splunk query
| dbxquery query="SELECT SUBSTR(PROFILE_ID, 1, 3) WHSE , STATIC_ROUTE_ID , EXT_THRESHOLD THRESHOLD_VALUE   FROM default_routing.RTG_STATIC_ROUTE   WHERE EXT_THRESHOLD IS NULL AND PROFILE_ID =  'ASH_Org_Profile'" connection="MAPRD_NEW"

-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
SELECT Substr(profile_id, 1, 3) 'WHSE',
       static_route_id,
       ext_threshold 'THRESHOLD_VALUE'
FROM   default_routing.rtg_static_route
WHERE  ext_threshold IS NULL
       AND profile_id = '$orgId_Org_Profile';


-- Flattening SQL query to single line (paste and copy from chrome search bar)
 SELECT Substr(profile_id, 1, 3) 'WHSE',        static_route_id,        ext_threshold 'THRESHOLD_VALUE' FROM   default_routing.rtg_static_route WHERE  ext_threshold IS NULL        AND profile_id = '$orgId_Org_Profile'; 

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT Substr(profile_id, 1, 3) 'WHSE', static_route_id, ext_threshold 'THRESHOLD_VALUE' FROM default_routing.rtg_static_route WHERE ext_threshold IS NULL AND profile_id = '$orgId_Org_Profile'; 

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.rtg_static_route WHERE ext_threshold IS NULL AND profile_id = ''$orgId_Org_Profile''; 


-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
 SELECT Substr(profile_id, 1, 3) ''WHSE'', static_route_id, ext_threshold ''THRESHOLD_VALUE'' FROM default_routing.RTG_STATIC_ROUTE WHERE ext_threshold IS NULL AND profile_id = ''$orgId_Org_Profile'' 

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

