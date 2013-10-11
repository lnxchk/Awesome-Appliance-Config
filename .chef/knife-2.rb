current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "colincam"
client_key               "#{current_dir}/colincam.pem"
validation_client_name   "awesome-appliance-repair-validator"
validation_key           "#{current_dir}/awesome-appliance-repair-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/awesome-appliance-repair"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
