#
# Cookbook Name:: minion
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'update'
include_recipe 'ntp'

package "flannel" do
        action :install
end

package "kubernetes" do
        action :install
end

master = search(:node, 'role:"master"')
host_ip = node[:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first


template "/etc/sysconfig/flanneld" do
	source "flanneld.erb"
	mode "0644"
	variables(
        	:master => master
    	)
	#notifies :restart, "service[flanneld]"
end

template "/etc/kubernetes/config" do
        source "config.erb"
        mode "0644"
	variables(
                :master => master
        )
        #notifies :restart, "service[kube-proxy]"
	#notifies :restart, "service[kubelet]"
	#notifies :restart, "service[docker]"
end 

template "/etc/kubernetes/kubelet" do
        source "kubelet.erb"
        mode "0644"
	variables(
                :master => master ,
		:host_ip => host_ip
        )
        #notifies :restart, "service[kube-proxy]"
        #notifies :restart, "service[kubelet]"
        #notifies :restart, "service[docker]"
end 

service "kube-proxy" do

        action [ :enable, :restart ]
end

service "kubelet" do

        action [ :enable, :restart ]
end

service "docker" do

        action [ :enable, :restart ]
end

service "flanneld" do

        action [ :enable, :restart ]
end
