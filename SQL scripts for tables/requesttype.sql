SELECT * FROM app.requesttype
ORDER BY requesttypeid ASC 

update app.requesttype
set longdescription = 'db-alert-orders-deselected-waving'
where description = 'db-alert-orders-deselected-waving';

update app.requesttype
set longdescription = 'db-alert-orders-deselected-waving Interactive'
where description = 'db-alert-orders-deselected-waving Interactive';