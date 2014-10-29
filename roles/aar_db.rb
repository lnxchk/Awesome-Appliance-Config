name "aar_db"
description "Databass Server for Awesome Appliance Repair"
run_list [ "recipe[mysql::server]" ]
