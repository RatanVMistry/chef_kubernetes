#
# Cookbook Name:: master
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'update'
package "kubernetes" do
	action :install
end
