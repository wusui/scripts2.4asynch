#! /bin/bash -f
#
# Called by user.  This is a wrapper for the remote code that will
# use set up the client and rgw sites.
#
source ./globaldefs.sh
./paranoia.sh $*
rgw_host=${1}
octo_name=${octoname:-'wusui'}
scp ./ansible_client_rgw.sh ${octo_name}@$rgw_host:/tmp
ssh -t -A ${octo_name}@$rgw_host sudo /tmp/ansible_client_rgw.sh $*
