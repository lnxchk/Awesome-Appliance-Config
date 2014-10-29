name "aar_webserver"
description "Web Server for Awesome Appliance Repair"
run_list [ "recipe[apache2]", "recipe[python]" ]
