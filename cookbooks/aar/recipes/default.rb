#
# Cookbook Name:: aar
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#

# database skeleton
include_recipe 'aar::db'
# python requirements and flask
include_recipe 'aar::python'

# webserver skeleton
case node['platform_family']
when 'rhel'
  include_recipe 'aar::httpd'
when 'debian'
  include_recipe 'aar::apache2'
end

# aar code
include_recipe 'aar::aar'

