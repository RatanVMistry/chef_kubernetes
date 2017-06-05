#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'update'
package "ntp" do
	action :install
end
service "ntpd" do
	
	action [ :start, :enable ]
end
