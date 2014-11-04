# initialize and deal with the database

include_recipe "database::mysql"

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

sql_file = "#{ Chef::Config[:file_cache_path] }/make_AARdb.sql"

cookbook_file sql_file do
  source "make_AARdb.sql"
end

mysql_database "AARdb" do
  connection  mysql_connection_info
  action :create
end

# create the AARdb schema
mysql_database 'do_the_thing' do
  database_name "AARdb"
  connection mysql_connection_info
  sql { ::File.open(sql_file).read }
  action :query
  notifies :create, "ruby_block[db_is_ready]", :immediately
  not_if { node.attribute?('aar_db_is_ready') }
end

ruby_block "db_is_ready" do
  block do
    node.set['aar_db_is_ready'] = true
    node.save
  end
  action :nothing
end

# add the app's db user
mysql_database_user 'aarapp' do
  database_name "AARdb"
  connection mysql_connection_info
  password node['aar']['db_passwd']
  privileges [:create, :insert, :delete, :update, :select]
  action [:create, :grant]
end


