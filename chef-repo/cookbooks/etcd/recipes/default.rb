#
# Cookbook Name:: etcd
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'update'
package "etcd" do
	action :install
end
service "etcd" do
	
	action [ :start, :enable ]
end
