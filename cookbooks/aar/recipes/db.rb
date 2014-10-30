# initialize and deal with the database

include_recipe "database::mysql"

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

cookbook_file "#{ Chef::Config[:file_cache_path] }/make_AARdb.sql" do
  source "make_AARdb.sql"
end


mysql_database 'run script' do
  connection mysql_connection_info
  sql { ::File.open("#{ Chef::Config[:file_cache_path] }/make_AARdb.sql").read }
  action :query
  notifies :create, "ruby_block[db_is_ready]", :immediately
  not_if { node.attribute?('aar.db_is_ready') }
end

ruby_block "db_is_ready" do
  block do
    node.set['aar']['db_is_ready'] = true
    node.save
  end
  action :nothing
end
