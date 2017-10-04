#! /bin/bash -f
#
# Enable the ceph distros, if appropriate.
#
source /tmp/globaldefs.sh
yum-config-manager --disable epel
if [ -n $usethisdistro ]; then
    subscription-manager repos --enable=rhel-7-server-rhceph-2-mon-rpms
    subscription-manager repos --enable=rhel-7-server-rhceph-2-osd-rpms
    subscription-manager repos --enable=rhel-7-server-rhceph-2-tools-rpms
    subscription-manager repos --enable=rhel-7-server-rhscon-2-installer-rpms
fi
