#! /bin/bash -f
#
# make sure we are not clobbering a machine that we are not
# supposed to clobber. Acceptable machines are those that
# we have locked using teuthology, and machines listed in
# the file that the goodmachines variables points to.
#
# This script is called by all scripts which are expected
# to be run directly by the user.
#
# While we are at it, this also checks the global subscription
# variables which must be set.
#
source ./globaldefs.sh
lockedmac=`mktemp`
testmac=`mktemp`
teuthology-lock --brief | sed 's/.ceph.*//' > ${lockedmac}
morev=
if [ -n $goodmachines ]; then
    if [ -e $goodmachines ]; then
        morev=$goodmachines
    fi
fi
rm -fr ${testmac}
if [ -n $morev ]; then
    cat ${lockedmac} $morev > ${testmac}
else
    mv ${lockedmac} ${testmac}
fi
readarray machinesav < ${testmac}
exitc=64
for i in $*; do
    for j in ${machinesav[*]}; do
        if [ "$i" == "$j" ]; then
            exitc=0
        fi
    done
    if [ $exitc != 0 ]; then
        echo "${i} could be a machine we should not use"
        exit 64
    fi
    exitc=64
done
rm -rf ${lockedmac} ${testmac}
if [ -z "${subscrname}" ]; then
    echo "subscrname is not defined"
    exit 64
fi
if [ -z "${subscrpassword}" ]; then
    echo "subscrpassword is not defined"
    exit 64
fi
