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
service "kube-apiserver" do

        action [ :enable, :start ]
end

service "kube-scheduler" do

        action [ :enable, :start ]
end

service "kube-controller-manager" do

        action [ :enable, :start ]
end

service "cockpit" do

        action [ :enable, :start ]
end
