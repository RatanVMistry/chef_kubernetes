#
# Cookbook Name:: master
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'update'
include_recipe 'ntp'
include_recipe 'etcd'

package "kubernetes" do
        action :install
end

package "cockpit" do
        action :install
end

package "cockpit-docker" do
        action :install
end

package "cockpit-kubernetes" do
        action :install
end
template "/etc/etcd/etcd.conf" do
	source "etcd.conf.erb"
	mode "0644"
	
	notifies :restart, "service[etcd]"
end

template "/etc/kubernetes/apiserver" do
	source "apiserver.erb"
	mode "0644"
	
	notifies :restart, "service[kube-apiserver]"
end

service "kube-apiserver" do

        action [ :enable, :restart ]
end

service "kube-scheduler" do

        action [ :enable, :restart ]
end

service "kube-controller-manager" do

        action [ :enable, :restart ]
end

service "cockpit" do

        action [ :enable, :start ]
end

bash 'etcdctl' do
	user 'root'
	code <<-EOH
	if ! (etcdctl get /atomic.io/network/config) ; then
		etcdctl mk /atomic.io/network/config '{"Network":"172.17.0.0/16"}';
	fi	
	EOH
end
