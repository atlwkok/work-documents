-- To parse for sql column for item-img-url-fail alert for udpatedetail SQL excel sheet in the splunk.request.types excel file in sharepoint
-- Converting to SQL -
-- Wrapping column aliases with single qutoes; no need to do the same for table aliases. (see stuck-in-created-15m)
-- Replacing variables if any see (orders-deselected-waving)
--  (remember to append dollar sign in front of property name included in yet-to-be-inserted warehouselocationdetail payload $orgId)
--  (CHANGED TO BE LIKE THIS FOR API-ALERT %(orgId)s )
-- Escaping any special characters; for example % character must be escaped with another % right in front of it (see orders-deselected-waving)
-- ***Remember if property name is to be surrounded by single quotes, please use concat() instead as  cursor.execute() in getAlertData in wms-api 
-- will replace it with another duplicate set of  unnecessary single quotes 
-- ***Remember to add query alias to all sub-queries if not complete (see item-rcpt-zero, where a "c" alias was added at the end which doesn't exist in splunk.)
-- ***Remember to escape double quotes is a json object is found within mail body payload/sql query with double quotes surrounding keys!! (see script 57_Warehouse_Detail_DBalert_MissingItemLevelVerification.sql in wms-api)
-- Correct ’ in email payload body and replace it with ''
-- Remember to test in MySQL Workbench before proceeding!!!
-- ORIGINAL query
SELECT ITEM_ID, IMAGE_URL FROM default_item_master.ITE_ITEM 
WHERE PROFILE_ID LIKE 'ABQ_Org_Profile%'

-- Parsed query
-- Remember to test in MySQL Workbench before proceeding!!!
SELECT ITEM_ID, IMAGE_URL FROM default_item_master.ITE_ITEM 
WHERE PROFILE_ID LIKE concat(%(orgId)s , '_Org_Profile%%')


-- Flattening SQL query to single line (paste and copy from chrome search bar)
SELECT ITEM_ID, IMAGE_URL FROM default_item_master.ITE_ITEM WHERE PROFILE_ID LIKE concat(%(orgId)s , '_Org_Profile%%')

-- Replacing any space > 1 size with only 1 space (in VS code, search using regex -> \s\s+ and then replace with single space); verify with https://www.dpriver.com/pp/sqlformat.htm that it's equal to processed query
SELECT ITEM_ID, IMAGE_URL FROM default_item_master.ITE_ITEM WHERE PROFILE_ID LIKE concat(%(orgId)s , '_Org_Profile%%')
-- Query with aliases surrounded by double quotes, to be inserted into excel as part of payload after converting to string with no newlines to be value of sql property in payload.
-- When referring to strings in SQL query, should be surrounded by single quote.
SELECT ITEM_ID, IMAGE_URL FROM default_item_master.ITE_ITEM WHERE PROFILE_ID LIKE concat(%(orgId)s , ''_Org_Profile%%'')

-- Query with table name in all caps, otherwise MySQL will not be able to find the table.
SELECT ITEM_ID, IMAGE_URL FROM default_item_master.ITE_ITEM WHERE PROFILE_ID LIKE concat(%(orgId)s , ''_Org_Profile%%'')
