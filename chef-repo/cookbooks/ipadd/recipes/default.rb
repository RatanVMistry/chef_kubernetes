#
# Cookbook Name:: ipadd
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
host_ip = node[:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first
#host_ip = ip.gsub /\.\d+$/, '.1'

template "/tmp/ipadd" do
	source "ipadd.erb"
	mode "0644"
	variables(
        	:host_ip => host_ip
    	)
end


