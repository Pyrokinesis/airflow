#
# Cookbook Name:: ring-java
# Recipe:: default
#
# Copyright 2017, ring.com
#
# All rights reserved - Do Not Redistribute
#

# Add Java PPA
apt_repository 'webupd8team' do
  uri 'ppa:webupd8team/java'
  distribution node['lsb']['codename']
end

execute 'accept-license' do
  command 'echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'
end

%w(oracle-java8-installer oracle-java8-set-default).each do |pkg|
  package pkg
end
