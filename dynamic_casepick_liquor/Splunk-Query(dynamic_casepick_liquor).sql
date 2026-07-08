-- Splunk query
-- Original query:
-- Original query:
-- Original query:
-- Original query:
-- Original query:
with
HEAVY_HIT as
(select DOL.ITEM_ID, FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as TOTAL_QTY from default_dcorder.DCO_ORDER DO
join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = 'LIV'
join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
where DO.org_id = 'LIV'
and ext_region like '%R%'
and DO.order_type = 'Standard'
and DOL.item_id not in
    (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA
    join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like 'LIV%'
    where org_id = 'LIV'
    and DL.STORAGE_UOM_ID in ('PACK','UNIT'))
and DO.maximum_status = '1000'
and II.CONVEYABLE = '1'
group by DOL.ITEM_ID
HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'),
 
ORDERS as
(select * from (
select DO1.ORDER_ID, DOL1.ORDER_LINE_ID, DOL1.ITEM_ID, DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC CASES, ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as RN from default_dcorder.DCO_ORDER DO1
join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = 'LIV'
join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
where DO1.org_id = 'LIV'
and DO1.maximum_status = '1000'
and ext_region like '%R%'
and DOL1.item_id in
(select DOL.ITEM_ID from default_dcorder.DCO_ORDER DO
join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = 'LIV'
join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
where DO.org_id = 'LIV'
and ext_region like '%R%'
and DO.order_type = 'Standard'
and DOL.item_id not in
    (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA
    join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like 'LIV%'
    where org_id = 'LIV'
    and DL.STORAGE_UOM_ID in ('PACK','UNIT'))
and DO.maximum_status = '1000'
and II.CONVEYABLE = '1'
and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > '0.9'
group by DOL.ITEM_ID
HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15')
order by 1,3,4) a)
 
select ORDERS.ORDER_ID, ORDERS.ORDER_LINE_ID, HEAVY_HIT.TOTAL_QTY from ORDERS
join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID 
order by TOTAL_QTY desc;
-- Original query:
-- Original query:
-- Original query:
-- Original query:
-- Original query:


-- Parsed query:
-- Parsed query:
-- Parsed query:
-- Parsed query:
-- Parsed query:

with
HEAVY_HIT as
       (select DOL.ITEM_ID, 
              FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as TOTAL_QTY 
              from default_dcorder.DCO_ORDER DO 
                     join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = 'LIV' 
                     join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
              where DO.org_id = 'LIV'
                     and ext_region like '%R%'
                     and DO.order_type = 'Standard'
                     and DOL.item_id not in (select item_id 
                                                 from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA
                                                        join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like 'LIV%'
                                                 where org_id = 'LIV'
                                                        and DL.STORAGE_UOM_ID in ('PACK','UNIT'))
                     and DO.maximum_status = '1000'
                     and II.CONVEYABLE = '1'
              group by DOL.ITEM_ID
              HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'
       ),

ORDERS as
       (select * 
              from (select DO1.ORDER_ID, 
                            DOL1.ORDER_LINE_ID, 
                            DOL1.ITEM_ID, 
                            DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC CASES, 
                            ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as RN 
                     from default_dcorder.DCO_ORDER DO1
                            join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = 'LIV'
                            join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
                     where DO1.org_id = 'LIV'
                            and DO1.maximum_status = '1000'
                            and ext_region like '%R%'
                            and DOL1.item_id in (select DOL.ITEM_ID   
                                                 from default_dcorder.DCO_ORDER DO
                                                        join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = 'LIV'
                                                        join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
                                                 where DO.org_id = 'LIV'
                                                        and ext_region like '%R%'
                                                        and DO.order_type = 'Standard'
                                                        and DOL.item_id not in (select item_id 
                                                                                    from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA
                                                                                           join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like 'LIV%'
                                                                                    where org_id = 'LIV'
                                                                                           and DL.STORAGE_UOM_ID in ('PACK','UNIT')
                                                                             )
                                                        and DO.maximum_status = '1000'
                                                        and II.CONVEYABLE = '1'
                                                        and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > '0.9'
                                                 group by DOL.ITEM_ID
                                                 HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'
                                                 )
                     order by 1,3,4
                     ) 
              a
       )
 
select ORDERS.ORDER_ID, 
       ORDERS.ORDER_LINE_ID, 
       HEAVY_HIT.TOTAL_QTY 
from ORDERS
       join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID 
order by TOTAL_QTY desc;
-- Parsed query:
-- Parsed query:
-- Parsed query:
-- Parsed query:
-- Parsed query:



-- Parsed query with table alias for order_type:
-- Parsed query with table alias for order_type:
-- Parsed query with table alias for order_type:
-- Parsed query with table alias for order_type:

with
HEAVY_HIT as
       (select DOL.ITEM_ID, 
              FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as TOTAL_QTY 
              from default_dcorder.DCO_ORDER DO 
                     join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = 'LIV' 
                     join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
              where DO.org_id = 'LIV'
                     and ext_region like '%R%'
                     and DO.order_type = 'Standard'
                     and DOL.item_id not in (select item_id 
                                                 from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA
                                                        join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like 'LIV%'
                                                 where org_id = 'LIV'
                                                        and DL.STORAGE_UOM_ID in ('PACK','UNIT'))
                     and DO.maximum_status = '1000'
                     and II.CONVEYABLE = '1'
              group by DOL.ITEM_ID
              HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'
       ),

ORDERS as
       (select * 
              from (select DO1.ORDER_ID, 
                            DOL1.ORDER_LINE_ID, 
                            DOL1.ITEM_ID, 
                            DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC CASES, 
                            ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as RN 
                     from default_dcorder.DCO_ORDER DO1
                            join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = 'LIV'
                            join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
                     where DO1.org_id = 'LIV'
                            and DO1.maximum_status = '1000'
                            and ext_region like '%R%'
                            and DOL1.item_id in (select DOL.ITEM_ID   
                                                 from default_dcorder.DCO_ORDER DO
                                                        join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = 'LIV'
                                                        join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like 'LIV%'
                                                 where DO.org_id = 'LIV'
                                                        and ext_region like '%R%'
                                                        and DO.order_type = 'Standard'
                                                        and DOL.item_id not in (select item_id 
                                                                                    from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA
                                                                                           join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like 'LIV%'
                                                                                    where org_id = 'LIV'
                                                                                           and DL.STORAGE_UOM_ID in ('PACK','UNIT')
                                                                             )
                                                        and DO.maximum_status = '1000'
                                                        and II.CONVEYABLE = '1'
                                                        and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > '0.9'
                                                 group by DOL.ITEM_ID
                                                 HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'
                                                 )
                     order by 1,3,4
                     ) 
              a
       )
 
select ORDERS.ORDER_ID, 
       ORDERS.ORDER_LINE_ID, 
       HEAVY_HIT.TOTAL_QTY 
from ORDERS
       join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID 
order by TOTAL_QTY desc;
-- Parsed query with table alias for order_type:
-- Parsed query with table alias for order_type:
-- Parsed query with table alias for order_type:
-- Parsed query with table alias for order_type:



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
with
HEAVY_HIT as
       (select DOL.ITEM_ID, 
              FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as 'TOTAL_QTY' 
              from default_dcorder.DCO_ORDER DO 
                     join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s 
                     join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'')
              where DO.org_id = %(orgId)s
                     and ext_region like '%%R%%'
                     and DO.order_type = 'Standard'
                     and DOL.item_id not in (select item_id 
                                                 from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT 'LIA'
                                                        join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'')
                                                 where org_id = %(orgId)s
                                                        and DL.STORAGE_UOM_ID in ('PACK','UNIT'))
                     and DO.maximum_status = '1000'
                     and II.CONVEYABLE = '1'
              group by DOL.ITEM_ID
              HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'
       ),

ORDERS as
       (select * 
              from (select DO1.ORDER_ID, 
                            DOL1.ORDER_LINE_ID, 
                            DOL1.ITEM_ID, 
                            DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC 'CASES', 
                            ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as 'RN' 
                     from default_dcorder.DCO_ORDER DO1
                            join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = %(orgId)s
                            join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'')
                     where DO1.org_id = %(orgId)s
                            and DO1.maximum_status = '1000'
                            and ext_region like '%%R%%'
                            and DOL1.item_id in (select DOL.ITEM_ID   
                                                 from default_dcorder.DCO_ORDER 'DO'
                                                        join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s
                                                        join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'')
                                                 where DO.org_id = %(orgId)s
                                                        and ext_region like '%%R%%'
                                                        and DO.order_type = 'Standard'
                                                        and DOL.item_id not in (select item_id 
                                                                                    from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA
                                                                                           join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'')
                                                                                    where org_id = %(orgId)s
                                                                                           and DL.STORAGE_UOM_ID in ('PACK','UNIT')
                                                                             )
                                                        and DO.maximum_status = '1000'
                                                        and II.CONVEYABLE = '1'
                                                        and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > '0.9'
                                                 group by DOL.ITEM_ID
                                                 HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'
                                                 )
                     order by 1,3,4
                     ) 
              a
       )
 
select ORDERS.ORDER_ID, 
       ORDERS.ORDER_LINE_ID, 
       HEAVY_HIT.TOTAL_QTY 
from ORDERS
       join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID 
order by TOTAL_QTY desc;


-- Flattening SQL query to single line (paste and copy from chrome search bar)
with HEAVY_HIT as        (select DOL.ITEM_ID,                FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as 'TOTAL_QTY'                from default_dcorder.DCO_ORDER DO                       join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s                       join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'')               where DO.org_id = %(orgId)s                      and ext_region like '%%R%%'                      and DO.order_type = 'Standard'                      and DOL.item_id not in (select item_id                                                   from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT 'LIA'                                                         join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'')                                                  where org_id = %(orgId)s                                                         and DL.STORAGE_UOM_ID in ('PACK','UNIT'))                      and DO.maximum_status = '1000'                      and II.CONVEYABLE = '1'               group by DOL.ITEM_ID               HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'        ),  ORDERS as        (select *                from (select DO1.ORDER_ID,                              DOL1.ORDER_LINE_ID,                              DOL1.ITEM_ID,                              DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC 'CASES',                              ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as 'RN'                       from default_dcorder.DCO_ORDER DO1                             join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = %(orgId)s                             join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'')                      where DO1.org_id = %(orgId)s                             and DO1.maximum_status = '1000'                             and ext_region like '%%R%%'                             and DOL1.item_id in (select DOL.ITEM_ID                                                     from default_dcorder.DCO_ORDER 'DO'                                                         join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s                                                         join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'')                                                  where DO.org_id = %(orgId)s                                                         and ext_region like '%%R%%'                                                         and DO.order_type = 'Standard'                                                         and DOL.item_id not in (select item_id                                                                                      from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA                                                                                            join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'')                                                                                     where org_id = %(orgId)s                                                                                            and DL.STORAGE_UOM_ID in ('PACK','UNIT')                                                                              )                                                         and DO.maximum_status = '1000'                                                         and II.CONVEYABLE = '1'                                                         and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > '0.9'                                                  group by DOL.ITEM_ID                                                  HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15'                                                  )                      order by 1,3,4                      )                a        )   select ORDERS.ORDER_ID,         ORDERS.ORDER_LINE_ID,         HEAVY_HIT.TOTAL_QTY  from ORDERS        join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID  order by TOTAL_QTY desc;

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
with HEAVY_HIT as (select DOL.ITEM_ID, FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as 'TOTAL_QTY' from default_dcorder.DCO_ORDER DO join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO.org_id = %(orgId)s and ext_region like '%%R%%' and DO.order_type = 'Standard' and DOL.item_id not in (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT 'LIA' join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'') where org_id = %(orgId)s and DL.STORAGE_UOM_ID in ('PACK','UNIT')) and DO.maximum_status = '1000' and II.CONVEYABLE = '1' group by DOL.ITEM_ID HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15' ), ORDERS as (select * from (select DO1.ORDER_ID, DOL1.ORDER_LINE_ID, DOL1.ITEM_ID, DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC 'CASES', ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as 'RN' from default_dcorder.DCO_ORDER DO1 join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO1.org_id = %(orgId)s and DO1.maximum_status = '1000' and ext_region like '%%R%%' and DOL1.item_id in (select DOL.ITEM_ID from default_dcorder.DCO_ORDER 'DO' join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO.org_id = %(orgId)s and ext_region like '%%R%%' and DO.order_type = 'Standard' and DOL.item_id not in (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'') where org_id = %(orgId)s and DL.STORAGE_UOM_ID in ('PACK','UNIT') ) and DO.maximum_status = '1000' and II.CONVEYABLE = '1' and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > '0.9' group by DOL.ITEM_ID HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15' ) order by 1,3,4 ) a ) select ORDERS.ORDER_ID, ORDERS.ORDER_LINE_ID, HEAVY_HIT.TOTAL_QTY from ORDERS join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID order by TOTAL_QTY desc;

-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
with HEAVY_HIT as (select DOL.ITEM_ID, FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as ''TOTAL_QTY'' from default_dcorder.DCO_ORDER DO join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO.org_id = %(orgId)s and ext_region like ''%%R%%'' and DO.order_type = ''Standard'' and DOL.item_id not in (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT ''LIA'' join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'') where org_id = %(orgId)s and DL.STORAGE_UOM_ID in (''PACK'',''UNIT'')) and DO.maximum_status = ''1000'' and II.CONVEYABLE = ''1'' group by DOL.ITEM_ID HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= ''15'' ), ORDERS as (select * from (select DO1.ORDER_ID, DOL1.ORDER_LINE_ID, DOL1.ITEM_ID, DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC ''CASES'', ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as ''RN'' from default_dcorder.DCO_ORDER DO1 join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO1.org_id = %(orgId)s and DO1.maximum_status = ''1000'' and ext_region like ''%%R%%'' and DOL1.item_id in (select DOL.ITEM_ID from default_dcorder.DCO_ORDER ''DO'' join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO.org_id = %(orgId)s and ext_region like ''%%R%%'' and DO.order_type = ''Standard'' and DOL.item_id not in (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'') where org_id = %(orgId)s and DL.STORAGE_UOM_ID in (''PACK'',''UNIT'') ) and DO.maximum_status = ''1000'' and II.CONVEYABLE = ''1'' and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > ''0.9'' group by DOL.ITEM_ID HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= ''15'' ) order by 1,3,4 ) a ) select ORDERS.ORDER_ID, ORDERS.ORDER_LINE_ID, HEAVY_HIT.TOTAL_QTY from ORDERS join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID order by TOTAL_QTY desc;

-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
with HEAVY_HIT as (select DOL.ITEM_ID, FLOOR(SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC)) as 'TOTAL_QTY' from default_dcorder.DCO_ORDER DO join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO.org_id = %(orgId)s and ext_region like '%R%' and DO.order_type = 'Standard' and DOL.item_id not in (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT 'LIA' join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'') where org_id = %(orgId)s and DL.STORAGE_UOM_ID in ('PACK','UNIT')) and DO.maximum_status = '1000' and II.CONVEYABLE = '1' group by DOL.ITEM_ID HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15' ), ORDERS as (select * from (select DO1.ORDER_ID, DOL1.ORDER_LINE_ID, DOL1.ITEM_ID, DOL1.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC 'CASES', ROW_NUMBER() OVER(PARTITION BY item_id ORDER BY order_id desc) as 'RN' from default_dcorder.DCO_ORDER DO1 join default_dcorder.DCO_ORDER_LINE DOL1 on DO1.ORDER_ID = DOL1.ORDER_ID and DOL1.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL1.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO1.org_id = %(orgId)s and DO1.maximum_status = '1000' and ext_region like '%R%' and DOL1.item_id in (select DOL.ITEM_ID from default_dcorder.DCO_ORDER 'DO' join default_dcorder.DCO_ORDER_LINE DOL on DO.ORDER_ID = DOL.ORDER_ID and DOL.ORG_ID = %(orgId)s join default_item_master.ITE_ITEM II on DOL.ITEM_ID = II.ITEM_ID and II.PROFILE_ID like concat(%(orgId)s , ''%%'') where DO.org_id = %(orgId)s and ext_region like '%R%' and DO.order_type = 'Standard' and DOL.item_id not in (select item_id from default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT LIA join default_dcinventory.DCI_LOCATION DL on LIA.LOCATION_ID = DL.LOCATION_ID and DL.PROFILE_ID like concat(%(orgId)s , ''%%'') where org_id = %(orgId)s and DL.STORAGE_UOM_ID in ('PACK','UNIT') ) and DO.maximum_status = '1000' and II.CONVEYABLE = '1' and DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC > '0.9' group by DOL.ITEM_ID HAVING SUM(DOL.ORIGINAL_ORDERED_QUANTITY/II.EXT_QPC) >= '15' ) order by 1,3,4 ) a ) select ORDERS.ORDER_ID, ORDERS.ORDER_LINE_ID, HEAVY_HIT.TOTAL_QTY from ORDERS join HEAVY_HIT on ORDERS.ITEM_ID = HEAVY_HIT.ITEM_ID order by TOTAL_QTY desc;

-- !!!!!!!!!!!!!!!!!!REMEMBER TO CAPITALIZE ALL TABLE NAMES OTHERWISE MYSQL WILL THROW AN ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- Sample SQL query for updating warehouselocationdetail payload column for db-lia-records-with-pack-uom table
-- update app.warehouselocationdetail set payload = '{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}' where warehouseid = (select w.warehouseid from app.warehouselocation w where w.warehouseshortname='WSD') and requesttypeid=(select rt.requesttypeid from app.requesttype rt where rt.description='db-alert-lia-pack-uom');

