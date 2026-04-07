-- Splunk query
| dbxquery query="SELECT T.ORG_ID, T.EXT_ROUTE_ID,  COUNT(DISTINCT T.WAVE_NBR) WAVE_NBR FROM ( 
 select
OL.ORG_ID,
OL.ORIGINAL_ORDER_ID,
OL.DESIGNATED_SHIPMENT_ID,
O.EXT_ROUTE_ID,
OL.ORIGINAL_ORDER_LINE_ID,
OL.STATUS_CHANGE_DATE_TIME,
PLA.CREATED_TIMESTAMP,
OL.ORIGINAL_ORDER_PLANNING_RUN_ID, OL.ORDER_PLANNING_RUN_ID,
case when OL.ORIGINAL_ORDER_PLANNING_RUN_ID is null then OL.ORDER_PLANNING_RUN_ID else OL.ORIGINAL_ORDER_PLANNING_RUN_ID end as WAVE_NBR,
OL.STATUS
FROM default_dcorder.DCO_ORDER_LINE OL
join default_dcorder.DCO_ORDER O on OL.order_id = O.order_id and O.org_id = 'WSD' and O.pipeline_id ='RNDC_Standard_Order_Pipeline'
JOIN default_dcorder.DCO_ORDER_PLAN_RUN_STRATEGY PLA ON
(case when OL.ORIGINAL_ORDER_PLANNING_RUN_ID is null then OL.ORDER_PLANNING_RUN_ID else OL.ORIGINAL_ORDER_PLANNING_RUN_ID end) = PLA.order_planning_run_id
WHERE 1=1
AND UPPER(PLA.PLANNING_STRATEGY_ID) LIKE '%STANDARD%' and PLA.status <> '900'
AND OL.STATUS IN ('CREATED','READY','WORKINPROGRESS','WORKCOMPLETED','ALLOCATED','FAILED','PACKING','PACKED','STAGED','MANIFESTED')
AND OL.ORIGINAL_ORDER_ID IN (SELECT ORIGINAL_ORDER_ID FROM default_dcorder.DCO_ORDER WHERE ORDER_TYPE = 'Standard')
AND OL.ORG_ID = 'WSD'
AND  (OL.ORIGINAL_ORDER_PLANNING_RUN_ID IN (SELECT RUN_ID FROM default_dcallocation.DCA_ALLOCATION_RUN WHERE CREATED_TIMESTAMP > NOW() - INTERVAL 8 HOUR)
OR OL.ORDER_PLANNING_RUN_ID  IN (SELECT RUN_ID FROM default_dcallocation.DCA_ALLOCATION_RUN WHERE CREATED_TIMESTAMP > NOW() - INTERVAL 8 HOUR)
)
) T
GROUP BY T.ORG_ID, T.EXT_ROUTE_ID
having count(DISTINCT WAVE_NBR) > 1" connection="MAPRD_NEW"

-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
-- ***Remember if property name is to be surrounded by single quotes, please use concat() instead as  cursor.execute() in getAlertData in wms-api
 SELECT T.org_id,
       T.ext_route_id,
       Count(DISTINCT T.wave_nbr) 'WAVE_NBR'
FROM   (SELECT OL.org_id,
               OL.original_order_id,
               OL.designated_shipment_id,
               O.ext_route_id,
               OL.original_order_line_id,
               OL.status_change_date_time,
               PLA.created_timestamp,
               OL.original_order_planning_run_id,
               OL.order_planning_run_id,
               CASE
                 WHEN OL.original_order_planning_run_id IS NULL THEN
                 OL.order_planning_run_id
                 ELSE OL.original_order_planning_run_id
               END AS 'WAVE_NBR',
               OL.status
        FROM   default_dcorder.dco_order_line OL
               join default_dcorder.dco_order O
                 ON OL.order_id = O.order_id
                    AND O.org_id = $orgId
                    AND O.pipeline_id = 'RNDC_Standard_Order_Pipeline'
               join default_dcorder.dco_order_plan_run_strategy PLA
                 ON ( CASE
                        WHEN OL.original_order_planning_run_id IS NULL THEN
                        OL.order_planning_run_id
                        ELSE OL.original_order_planning_run_id
                      END ) = PLA.order_planning_run_id
        WHERE  1 = 1
               AND Upper(PLA.planning_strategy_id) LIKE '%%STANDARD%'
               AND PLA.status <> '900'
               AND OL.status IN ( 'CREATED', 'READY', 'WORKINPROGRESS',
                                  'WORKCOMPLETED'
                                  ,
                                  'ALLOCATED', 'FAILED', 'PACKING', 'PACKED',
                                  'STAGED', 'MANIFESTED' )
               AND OL.original_order_id IN (SELECT original_order_id
                                            FROM   default_dcorder.dco_order
                                            WHERE  order_type = 'Standard')
               AND OL.org_id = $orgId
               AND ( OL.original_order_planning_run_id IN (SELECT run_id
                                                           FROM
                           default_dcallocation.dca_allocation_run
                                                           WHERE
                           created_timestamp > Now() - interval 8 hour)
                      OR OL.order_planning_run_id IN (SELECT run_id
                                                      FROM
                         default_dcallocation.dca_allocation_run
                                                      WHERE
                         created_timestamp > Now() -
                         interval 8 hour) )) T
GROUP  BY T.org_id,
          T.ext_route_id
HAVING Count(DISTINCT wave_nbr) > 1;  

-- Flattening SQL query to single line (paste and copy from chrome search bar)
SELECT * FROM   (SELECT 'IND' AS 'WHSE', CASE WHEN Count(*) = '0' THEN 'MISSING DFLT STATIC ROUTE VALUE' ELSE 'OK' END   AS 'STATUS' FROM   (SELECT static_route_id, profile_id FROM   default_routing.rtg_static_route WHERE  static_route_id = 'DFLT' AND profile_id = concat($orgId, '_Org_Profile'))A)B WHERE  status <> 'OK';

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT * FROM   (SELECT 'IND' AS 'WHSE', CASE WHEN Count(*) = '0' THEN 'MISSING DFLT STATIC ROUTE VALUE' ELSE 'OK' END   AS 'STATUS' FROM   (SELECT static_route_id, profile_id FROM   default_routing.rtg_static_route WHERE  static_route_id = 'DFLT' AND profile_id = concat($orgId, '_Org_Profile'))A)B WHERE  status <> 'OK';

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT * FROM   (SELECT ''IND'' AS ''WHSE'', CASE WHEN Count(*) = ''0'' THEN ''MISSING DFLT STATIC ROUTE VALUE'' ELSE ''OK'' END   AS ''STATUS'' FROM   (SELECT static_route_id, profile_id FROM   default_routing.rtg_static_route WHERE  static_route_id = ''DFLT'' AND profile_id = concat($orgId, ''_Org_Profile''))A)B WHERE  status <> ''OK'';


-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
 SELECT * FROM   (SELECT ''IND'' AS ''WHSE'', CASE WHEN Count(*) = ''0'' THEN ''MISSING DFLT STATIC ROUTE VALUE'' ELSE ''OK'' END   AS ''STATUS'' FROM   (SELECT static_route_id, profile_id FROM   default_routing.RTG_STATIC_ROUTE WHERE  static_route_id = ''DFLT'' AND profile_id = concat($orgId, ''_Org_Profile''))A)B WHERE  status <> ''OK'';

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

