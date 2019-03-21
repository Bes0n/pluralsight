#  Planning and Installing Chef
- [Planning for Chef](#planning-for-chef)
- [Installing Chef](#installing-chef)
- [Configuring the Chef Workstation](#configuring-the-chef-workstation)
- [Bootstrapping Chef Nodes](#bootstrapping-chef-nodes)

## Planning for Chef
### The Problem of Scaling Server Management

Infrastructure:
* Versionable
* Testable
* Repeatable

### Examine a Sample Chef Recipe
```ruby
package "httpd" do
    action :install
end
```

* From code we can understand that what we need and what action should be permorfed

![img](https://github.com/Bes0n/pluralsight/blob/master/chef/images/img1.JPG)

* Difference between ** Hosted Chef ** and ** Chef Server **

![img](https://github.com/Bes0n/pluralsight/blob/master/chef/images/img2.JPG)

### Sign up for Hosted Chef
Best option is visit - https://learn.chef.io/modules/try-chef#/

Get environment in Docker and playaround. 

*  First, the command is chef-run. This is a utility to run adhoc Chef commands on a remote server. It provides a good way to get started with Chef, without requiring any infrastructure beyond SSH.

* Next is the host name of the machine we are going to be configuring--web1.

* Finally we have file hello.txt. This refers to the Chef file resource and passes it the name hello.txt. This has the effect of creating a file called hello.txt on the machine. We don't need to provide any credentials because we have provisioned these test machines with SSH keys.

* Recipes:
  * If you want to configure more than a single item on your system, you will need to collect your resources together in a recipe. With a recipe, Chef will process the resources in the order they appear.
  * We have included a basic recipe for you to try. It will install a utility, FIGlet, and use it to create a file with a hello world message. Let's take a look at the file and talk through it.

```
cat recipe.rb
apt_update
```

```ruby

package 'figlet'
 
directory '/tmp'
 
execute 'write_hello_world' do
    command 'figlet Hello World! > /tmp/hello.txt'
    not_if { File.exist?('/tmp/hello.txt') }
end
```

* Cookbook container:
  * The **README.md** file gives description of the cookbook and how it should be used. While not mandatory, it is highly recommended that all cookbooks include a README.

  * The metadata.rb file is required for all cookbooks. It contains the name and version number of the cookbook and information about dependencies. 

  * **recipes** contain the recipes. You may have as many as necessary including the default recipe, **default.rb**, which is the recipe that is run if another is not specified.
  
  * **templates** directory contains templates for text files that are required by a recipe, for example for configuration files that need populated with realtime data


```ruby
#
# Cookbook:: webserver
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
apt_update
 
package 'apache2'
 
template '/var/www/html/index.html' do
  source 'index.html.erb'
end
 
service 'apache2' do
  action [:enable, :start]
end

```

![img](https://github.com/Bes0n/pluralsight/blob/master/chef/images/img3.JPG)

###### Chef Server Components

![img](https://github.com/Bes0n/pluralsight/blob/master/chef/images/img4.JPG)

## Installing Chef 
### Module Overview 

![img](https://github.com/Bes0n/pluralsight/blob/module2_InstallingChef/chef/images/img5.JPG)

### Demo: Deploy Base Environment in Azure with PowerShell

* Step 1. 
```powershell

Add-AzureAccount  #add your account
Get-AzureSubscription # check subscription status

```


 ## Configuring the Chef Workstation

 ## Bootstrapping Chef Nodes