#! /bin/bash -f
#
# Setup the prerequisites.
# Sequentially run the operations in the prerequisite
# section of the installation guide.
#
./paranoia.sh $*
if [ $? != 0 ]; then
    exit -1
fi
./run_remote.sh /tmp/globaldefs.sh 'x' $*
./run_remote.sh /tmp/adjust_pid_count.sh 'x' $*
./run_remote.sh /tmp/register_to_cdn.sh 'x' $*
./run_remote.sh /tmp/enable_ceph_repositories.sh 'x' $*
./run_remote.sh /tmp/configure_firewall.sh 'x' $*
./run_remote.sh /tmp/configure_ntp.sh 'x' $*
./run_remote.sh /tmp/create_ansible_user.sh 'ansible' $*
./fix_up_remote_ssh.sh 'ansible' $*
./finish_init.sh 'ansible' $*
