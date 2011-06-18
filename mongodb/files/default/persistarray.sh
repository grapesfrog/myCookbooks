#!/bin/sh
# To persist array after a reboot
# T be run after Array creation and to be run once only 
echo DEVICE /dev/sdf /dev/sdg /dev/sdh /dev/sdj |  tee /etc/mdadm/mdadm.conf
mdadm --detail --scan |  tee -a /etc/mdadm/mdadm.conf
echo "/dev/md0    /data    xfs    noatime,nodiratime,allocsize=512m      0       0"   |  tee -a  /etc/fstab
echo "mdadm -A --auto=md /dev/md0" |  tee -a /etc/rc.d/rc.local
echo "mount /dev/md0 /data/"   |  tee -a /etc/rc.d/rc.local
