# the AAR app code and config
#
# /var/www/AAR/AAR_config.py

require 'securerandom'
node.set_unless['aar']['db_passwd'] = SecureRandom.urlsafe_base64(6)
node.set_unless['aar']['secret_key'] = SecureRandom.urlsafe_base64(12)

template "/var/www/AAR/AAR_config.py" do
  source "aar_config.erb"
  variables(
    :passwd => node['aar']['db_passwd'],
    :secret => node['aar']['secret_key']
  )
  owner node['aar']['system_user']
  group node['aar']['system_group']
  mode 0600
end

# install the pages
ark 'Awesome-Appliance-Repair' do 
  url 'https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip'
  path '/var/tmp'
  owner node['aar']['system_user']
  group node['aar']['system_group']
  action :put
end

execute "move AAR into place" do
  command "mv /var/tmp/Awesome-Appliance-Repair/AAR /var/www"
  only_if { ::File.directory?('/var/tmp/Awesome-Appliance-Repair/AAR') } 
  not_if { ::File.exists?('/var/www/AAR/robots.txt') }
end

