httpd_service 'aar' do
  action :create
end

httpd_config 'aar' do
  source 'aar.erb'
  instance 'aar'
  action :create
  notifies :restart, 'httpd_service[aar]'
end

