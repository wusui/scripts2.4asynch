#! /bin/bash -f
#
# Run the host file on the site specified.
#
source ./globaldefs.sh
new_host_file=${1}
shift
run_ansible_on=${1}
shift
octo_name=${octoname:-'wusui'}
scp $new_host_file $octo_name@${run_ansible_on}:/tmp
ssh -t -A ${octo_name}@$run_ansible_on sudo cp $new_host_file /etc/ansible/hosts
scp ./ansible_ceph_deploy.sh ${octo_name}@$run_ansible_on:/tmp
ssh -t -A ${octo_name}@$run_ansible_on sudo /tmp/ansible_ceph_deploy.sh
