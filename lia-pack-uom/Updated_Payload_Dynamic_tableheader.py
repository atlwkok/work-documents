{
    "alertName": "LIA RECORDS WITH PACK UOM TYPE POPULATED",
    "dataSource": "MAWM",
    "database": {
        "connection": "MAPRD_NEW",
        "type": "MySQL",
        "uri": "jdbc:{host}:{port}/information_schema"
    },
    "email": {
        "subject": "Splunk Alert: $orgId$ + $dataSource$ + $alertName$",
        "body": "The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.",
        "fromEmail": "wms-tools-no-reply@rndc-usa.com",
        "toEmail": "wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM",
        "footer": "",
        "attachment": [
            "link-to-alert",
            "link-to-results",
            "inline-table"
        ],
        "tableHeaders": [
            {"orgId":"orgId"},
            {"location_id":"location_id"},
            {"item_id":"item_id"},
            {"pack_uom_type_id":"pack_uom_type_id"},
            {"pack_uom_quantity":"pack_uom_quantity"},
        ]
    },
    "sql": "SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"
}


'{"alertName":"LIA RECORDS WITH PACK UOM TYPE POPULATED","dataSource":"MAWM","database":{"connection":"MAPRD_NEW","type":"MySQL","uri":"jdbc:{host}:{port}/information_schema"},"email":{"subject":"Splunk Alert: $orgId$ + $dataSource$ + $alertName$","body":"The alert condition for ''$orgId$ + $dataSource$ + $alertName$'' was triggered.***MSP TO CLEAN UP*** Clear the PACK UOM TYPE ID and PACK UOM QUANTITY from the Location Item Assignment UI.","fromEmail":"wms-tools-no-reply@rndc-usa.com","toEmail":"wmsinternal@rndc-usa.com, wmsconsultant@rndc-usa.com, WMSMSPSupport@RNDC-USA.COM","footer":"","attachment":["link-to-alert","link-to-results","inline-table"],"tableHeaders":[{"orgId":"orgId"},{"location_id":"location_id"},{"item_id":"item_id"},{"pack_uom_type_id":"pack_uom_type_id"},{"pack_uom_quantity":"pack_uom_quantity"}]},"sql":"SELECT org_id, location_id, item_id, pack_uom_type_id, pack_uom_quantity FROM default_dcinventory.DCI_LOCATION_ITEM_ASSIGNMENT WHERE 1=1 AND org_id= $orgId AND pack_uom_type_id is NOT NULL;"}'




