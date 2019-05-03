require 'spec_helper'

shared_examples 'webserver_test' do |platform, version, package, service|
  context "when run on #{platform} #{version}" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: platform, version: version)
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "installs #{package}" do
      expect(chef_run).to install_package package
    end

    it "enables the #{service} service" do
      expect(chef_run).to enable_service service
    end

    it "starts the #{service} service" do
      expect(chef_run).to start_service service
    end
  end
end

describe 'webserver_test::default' do
  platforms = {
    'centos' => ['7.3.1611', 'httpd', 'httpd'],
    'ubuntu' => ['14.04', 'apache2', 'apache2']
  }

  platforms.each do |platform, platform_data|
    include_examples 'webserver_test', platform, *platform_data
  end
end