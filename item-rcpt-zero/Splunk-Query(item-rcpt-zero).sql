-- Splunk query
| dbxquery query="SELECT itlvl.warehouse, itlvl.pix_spec, itlvl.asn_no, itlvl.po_no, itlvl.po_line, itlvl.item_no, itlvl.qty, spl.rcv_qty, ( 'update pix_Trx set qty =' || ' ' || spl.rcv_qty || ',' || 'prc_status = 10, prc_time = null , prc_date = null, trx_time= ' || '''' || 121821.657 || '''' || ' ' || 'where pix_spec =' || '''' || 'ITEM_Level' || '''' || ' ' || 'and asn_no =' || '''' || itlvl.asn_no || '''' || ' ' || 'and po_no=' || '''' || itlvl.po_no || '''' || ' ' || 'and item_no =' || '''' || itlvl.item_no || '''' || 'and qty = 0' || ';' )\"UPDATE\" FROM  (SELECT DISTINCT ( warehouse ), pix_spec, asn_no, po_no, po_line, item_no, Sum(qty) AS qty FROM pix_trx WHERE 1=1 AND WAREHOUSE = 'POR' AND pix_spec = 'ITEM_Level' GROUP BY  warehouse, pix_spec, asn_no, po_no, po_line, item_no HAVING Sum(qty) = 0 ORDER BY  asn_no, po_no, po_line)itlvl JOIN  (SELECT DISTINCT( warehouse ), asn_no, po_no, po_line, item_no, Sum(abs_qty) AS \"RCV_QTY\" FROM  (SELECT warehouse, pix_spec, asn_no, po_no, po_line, item_no, CASE WHEN add_sub = 'A' THEN ( qty * 1 ) WHEN add_sub = 'S' THEN ( qty *- 1 ) END AS \"ABS_QTY\" FROM pix_trx WHERE 1=1 AND WAREHOUSE = 'POR' AND pix_spec IN ( 'SupplierReceiptId','Inventory Adjustment') ORDER BY  trx_time) fin GROUP BY  warehouse, asn_no, po_no, po_line, item_no ) spl ON itlvl.po_no = spl.po_no AND itlvl.po_line = spl.po_line AND itlvl.asn_no = spl.asn_no WHERE itlvl.qty <> spl.rcv_qty AND itlvl.asn_no NOT IN  (SELECT DISTINCT asn_no FROM  (SELECT t1.asn_no, t1.item_level_qty, t2.asn_level_qty FROM (  (SELECT asn_no, sum(qty) item_level_qty FROM pix_Trx WHERE 1=1 AND WAREHOUSE = 'POR' AND pix_spec = 'ITEM_Level' GROUP BY  asn_no ) t1 LEFT JOIN  (SELECT asn_no, sum(qty) asn_level_qty FROM pix_Trx pt WHERE 1=1 AND WAREHOUSE = 'POR' AND pix_spec = 'ASN Level' GROUP BY  asn_no ) t2 ON t2.asn_no = t1.asn_no ) WHERE t1.item_level_qty = t2.asn_level_qty ) )" connection="MAPRD_NEW"
"
-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
-- ***Remember if property name is to be surrounded by single quotes, please use concat() instead as  cursor.execute() in getAlertData in wms-api
-- ***Remember to add query alias to all sub-queries if not complete (see item-rcpt-zero, where a "c" alias was added at the end which doesn't exist in splunk.)
 SELECT itlvl.warehouse,
       itlvl.pix_spec,
       itlvl.asn_no,
       itlvl.po_no,
       itlvl.po_line,
       itlvl.item_no,
       itlvl.qty,
       spl.rcv_qty,
       ( 'update pix_Trx set qty ='
         || ' '
         || spl.rcv_qty
         || ','
         || 'prc_status = 10, prc_time = null , prc_date = null, trx_time= '
         || ''''
         || 121821.657
         || ''''
         || ' '
         || 'where pix_spec ='
         || ''''
         || 'ITEM_Level'
         || ''''
         || ' '
         || 'and asn_no ='
         || ''''
         || itlvl.asn_no
         || ''''
         || ' '
         || 'and po_no='
         || ''''
         || itlvl.po_no
         || ''''
         || ' '
         || 'and item_no ='
         || ''''
         || itlvl.item_no
         || ''''
         || 'and qty = 0'
         || ';' ) "UPDATE\" (return here)******
FROM   (SELECT DISTINCT ( warehouse ),
                        pix_spec,
                        asn_no,
                        po_no,
                        po_line,
                        item_no,
                        Sum(qty) AS 'qty'
        FROM   pix_trx
        WHERE  1 = 1
               AND warehouse = $orgId
               AND pix_spec = 'ITEM_Level'
        GROUP  BY warehouse,
                  pix_spec,
                  asn_no,
                  po_no,
                  po_line,
                  item_no
        HAVING Sum(qty) = 0
        ORDER  BY asn_no,
                  po_no,
                  po_line) itlvl
       JOIN (SELECT DISTINCT( warehouse ),
                            asn_no,
                            po_no,
                            po_line,
                            item_no,
                            Sum(abs_qty) AS  "RCV_QTY\" (return here)******
             FROM   (SELECT warehouse,
                            pix_spec,
                            asn_no,
                            po_no,
                            po_line,
                            item_no,
                            CASE
                              WHEN add_sub = 'A' THEN ( qty * 1 )
                              WHEN add_sub = 'S' THEN ( qty *- 1 )
                            END AS  "ABS_QTY\" (return here)******
                     FROM   pix_trx
                     WHERE  1 = 1
                            AND warehouse = $orgId
                            AND pix_spec IN ( 'SupplierReceiptId',
                                              'Inventory Adjustment' )
                     ORDER  BY trx_time) fin
             GROUP  BY warehouse,
                       asn_no,
                       po_no,
                       po_line,
                       item_no) spl
         ON itlvl.po_no = spl.po_no
            AND itlvl.po_line = spl.po_line
            AND itlvl.asn_no = spl.asn_no
WHERE  itlvl.qty <> spl.rcv_qty
       AND itlvl.asn_no NOT IN (SELECT DISTINCT asn_no
                                FROM   (SELECT t1.asn_no,
                                               t1.item_level_qty,
                                               t2.asn_level_qty
                                        FROM   ( (SELECT asn_no,
                                                       Sum(qty) 'item_level_qty'
                                                FROM   pix_trx
                                                WHERE  1 = 1
                                                       AND warehouse = $orgId
                                                       AND pix_spec =
                                                           'ITEM_Level'
                                                GROUP  BY asn_no) t1
                                                 LEFT JOIN (SELECT asn_no,
                                                                   Sum(qty)
                                                           'asn_level_qty'
                                                            FROM   pix_trx pt
                                                            WHERE  1 = 1
                                                                   AND
                                                           warehouse =
                                                           $orgId
                                                                   AND
                                                           pix_spec =
                                                           'ASN Level'
                                                            GROUP  BY asn_no) t2
                                                        ON t2.asn_no = t1.asn_no
                                               )
                                        WHERE  t1.item_level_qty =
                                               t2.asn_level_qty) c )  



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

