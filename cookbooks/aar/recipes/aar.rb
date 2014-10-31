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
cookbook_file "#{ Chef::Config[:file_cache_path] }/aar_pages.tar" do
  source "aar_pages.tar"
end

bash "deploy_pages" do
  cwd "/var/www/"
  code <<-EOH
    tar xf #{ Chef::Config[:file_cache_path] }/aar_pages.tar
  EOH
  not_if { ::File.exists?("/var/www/AAR/awesomeapp.py") }
end
