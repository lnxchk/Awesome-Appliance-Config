# install the python bits of the AAR dependencies
# python and pip are installed from the python cookbook
#

case node['platform_family']
when 'rhel'
  python_pip 'flask' do
    notifies :restart, "httpd_service[aar]"
  end
when 'debian'
  python_pip 'flask' do
    notifies :restart, "service[apache2]"
  end
end

package node['aar']['py_mysql']
