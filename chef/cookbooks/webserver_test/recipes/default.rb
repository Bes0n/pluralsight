#
# Cookbook:: webserver_test
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

package_name =
  service_name =
    case node['platform']
    when 'centos' then 'httpd'
    when 'ubuntu' then 'apache2'
    end

# Install the package.
package package_name

# Start and enable the service.
service service_name do
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  owner 'root'
  mode '0755'
  action :create
end
