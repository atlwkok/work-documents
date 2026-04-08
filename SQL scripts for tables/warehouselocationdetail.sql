
-- do $$
-- BEGIN
 
-- 	END IF;
 



select * 
from app.warehouselocationdetail wld join app.warehouselocation wl on wld.warehouseid = wl.warehouseid
where description ='db-alert-static-route-missing-threshold' 
order by wld.description asc, wld.warehouseid asc;

select *
from app.warehouselocationdetail
order by requesttypeid


SELECT *
FROM APP.WAREHOUSELOCATIONDETAIL wld join app.warehouselocation wl
	on wld.warehouseid = wl.warehouseid
WHERE wld.REQUESTTYPEID=70 

	and wl.warehouseshortname = 'PEN' 

 




SELECT *
FROM app.warehouselocation, app.requesttype
where warehouseid in (select wl.warehouseid
            from app.warehouselocation wl  
            where wl.warehouseshortname not in  ('ORL', 'POR', 'WSD', 'PEN'))
    and requesttypeid=(select rt.requesttypeid
                from app.requesttype rt 
                where rt.description='db-alert-route-ui-dflt-miss');









