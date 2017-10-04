#! /bin/bash -f
#
# Install ceph-ansible
#
subscr=`subscription-manager repos --list | grep -i enabled | grep 1 | wc -l`
if [ $subscr -eq 0 ]; then
    subscription-manager repos --enable=rhel-7-server-rpms
fi
yum install ceph-ansible -y
if [ $subscr -eq 0 ]; then
    subscription-manager repos --disable='*'
fi
