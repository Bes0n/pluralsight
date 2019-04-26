#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Step 1 - Java Installation

apt_update 'all platforms' do
    ignore_failure true
    action :periodic
end

package 'default-jdk' do
    action :install
end


# Step 2 – Download & Install Tomcat 9

remote_file '/tmp/apache-tomcat-9.0.19.tar.gz' do
    source 'http://mirror.dkm.cz/apache/tomcat/tomcat-9/v9.0.19/bin/apache-tomcat-9.0.19.tar.gz'
    mode '0755'
    action :create
end

execute 'extract_tar' do
    command 'tar xzf /tmp/apache-tomcat-9*.tar.gz -C tmp/'
    action :run
end

execute 'move_folder' do
    command 'sudo mv /tmp/apache-tomcat-9.0.19 /usr/local/apache-tomcat9'
    not_if { ::File.exists?('/usr/local/apache-tomcat9')}
    action :run
end


# Step 2 – Create User Accounts and Group

user 'tomcat' do
    home '/home/tomcat'
    shell '/bin/bash'
    password 'P@ssw0rd1'
    manage_home true
end

user 'admin' do
    home '/home/admin'
    shell '/bin/bash'
    password 'P@ssw0rd1'
end

user 'manager' do
    home '/home/manager'
    shell '/bin/bash'
    password 'P@ssw0rd1'
end

group 'tomcat' do
    group_name 'tomcat'
    append true
    members ['tomcat','admin','manager']
end


# Step 4 – Configure Environment Variables

template "/home/tomcat/.bashrc" do
    source "bashrc.erb"
    owner "tomcat"
    group "tomcat"
end


# Step 5 – Setup Tomcat User Accounts

template '/usr/local/apache-tomcat9/conf/tomcat-users.xml' do
    source 'tomcat-users.xml.erb'
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
  end

# Step 6 – Enable Host/Manager for Remote IP

template '/usr/local/apache-tomcat9/webapps/host-manager/META-INF/context.xml' do
    source 'context.xml.erb'
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
    variables(
        ip_address: '10.22.100.121'
    )
end

template '/usr/local/apache-tomcat9/webapps/manager/META-INF/context.xml' do
    source 'context.xml.erb'
    owner 'tomcat'
    group 'tomcat'
    mode '0755'
    variables(
        ip_address: '10.22.100.121'
    )
end

# Step 7 – Starting Tomcat Service

execute 'start_apache' do
    command './usr/local/apache-tomcat9/bin/startup.sh'
    action :run
    live_stream true
end