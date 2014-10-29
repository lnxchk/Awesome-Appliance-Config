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

