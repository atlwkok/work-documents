update app.databasescripthistory
set success = false
where scriptname like any (array['13_%', '15_%', '16_%','17_%', '18_%', '19_%', '20_%', '22_%', '23_%', 
'25_%', '26_%', '27_%', '28_%', '29_%', '31_%', '33_%', '35_%', '38_%', '39_%', '40_%', '42_%', '45_%'])

select *
from app.databasescripthistory
order by success asc, scriptname asc

select *
from app.databasescripthistory 
where lower(scriptname) like '%deselected%'
order by success;

-- delete 
-- from app.databasescripthistory
-- where historyid in (39, 40)
