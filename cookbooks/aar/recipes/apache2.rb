package "apache2"

package "libapache2-mod-wsgi" do
  notifies :restart, "service[apache2]"
end

service "apache2" do
  action [ :start, :enable ]
end

template "/etc/apache2/sites-enabled/aar.conf" do
  source "aar.erb"
  notifies :restart, "service[apache2]"
end
