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
source ./globaldefs.sh
./run_remote.sh /tmp/globaldefs.sh 'x' $*
./run_remote.sh /tmp/adjust_pid_count.sh 'x' $*
ostype=`ssh $1 lsb_release -si`
if [ "$ostype" == "RedHatEnterpriseServer" ]; then
    ./run_remote.sh /tmp/register_to_cdn.sh 'x' $*
    ./run_remote.sh /tmp/enable_ceph_repositories.sh 'x' $*
else
    if [ -z $onlinerepoloc ]; then
        echo 'on line repo needs to be defined'
        exit -1
    else
        ./run_remote.sh /tmp/enable_online_repos.sh "$onlinerepoloc" $*
    fi
fi
./run_remote.sh /tmp/configure_firewall.sh 'x' $*
./run_remote.sh /tmp/configure_ntp.sh 'x' $*
ansible_site=${ansiblesite:-${firsthost}}
if [ $ansible_site != $firsthost ]; then
    ./run_remote.sh /tmp/create_ansible_user.sh 'ansible' $ansible_site $*
    ./fix_up_remote_ssh.sh 'ansible' $ansible_site $*
    ./finish_init.sh 'ansible' $ansible_site $*
else
    ./run_remote.sh /tmp/create_ansible_user.sh 'ansible' $*
    ./fix_up_remote_ssh.sh 'ansible' $*
    ./finish_init.sh 'ansible' $*
fi
