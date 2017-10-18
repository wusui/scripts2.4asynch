#! /bin/bash -f
#
# make all the online repos available.  Worry about which one gets used later.
#
source /tmp/globaldefs.sh
umask 0077
echo deb ${onlinerepoloc}MON $(lsb_release -sc) main | tee /etc/apt/sources.list.d/MON.list
wget -O - ${onlinerepoloc}MON/release.asc | apt-key add -
apt-get update
echo deb ${onlinerepoloc}OSD $(lsb_release -sc) main | tee /etc/apt/sources.list.d/OSD.list
wget -O - ${onlinerepoloc}OSD/release.asc | apt-key add -
apt-get update
echo deb ${onlinerepoloc}Tools $(lsb_release -sc) main | tee /etc/apt/sources.list.d/Tools.list
wget -O - ${onlinerepoloc}Tools/release.asc | apt-key add -
apt-get update
