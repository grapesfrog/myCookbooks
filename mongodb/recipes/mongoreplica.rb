#
# Cookbook Name::mongodb
# Recipe:: mongoreplica
#
# Copyright 2011
# Creates a mongo installation that uses dbase files on Raid 10
# Requires recipes in following order: mountebs, default(for installation), mongoreplica, startmongodb

# create folders where production mongodb files will go and only if mount point exists

Directory "/mnt/data/mongo" do
   owner "mongod"
   group "mongod"
   mode "0755"
   action :create
   only_if do
   File.directory?("/mnt/data")
   end
end

 # replace default conf file 
 
template "/etc/mongod.conf" do
  source "mongod.conf.erb"
  variables( :port => "27017" )
  owner "root"
  group "root"
  mode "0644"
end 