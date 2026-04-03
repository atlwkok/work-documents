

select *
from app.cronaction
order by cronactionid



-- insert into app.cronaction (
-- 		CronTaskId, CronActionTypeId, Payload, CreatedBy, LastUpdatedBy)
-- 	select 
-- 		c.crontaskid,
-- 		cat.CronActionTypeId,
-- 		'{"EmailTextOnError":"tbd","TaskName":"DB Alert: Static Route Missing Threshold Value","StateMachine":"wms-tools-state-machine-db-alert","Lambda":"wms-tools-lambda-db-alert","RequestType":"db-alert-static-route-missing-threshold"}',
-- 		'sysuser', 'sysuser'
-- 	from 
-- 		app.cronactiontype cat, app.crontasks c
-- 	where
-- 		c.description = 'DB Alert: Static Route Missing Threshold Value'
-- 		and not exists (select 1 from app.cronaction c2 where c2.crontaskid = c.crontaskid)
-- 		and cat.description = 'NONE';
