default['aar']['document_root'] = "/var/www/AAR"
case node['platform_family'] 
when 'rhel'
  default['aar']['system_user'] = "apache"
  default['aar']['system_group'] = "apache"
  default['aar']['webserverd'] = "aar"
  default['aar']['py_mysql'] = "MySQL-python"
  default['aar']['log_dir'] = "/etc/httpd-aar/logs"
when 'debian'
  default['aar']['system_user'] = "www-data"
  default['aar']['system_group'] = "www-data"
  default['aar']['webserverd'] = "apache2"
  default['aar']['py_mysql'] = "python-mysqldb"
  default['aar']['log_dir'] = "/var/log/apache2"
end

default['aar']['num_threads'] = 5

