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
case node['platform_family']
when 'rhel'
  cookbook_file "#{ Chef::Config[:file_cache_path] }/aar_pages-1.0-1.x86_64.rpm" do
    source "aar_pages-1.0-1.x86_64.rpm"
  end

  package "aar_pages" do
    source "#{ Chef::Config[:file_cache_path] }/aar_pages-1.0-1.x86_64.rpm" 
    provider Chef::Provider::Package::Rpm
  end
when 'debian'
  cookbook_file "#{ Chef::Config[:file_cache_path] }/aar_pages_1.0_amd64.deb" do
    source "aar_pages_1.0_amd64.deb"
  end

  bash "install_the_thing" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      dpkg -i aar_pages_1.0_amd64.deb 
    EOH
    not_if { ::File.exists?("/var/www/AAR/robots.txt") }
  end
end

