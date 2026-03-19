-- insert into app.crontasks (description, longdescription, requesttypeid) 
-- 	select 'DB Alert: Order Stuck > 15 Mins' description, 
-- 		'DB Alert: Order Stuck > 15 Mins' longdescription,
-- 		rt.requesttypeid
-- 	from app.requesttype rt
-- 	where not exists (select 1 from app.crontasks c where c.description = 'DB Alert: Order Stuck > 15 Mins')
-- 		and rt.description = 'db-alert-order-stuck-15m';



select *
from app.crontasks


	