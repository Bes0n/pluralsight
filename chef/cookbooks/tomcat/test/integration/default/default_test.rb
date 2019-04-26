# # encoding: utf-8

# Inspec test for recipe tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe user('tomcat') do
  it { should exist }
  its('uid') { should eq 1001 }
  its('group') { should eq 'tomcat' }
  its('home') { should eq '/home/tomcat' }
  its('shell') { should eq '/bin/bash' }
end

describe file('/tmp/apache-tomcat-9.0.19.tar.gz') do
  it { should exist }
end

describe port(8080) do
  it { should be_listening }
end