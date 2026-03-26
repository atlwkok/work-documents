SELECT * FROM app.crontasks
ORDER BY crontaskid ASC 



-- insert into app.crontasks (description, longdescription, requesttypeid) 
-- 	select 'DB Alert: Orders No Designated or Assigned Shipments' description, 
-- 		'DB Alert: Orders No Designated or Assigned Shipments' longdescription,
-- 		rt.requesttypeid
-- 	from app.requesttype rt
-- 	where not exists (select 1 from app.crontasks c where c.description = 'DB Alert: Orders No Designated or Assigned Shipments')
-- 		and rt.description = 'db-alert-order-no-desig-assign';




insert into app.crontasks (description, longdescription, requesttypeid) 
		select 'DB Alert: Orders No Designated Shipments' description, 
		    'DB Alert: Orders No Designated Shipments' longdescription,
			rt.requesttypeid
		from app.requesttype rt
        where not exists (select 1 from app.crontasks c where c.description = 'DB Alert: Orders No Designated Shipments')
			and rt.description = 'db-alert-order-no-desig';