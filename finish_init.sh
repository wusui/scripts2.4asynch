#! /bin/bash -f
#
# Last step of prerequisites.  Create ssh/config file.
#
source ./globaldefs.sh
octo_name=${octoname:-'wusui'}
user=$1
shift
firsthost=$1
cnt=0
temp_fname=`mktemp`
for i in $*; do
    cnt=$(expr $cnt + 1)
    echo "Host node${cnt}" >> ${temp_fname}
    echo "    Hostname $i" >> ${temp_fname}
    echo "    User ${user}" >> ${temp_fname}
done
scp ${temp_fname} ${octo_name}@${firsthost}:${temp_fname}
ssh -t -A ${octo_name}@${firsthost} sudo cp ${temp_fname} ~${user}/.ssh/config
ssh -t -A ${octo_name}@${firsthost} sudo chown ${user} ~${user}/.ssh/config
ssh -t -A ${octo_name}@${firsthost} sudo chgrp ${user} ~${user}/.ssh/config
ssh -t -A ${octo_name}@${firsthost} sudo chmod 0600 ~${user}/.ssh/config
ssh -t -A ${octo_name}@${firsthost} sudo rm -fr ${temp_fname}
rm -fr ${temp_fname}
