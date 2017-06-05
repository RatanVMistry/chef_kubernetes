#
# Cookbook Name:: update
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "update" do
	case node[:platform]
	when 'redhat', 'centos'
		command "yum update"
	when 'ubuntu', 'debian'
		command "apt-get update"
	 end	
end
