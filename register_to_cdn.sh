#! /bin/bash -f
#
# Set up the subscription manager and default repos as described
# in the installation guide.  Do not enable a new server if we want
# to preserve this rhel version (not upgrade to the lateest)
#
source /tmp/globaldefs.sh
subscription-manager register --username=${subscrname} --password=${subscrpassword} --force
subscription-manager refresh
subscription-manager attach --pool=8a85f9823e3d5e43013e3ddd4e2a0977
subscription-manager repos --disable='*'
if [ -z $useanotherrhelversion ]; then
    subscription-manager repos --enable=rhel-7-server-rpms
    yum -y update
fi
