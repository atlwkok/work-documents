
-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 	select 
-- 		(select max(r.requesttypeid) 
-- 			from app.requesttype r) + 1 requesttypeid,
-- 		55, 
-- 		'order-no-desig-assign', 
-- 		'order-no-desig-assign'
-- 		where not exists (
-- 			select 1 
-- 			from app.requesttype r2 where r2.approute = 55 );

-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 	select 
-- 		(select max(r.requesttypeid) 
-- 			from app.requesttype r) + 1 requesttypeid,
-- 		56, 
-- 		'order-no-desig-assign Interactive', 
-- 		'order-no-desig-assign Interactive'
-- 		where not exists (
-- 			select 1 
-- 			from app.requesttype r2 where r2.approute = 56 );

-- update app.requesttype
-- set description = 'db-alert-order-no-desig-assign'
-- where requesttypeid=53

-- update app.requesttype
-- set longdescription = 'db-alert-order-no-desig-assign'
-- where requesttypeid=53

-- update app.requesttype
-- set description = 'db-alert-order-no-desig-assign Interactive'
-- where requesttypeid=54

-- update app.requesttype
-- set longdescription = 'db-alert-order-no-desig-assign Interactive'
-- where requesttypeid=54

SELECT * FROM app.requesttype
ORDER BY approute ASC 



select * from app.requesttype r2 where r2.approute =50
