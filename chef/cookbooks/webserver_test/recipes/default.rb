#
# Cookbook:: webserver_test
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

package 'httpd' do
    action :install
end

service 'httpd' do
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  owner 'root'
  mode '0755'
  action :create
end
