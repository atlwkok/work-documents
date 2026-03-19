-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 		select 
-- 			(select max(r.requesttypeid) 
-- 				from app.requesttype r) + 1 requesttypeid,
-- 			41, 
-- 			'db-alert-order-stuck-15m', 
-- 			'db-alert-order-stuck-15m'
-- 			where not exists (
-- 				select 1 
-- 				from app.requesttype r2 where r2.approute = 41 );
    
	
-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 		select 
-- 			(select max(r.requesttypeid) 
-- 				from app.requesttype r) + 1 requesttypeid,
-- 			42, 
-- 			'db-alert-order-stuck-15m Interactive', 
-- 			'db-alert-order-stuck-15m Interactive'
-- 			where not exists (
-- 				select 1 
-- 				from app.requesttype r2 where r2.approute = 42 );


select *
from app.requesttype