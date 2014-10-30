#
# Cookbook Name:: aar
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#

# create the DocumentRoot for the webserver
directory node['aar']['document_root'] do
  action :create
  recursive true
end

include_recipe 'aar::httpd'
include_recipe 'aar::aar'
include_recipe 'aar::db'
