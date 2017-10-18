#! /bin/bash -f
#
# Install ceph-ansible
#
subscription-manager repos --enable=rhel-7-server-rhscon-2-installer-rpms
yum install ceph-ansible -y
