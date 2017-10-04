#! /bin/bash -f
#
# Save generated /etc/ansible/hosts file and call setup_and_run_ansible_for_ceph.sh
#
# Do skew and pool size adjustents so that ceph is healthy.
#
source ./globaldefs.sh
./paranoia.sh $*
if [ $? != 0 ]; then
    exit -1
fi
firsthost=$1
ansiblehosts=`mktemp`
./run_remote.sh /tmp/globaldefs.sh 'x' $*
./run_remote.sh /tmp/install_ansible.sh 'x' $*
./build_ansible_hosts.sh $* > $ansiblehosts
./setup_and_run_ansible_for_ceph.sh $ansiblehosts $firsthost
./run_remote.sh /tmp/fix_skew.sh 'x' $*
octo_name=${octoname:-'wusui'}
ssh -t -A ${octo_name}@$firsthost sudo ceph osd pool set rbd pg_num 128
ssh -t -A ${octo_name}@$firsthost sudo ceph osd pool set rbd pgp_num 128
