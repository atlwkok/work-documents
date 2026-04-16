
-- do $$
-- BEGIN
 
-- 	END IF;

-- insert enabled alerts without payload
--  db-alert-shipconf-24h-fail.


insert into app.warehouselocationdetail(description, longdescription, warehouseid, requesttypeid, createdby, lastupdatedby) 
    select rt.description, rt.description, w.warehouseid,  rt.requesttypeid, 'sysuser', 'sysuser' 
        from app.warehouselocation w, app.requesttype rt 
        where w.warehouseshortname not in ('DEFAULTS', 'PRODEV') 
        and rt.description = 'db-alert-shipconf-24h-fail' 
        and not exists (select 1 from app.warehouselocationdetail r 
                            where r.requesttypeid = rt.requesttypeid 
                            and r.warehouseid = w.warehouseid);








-- Check if enabled alerts were properly inserted

select 1 
from app.warehouselocationdetail r, app.warehouselo
						where r.requesttypeid = rt.requesttypeid and r.warehouseid = w.warehouseid
  

select *
	from app.warehouselocationdetail wld, app.warehouselocation wl
	where wld.description like ('%db-alert-shipconf-24h-fail')
	AND wld.warehouseid = wl.warehouseid 
	order by wl.warehouseshortname






-- insert payload for enabled alerts:

 



 -- (Unnamed)
 


-- Check and ensure right payloads are inserted and not affecting other unrelated records


select wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description != 'db-alert-shipconf-24h-fail'
and wld.payload is not null
-- order by wld.payload




select  wld.payload, wl.warehouseshortname, wld.description
from app.warehouselocationdetail wld join app.warehouselocation wl
on wld.warehouseid = wl.warehouseid 
where description = 'db-alert-shipconf-24h-fail'
and wld.payload is not null
order by wld.lastupdatedon



-- Test to ensure payloads can successfully be converted to JSON

SELECT *
FROM (
    SELECT 
        wd.*, 
        row_number() OVER () AS rn
    FROM app.warehouselocationdetail wd
	where description = 'db-alert-shipconf-24h-fail'
) t 
where (payload::jsonb IS NOT NULL);
