SELECT * FROM app.crontasks
ORDER BY crontaskid ASC 

 
-- insert into app.crontasks (description, longdescription, requesttypeid) 
-- 	select 'DB Alert: Static Route Missing Threshold Value' description, 
-- 		'DB Alert: Static Route Missing Threshold Value' longdescription,
-- 		rt.requesttypeid
-- 	from app.requesttype rt
-- 	where not exists (select 1 from app.crontasks c where c.description = 'DB Alert: Static Route Missing Threshold Value')
-- 		and rt.description = 'db-alert-static-route-missing-threshold';




