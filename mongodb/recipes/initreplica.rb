#
# Cookbook Name::mongodb
# Recipe:: initreplica
#
# Copyright 2011
# Creates a mongo installation that uses dbase files on Raid 10
# Requires recipes in following order: mountebs, default(for installation), mongomaster, startmongodb

# run mongo script to initialise replica sets

template "/etc/chef/initreplica.js" do
  source "initreplica.js.erb"
  owner "root"
  group "root"
  mode "0644"
end 

execute "initreplica" do
  command "mongo localhost /etc/chef/initreplica.js"
  action :run
end
