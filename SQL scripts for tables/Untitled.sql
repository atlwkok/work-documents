-- insert into app.cronaction (
-- 		CronTaskId, CronActionTypeId, Payload, CreatedBy, LastUpdatedBy)
-- 	select 
-- 		c.crontaskid,
-- 		cat.CronActionTypeId,
-- 		'{"EmailTextOnError":"tbd","TaskName":"DB Alert: Order Stuck > 15 Mins","StateMachine":"wms-tools-state-machine-db-alert-order-stuck-15m","Lambda":"wms-tools-state-machine-db-alert-order-stuck-15m","RequestType":"db-alert-order-stuck-15m"}',
-- 		'sysuser', 'sysuser'
-- 	from 
-- 		app.cronactiontype cat, app.crontasks c
-- 	where
-- 		c.description = 'DB Alert: Order Stuck > 15 Mins'
-- 		and not exists (select 1 from app.cronaction c2 where c2.crontaskid = c.crontaskid)
-- 		and cat.description = 'NONE';

-- To update original order-stuck-15m alert to insert payload
-- update app.cronaction 
-- 	set payload='{"EmailTextOnError":"tbd","TaskName":"DB Alert: Order Stuck > 15 Mins","StateMachine":"wms-tools-state-machine-db-alert-order-stuck-15m","Lambda":"wms-tools-lambda-db-alert-order-stuck-15m","RequestType":"db-alert-order-stuck-15m"}'
-- 	where cronactionid = 6

-- Since RunLambda in CronTaskRepo in wms-api is unable to find a deployed Lambda function with wms-tools-lambda-db-alert-order-stuck-15m, 
-- try changing it to wms-tools-lambda-db-alert-lia-pack-uom to utilize the general lambda that we already have
-- update app.cronaction 
-- 	set payload='{"EmailTextOnError":"tbd","TaskName":"DB Alert: Order Stuck > 15 Mins","StateMachine":"wms-tools-state-machine-db-alert","Lambda":"wms-tools-lambda-db-alert","RequestType":"db-alert-order-stuck-15m"}'
-- 	where cronactionid = 6	


select *
from app.cronaction
order by crontaskid

-- insert into app.cronaction (
-- 		CronTaskId, CronActionTypeId, Payload, CreatedBy, LastUpdatedBy)
-- 	select 
-- 		c.crontaskid,
-- 		cat.CronActionTypeId,
-- 		'{"EmailTextOnError":"tbd","TaskName":"DB Alert: Orders No Designated or Assigned Shipments","StateMachine":"wms-tools-state-machine-db-alert","Lambda":"wms-tools-lambda-db-alert","RequestType":"db-alert-order-no-desig-assign"}',
-- 		'sysuser', 'sysuser'
-- 	from 
-- 		app.cronactiontype cat, app.crontasks c
-- 	where
-- 		c.description = 'DB Alert: Orders No Designated or Assigned Shipments'
-- 		and not exists (select 1 from app.cronaction c2 where c2.crontaskid = c.crontaskid)
-- 		and cat.description = 'NONE';


