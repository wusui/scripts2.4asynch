#! /bin/bash -f
#
# Locally create an /etc/ansible/hosts file for implementing mons and osds.
#
echo '[mons]'
for i in $*; do
    echo ${i}
done
echo
echo '[osds]'
for i in $*; do
    echo "$i devices=\"[ '/dev/sdb', '/dev/sdc', '/dev/sdd' ]\""
done
echo

