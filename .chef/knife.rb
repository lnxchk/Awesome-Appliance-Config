current_dir = File.dirname(__FILE__)
organization = ENV['ORGNAME'] || "linuxchick"
aws_access_key_id = ENV['AWS_ACCESS_KEY_ID'] || "AKIAIPSNDCJAFSIOXRQQ"
aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY'] || "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"
log_level                :info
log_location             STDOUT
node_name                "lnxchk"
client_key               "/Users/mandiwalls/.chef/lnxchk.pem"
validation_client_name   "#{organization}-validator"
validation_key           "#{current_dir}/#{organization}-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/#{organization}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks", "/Users/mandiwalls/linuxchick-chef-repo-cookbooks"]
knife[:aws_access_key_id] = "#{aws_access_key_id}"
knife[:aws_secret_access_key] = "#{aws_secret_access_key}"
