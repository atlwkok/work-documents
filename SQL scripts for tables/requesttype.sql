
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
 
-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 	select 
-- 		(select max(r.requesttypeid) 
-- 			from app.requesttype r) + 1 requesttypeid,
-- 		57, 
-- 		'db-alert-order-no-desig', 
-- 		'db-alert-order-no-desig'
-- 		where not exists (
-- 			select 1 
-- 			from app.requesttype r2 where r2.approute = 57 );



-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 	select 
-- 		(select max(r.requesttypeid) 
-- 			from app.requesttype r) + 1 requesttypeid,
-- 		58, 
-- 		'db-alert-order-no-desig Interactive', 
-- 		'db-alert-order-no-desig Interactive'
-- 		where not exists (
-- 			select 1 
-- 			from app.requesttype r2 where r2.approute = 58 );


select *
from app.requesttype
order by approute

-- select rt.requesttypeid
-- 						from app.requesttype rt 
-- 						where rt.description='db-alert-orders-deselected-waving'


<<<<<<< Updated upstream
=======
-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 	select 
-- 		(select max(r.requesttypeid) 
-- 			from app.requesttype r) + 1 requesttypeid,
-- 		59, 
-- 		'db-alert-static-route-missing-threshold', 
-- 		'db-alert-static-route-missing-threshold'
-- 		where not exists (
-- 			select 1 
-- 			from app.requesttype r2 where r2.approute = 59 );


-- insert into app.requesttype(requesttypeid, approute, description, longdescription)
-- 	select 
-- 		(select max(r.requesttypeid) 
-- 			from app.requesttype r) + 1 requesttypeid,
-- 		60, 
-- 		'db-alert-static-route-missing-threshold Interactive', 
-- 		'db-alert-static-route-missing-threshold Interactive'
-- 		where not exists (
-- 			select 1 
-- 			from app.requesttype r2 where r2.approute = 60 );



-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 63, 'lpns-no-task-api-fail', 'lpns-no-task-api-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 63 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 65, 'fs-alpha-asn-error', 'fs-alpha-asn-error' where not exists (select 1 from app.requesttype r2 where r2.approute = 65 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 67, 'fs-alpha-open-err-asn', 'fs-alpha-open-err-asn' where not exists (select 1 from app.requesttype r2 where r2.approute = 67 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 69, 'fs-alpha-open-returns', 'fs-alpha-open-returns' where not exists (select 1 from app.requesttype r2 where r2.approute = 69 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 71, 'divert-conf-down', 'divert-conf-down' where not exists (select 1 from app.requesttype r2 where r2.approute = 71 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 73, 'endpoint-queue-fail', 'endpoint-queue-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 73 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 75, 'endpoint-status', 'endpoint-status' where not exists (select 1 from app.requesttype r2 where r2.approute = 75 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 77, 'ilpns-neg-alloc', 'ilpns-neg-alloc' where not exists (select 1 from app.requesttype r2 where r2.approute = 77 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 79, 'item-img-url-fail', 'item-img-url-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 79 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 81, 'db-alert-route-ui-dflt-miss', 'db-alert-route-ui-dflt-miss' where not exists (select 1 from app.requesttype r2 where r2.approute = 81 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 83, 'db-alert-routes-multi-wave', 'db-alert-routes-multi-wave' where not exists (select 1 from app.requesttype r2 where r2.approute = 83 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 85, 'db-alert-itemloc-prd', 'db-alert-itemloc-prd' where not exists (select 1 from app.requesttype r2 where r2.approute = 85 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 87, 'loc-rebuild-fail', 'loc-rebuild-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 87 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 89, 'db-alert-dup-pix-mw-wms', 'db-alert-dup-pix-mw-wms' where not exists (select 1 from app.requesttype r2 where r2.approute = 89 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 91, 'db-alert-dup-ship-conf', 'db-alert-dup-ship-conf' where not exists (select 1 from app.requesttype r2 where r2.approute = 91 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 93, 'lpns-consumed-api', 'lpns-consumed-api' where not exists (select 1 from app.requesttype r2 where r2.approute = 93 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 95, 'db-alert-inv-adj-miss-rc', 'db-alert-inv-adj-miss-rc' where not exists (select 1 from app.requesttype r2 where r2.approute = 95 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 97, 'db-alert-item-rcpt-zero', 'db-alert-item-rcpt-zero' where not exists (select 1 from app.requesttype r2 where r2.approute = 97 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 99, 'pickpack-api-fail', 'pickpack-api-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 99 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 101, 'fs-asw-open-returns', 'fs-asw-open-returns' where not exists (select 1 from app.requesttype r2 where r2.approute = 101 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 103, 'open-task-api-fail', 'open-task-api-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 103 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 105, 'taskdet-api-fail', 'taskdet-api-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 105 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 107, 'db-alert-waves-long-abort', 'db-alert-waves-long-abort' where not exists (select 1 from app.requesttype r2 where r2.approute = 107 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 109, 'db-alert-miss-item-verif', 'db-alert-miss-item-verif' where not exists (select 1 from app.requesttype r2 where r2.approute = 109 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 111, 'fs-asw-pend-ship1w', 'fs-asw-pend-ship1w' where not exists (select 1 from app.requesttype r2 where r2.approute = 111 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 113, 'pick-neg-tbf-api', 'pick-neg-tbf-api' where not exists (select 1 from app.requesttype r2 where r2.approute = 113 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 115, 'pick-tbf-no-task', 'pick-tbf-no-task' where not exists (select 1 from app.requesttype r2 where r2.approute = 115 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 117, 'putaway-api-fail', 'putaway-api-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 117 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 119, 'recoup-sort-api', 'recoup-sort-api' where not exists (select 1 from app.requesttype r2 where r2.approute = 119 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 121, 'db-alert-routed-cancelled', 'db-alert-routed-cancelled' where not exists (select 1 from app.requesttype r2 where r2.approute = 121 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 123, 'db-alert-pix-spec-gt1h', 'db-alert-pix-spec-gt1h' where not exists (select 1 from app.requesttype r2 where r2.approute = 123 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 125, 'db-alert-shipconf-24h-fail', 'db-alert-shipconf-24h-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 125 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 127, 'slot-pack-fail', 'slot-pack-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 127 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 129, 'slot-unit-fail', 'slot-unit-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 129 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 131, 'lia-delpk-api-fail', 'lia-delpk-api-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 131 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 133, 'db-alert-matm-spo-import', 'db-alert-matm-spo-import' where not exists (select 1 from app.requesttype r2 where r2.approute = 133 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 135, 'db-alert-abq-travel-4m', 'db-alert-abq-travel-4m' where not exists (select 1 from app.requesttype r2 where r2.approute = 135 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 137, 'db-alert-asn-no-verif-5d', 'db-alert-asn-no-verif-5d' where not exists (select 1 from app.requesttype r2 where r2.approute = 137 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 139, 'db-alert-ilpns-miss-phys', 'db-alert-ilpns-miss-phys' where not exists (select 1 from app.requesttype r2 where r2.approute = 139 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 141, 'db-alert-loc-pos-street', 'db-alert-loc-pos-street' where not exists (select 1 from app.requesttype r2 where r2.approute = 141 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 143, 'db-alert-loc-inv-no-item', 'db-alert-loc-inv-no-item' where not exists (select 1 from app.requesttype r2 where r2.approute = 143 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 145, 'db-alert-user-def-config', 'db-alert-user-def-config' where not exists (select 1 from app.requesttype r2 where r2.approute = 145 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 147, 'db-alert-lpn-loc-notied', 'db-alert-lpn-loc-notied' where not exists (select 1 from app.requesttype r2 where r2.approute = 147 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 149, 'taskgrp-bulk-fail', 'taskgrp-bulk-fail' where not exists (select 1 from app.requesttype r2 where r2.approute = 149 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 151, 'db-alert-pallet-lpns-inv', 'db-alert-pallet-lpns-inv' where not exists (select 1 from app.requesttype r2 where r2.approute = 151 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 153, 'db-alert-olpn-multi-det', 'db-alert-olpn-multi-det' where not exists (select 1 from app.requesttype r2 where r2.approute = 153 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 155, 'db-alert-open-order-1w', 'db-alert-open-order-1w' where not exists (select 1 from app.requesttype r2 where r2.approute = 155 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 157, 'db-alert-multi-ord-lines', 'db-alert-multi-ord-lines' where not exists (select 1 from app.requesttype r2 where r2.approute = 157 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 159, 'dyn-casepick', 'dyn-casepick' where not exists (select 1 from app.requesttype r2 where r2.approute = 159 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 161, 'dyn-wine-pick', 'dyn-wine-pick' where not exists (select 1 from app.requesttype r2 where r2.approute = 161 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 163, 'db-alert-item-wt-large', 'db-alert-item-wt-large' where not exists (select 1 from app.requesttype r2 where r2.approute = 163 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 165, 'db-alert-item-vol-large', 'db-alert-item-vol-large' where not exists (select 1 from app.requesttype r2 where r2.approute = 165 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 167, 'fs-alpha-adj-45d', 'fs-alpha-adj-45d' where not exists (select 1 from app.requesttype r2 where r2.approute = 167 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 169, 'db-alert-travel-4m', 'db-alert-travel-4m' where not exists (select 1 from app.requesttype r2 where r2.approute = 169 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 171, 'db-alert-olpn-cons-loc', 'db-alert-olpn-cons-loc' where not exists (select 1 from app.requesttype r2 where r2.approute = 171 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 173, 'db-alert-tmp-resv-no-inv', 'db-alert-tmp-resv-no-inv' where not exists (select 1 from app.requesttype r2 where r2.approute = 173 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 175, 'db-alert-tmp-inv-no-resv', 'db-alert-tmp-inv-no-resv' where not exists (select 1 from app.requesttype r2 where r2.approute = 175 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 177, 'db-alert-por-dup-pix', 'db-alert-por-dup-pix' where not exists (select 1 from app.requesttype r2 where r2.approute = 177 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 179, 'db-alert-inv-adj-null-po', 'db-alert-inv-adj-null-po' where not exists (select 1 from app.requesttype r2 where r2.approute = 179 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 181, 'db-alert-packing-olpn-5m', 'db-alert-packing-olpn-5m' where not exists (select 1 from app.requesttype r2 where r2.approute = 181 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 183, 'db-alert-load-no-ship-6h', 'db-alert-load-no-ship-6h' where not exists (select 1 from app.requesttype r2 where r2.approute = 183 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 185, 'db-alert-putaway-open-ilpn', 'db-alert-putaway-open-ilpn' where not exists (select 1 from app.requesttype r2 where r2.approute = 185 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 187, 'db-alert-taskcomp-open-det', 'db-alert-taskcomp-open-det' where not exists (select 1 from app.requesttype r2 where r2.approute = 187 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 189, 'db-alert-taskopen-compdet', 'db-alert-taskopen-compdet' where not exists (select 1 from app.requesttype r2 where r2.approute = 189 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 191, 'db-alert-taskprog-compdet', 'db-alert-taskprog-compdet' where not exists (select 1 from app.requesttype r2 where r2.approute = 191 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 193, 'mawm-cons-report', 'mawm-cons-report' where not exists (select 1 from app.requesttype r2 where r2.approute = 193 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 195, 'upd-ext-barcode', 'upd-ext-barcode' where not exists (select 1 from app.requesttype r2 where r2.approute = 195 );



-- --interactive
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 64, 'lpns-no-task-api-fail Interactive', 'lpns-no-task-api-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 64 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 66, 'fs-alpha-asn-error Interactive', 'fs-alpha-asn-error Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 66 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 68, 'fs-alpha-open-err-asn Interactive', 'fs-alpha-open-err-asn Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 68 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 70, 'fs-alpha-open-returns Interactive', 'fs-alpha-open-returns Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 70 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 72, 'divert-conf-down Interactive', 'divert-conf-down Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 72 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 74, 'endpoint-queue-fail Interactive', 'endpoint-queue-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 74 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 76, 'endpoint-status Interactive', 'endpoint-status Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 76 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 78, 'ilpns-neg-alloc Interactive', 'ilpns-neg-alloc Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 78 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 80, 'item-img-url-fail Interactive', 'item-img-url-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 80 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 82, 'db-alert-route-ui-dflt-miss Interactive', 'db-alert-route-ui-dflt-miss Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 82 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 84, 'db-alert-routes-multi-wave Interactive', 'db-alert-routes-multi-wave Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 84 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 86, 'db-alert-itemloc-prd Interactive', 'db-alert-itemloc-prd Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 86 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 88, 'loc-rebuild-fail Interactive', 'loc-rebuild-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 88 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 90, 'db-alert-dup-pix-mw-wms Interactive', 'db-alert-dup-pix-mw-wms Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 90 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 92, 'db-alert-dup-ship-conf Interactive', 'db-alert-dup-ship-conf Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 92 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 94, 'lpns-consumed-api Interactive', 'lpns-consumed-api Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 94 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 96, 'db-alert-inv-adj-miss-rc Interactive', 'db-alert-inv-adj-miss-rc Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 96 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 98, 'db-alert-item-rcpt-zero Interactive', 'db-alert-item-rcpt-zero Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 98 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 100, 'pickpack-api-fail Interactive', 'pickpack-api-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 100 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 102, 'fs-asw-open-returns Interactive', 'fs-asw-open-returns Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 102 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 104, 'open-task-api-fail Interactive', 'open-task-api-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 104 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 106, 'taskdet-api-fail Interactive', 'taskdet-api-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 106 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 108, 'db-alert-waves-long-abort Interactive', 'db-alert-waves-long-abort Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 108 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 110, 'db-alert-miss-item-verif Interactive', 'db-alert-miss-item-verif Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 110 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 112, 'fs-asw-pend-ship1w Interactive', 'fs-asw-pend-ship1w Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 112 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 114, 'pick-neg-tbf-api Interactive', 'pick-neg-tbf-api Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 114 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 116, 'pick-tbf-no-task Interactive', 'pick-tbf-no-task Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 116 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 118, 'putaway-api-fail Interactive', 'putaway-api-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 118 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 120, 'recoup-sort-api Interactive', 'recoup-sort-api Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 120 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 122, 'db-alert-routed-cancelled Interactive', 'db-alert-routed-cancelled Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 122 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 124, 'db-alert-pix-spec-gt1h Interactive', 'db-alert-pix-spec-gt1h Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 124 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 126, 'db-alert-shipconf-24h-fail Interactive', 'db-alert-shipconf-24h-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 126 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 128, 'slot-pack-fail Interactive', 'slot-pack-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 128 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 130, 'slot-unit-fail Interactive', 'slot-unit-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 130 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 132, 'lia-delpk-api-fail Interactive', 'lia-delpk-api-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 132 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 134, 'db-alert-matm-spo-import Interactive', 'db-alert-matm-spo-import Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 134 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 136, 'db-alert-abq-travel-4m Interactive', 'db-alert-abq-travel-4m Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 136 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 138, 'db-alert-asn-no-verif-5d Interactive', 'db-alert-asn-no-verif-5d Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 138 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 140, 'db-alert-ilpns-miss-phys Interactive', 'db-alert-ilpns-miss-phys Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 140 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 142, 'db-alert-loc-pos-street Interactive', 'db-alert-loc-pos-street Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 142 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 144, 'db-alert-loc-inv-no-item Interactive', 'db-alert-loc-inv-no-item Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 144 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 146, 'db-alert-user-def-config Interactive', 'db-alert-user-def-config Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 146 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 148, 'db-alert-lpn-loc-notied Interactive', 'db-alert-lpn-loc-notied Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 148 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 150, 'taskgrp-bulk-fail Interactive', 'taskgrp-bulk-fail Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 150 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 152, 'db-alert-pallet-lpns-inv Interactive', 'db-alert-pallet-lpns-inv Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 152 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 154, 'db-alert-olpn-multi-det Interactive', 'db-alert-olpn-multi-det Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 154 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 156, 'db-alert-open-order-1w Interactive', 'db-alert-open-order-1w Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 156 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 158, 'db-alert-multi-ord-lines Interactive', 'db-alert-multi-ord-lines Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 158 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 160, 'dyn-casepick Interactive', 'dyn-casepick Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 160 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 162, 'dyn-wine-pick Interactive', 'dyn-wine-pick Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 162 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 164, 'db-alert-item-wt-large Interactive', 'db-alert-item-wt-large Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 164 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 166, 'db-alert-item-vol-large Interactive', 'db-alert-item-vol-large Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 166 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 168, 'fs-alpha-adj-45d Interactive', 'fs-alpha-adj-45d Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 168 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 170, 'db-alert-travel-4m Interactive', 'db-alert-travel-4m Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 170 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 172, 'db-alert-olpn-cons-loc Interactive', 'db-alert-olpn-cons-loc Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 172 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 174, 'db-alert-tmp-resv-no-inv Interactive', 'db-alert-tmp-resv-no-inv Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 174 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 176, 'db-alert-tmp-inv-no-resv Interactive', 'db-alert-tmp-inv-no-resv Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 176 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 178, 'db-alert-por-dup-pix Interactive', 'db-alert-por-dup-pix Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 178 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 180, 'db-alert-inv-adj-null-po Interactive', 'db-alert-inv-adj-null-po Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 180 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 182, 'db-alert-packing-olpn-5m Interactive', 'db-alert-packing-olpn-5m Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 182 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 184, 'db-alert-load-no-ship-6h Interactive', 'db-alert-load-no-ship-6h Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 184 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 186, 'db-alert-putaway-open-ilpn Interactive', 'db-alert-putaway-open-ilpn Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 186 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 188, 'db-alert-taskcomp-open-det Interactive', 'db-alert-taskcomp-open-det Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 188 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 190, 'db-alert-taskopen-compdet Interactive', 'db-alert-taskopen-compdet Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 190 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 192, 'db-alert-taskprog-compdet Interactive', 'db-alert-taskprog-compdet Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 192 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 194, 'mawm-cons-report Interactive', 'mawm-cons-report Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 194 );
-- insert into app.requesttype(requesttypeid, approute, description, longdescription) select (select max(r.requesttypeid) from app.requesttype r) + 1 requesttypeid, 196, 'upd-ext-barcode Interactive', 'upd-ext-barcode Interactive' where not exists (select 1 from app.requesttype r2 where r2.approute = 196 );
-------------------------------REQUESTTYPE INSERTION-------------------------------
>>>>>>> Stashed changes
