#
# Cookbook Name:: gogobot-templar
# Recipe:: default
#
# Copyright 2015, Gogobot Ltd.
#
# All rights reserved - Do Not Redistribute
#
remote_file node['templar']['download_to'] do
  source node['templar']['binary_download_location']
end

execute "untar-templar" do
  command "tar -zxvf #{node['templar']['download_to']} -C /usr/bin"
end

execute "Chmod Templar Binary" do
  command "chmod +x /usr/bin/templar"
end

template '/etc/init/templar.conf' do
  source 'templar.conf'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/init/templar-1.conf' do
  source 'templar-1.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
    redis: node['templar']['redis'],
    debug: node['templar']['debug'],
    listen: node['templar']['listen'],
    log_location: node['templar']['log_location']
  })
end

