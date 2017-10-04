#! /bin/bash -f
#
# Wrapper to set up the running of sanity checks on a site.
#
source ./globaldefs.sh
./paranoia.sh $*
rgw_host=${1}
octo_name=${octoname:-'wusui'}
scp ./rgw_sanity_test.sh ${octo_name}@$rgw_host:/tmp
scp ./bucket_test.py ${octo_name}@$rgw_host:/tmp
scp ./get_connection.py ${octo_name}@$rgw_host:/tmp
ssh -t -A ${octo_name}@$rgw_host sudo /tmp/rgw_sanity_test.sh 
