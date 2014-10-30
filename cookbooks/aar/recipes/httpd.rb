httpd_config 'aar' do
  source 'aar.erb'
  instance 'aar'
  action :create
  notifies :restart, 'httpd_service[aar]'
end

httpd_service 'aar' do
  action :create
  modules ["wsgi", "log_config"]
end
