#
# Cookbook Name::mongodb
# Recipe:: mountebs
#
# Copyright 2011
# mount ebs drives usng mdadm Raid 10
# must only be used where an instance has four drives attached 



mdadm "/dev/md0" do
  devices [ "/dev/sdf", "/dev/sdg","/dev/sdh","/dev/sdj" ]
  level 10
  action [ :create, :assemble ]
end

# need mke2fs here but only to be run once i.e if mounted do not do this!

execute "mke2fs" do
  command "mke2fs /dev/md0"
  action :run
  not_if do
   File.directory?("/mnt/data")
   end
end

# Need to persist array as does not  come back up after a reboot! Only need to run once
# put into seprate shell script as for some reason this doesn't work first time run  as dsl :-(

Directory "/etc/mdadm" do
   owner "root"
   group "root"
   mode "0755"
   action :create
   not_if do
   File.directory?("/mnt/data")
   end
end

file "/etc/mdadm/mdadm.conf" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end


script "persistarray" do
 interpreter "bash"
 user "root"
 cwd "/tmp"
 code <<-EOH
echo DEVICE /dev/sdf /dev/sdg /dev/sdh /dev/sdj |  tee /etc/mdadm/mdadm.conf
mdadm --detail --scan |  tee -a /etc/mdadm/mdadm.conf
echo "/dev/md0    /data    xfs    noatime,nodiratime,allocsize=512m      0       0"   |  tee -a  /etc/fstab
echo "mdadm -A --auto=md /dev/md0" |  tee -a /etc/rc.d/rc.local
echo "mount /dev/md0 /mnt/data/"   |  tee -a /etc/rc.d/rc.local
 EOH
 not_if do
   File.directory?("/mnt/data")
   end
end

Directory "/mnt/data" do
   owner "root"
   group "root"
   mode "0755"
   action :create
   not_if do
   File.directory?("/mnt/data")
   end
end


mount "/mnt/data" do
  device "/dev/md0"
  options " defaults,noatime,nodiratime"
  action [:mount]
end



