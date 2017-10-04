#! /bin/bash -f
#
# Make sure passwordless ssh works between the first site
# and all other sites.  This should work for root, the ansible
# user, and the user that is running on the remote site.
#
source ./globaldefs.sh
octo_name=${octoname:-'${octo_name}'}
tophost=`hostname -s`
user=$1
shift
firsthost=$1
ssh-keygen -f id_rsa <<EOF





EOF
temp_id_rsa=`mktemp`
temp_id_rsapub=`mktemp`
temp_authset=`mktemp`
temp_auth=`mktemp`
for i in $*; do
    scp id_rsa ${octo_name}@${i}:${temp_id_rsa}
    scp id_rsa.pub ${octo_name}@${i}:${temp_id_rsapub}
    ssh ${octo_name}@${i} sudo mkdir ~${user}/.ssh
    ssh ${octo_name}@${i} sudo cp ${temp_id_rsa} ~${user}/.ssh/id_rsa
    ssh ${octo_name}@${i} sudo cp ${temp_id_rsapub} ~${user}/.ssh/id_rsa.pub
    ssh ${octo_name}@${i} sudo sed -i "s:${octo_name}@${tophost}:${user}@${i}:" ~${user}/.ssh/id_rsa.pub
    ssh ${octo_name}@${i} sudo chmod 0700 ~${user}/.ssh 
    ssh ${octo_name}@${i} sudo chmod 0600 ~${user}/.ssh/id_rsa 
    ssh ${octo_name}@${i} sudo chmod 0600 ~${user}/.ssh/id_rsa.pub 
    ssh ${octo_name}@${i} sudo chown ${user}:${user} ~${user}/.ssh
    ssh ${octo_name}@${i} sudo chown ${user}:${user} ~${user}/.ssh/id_rsa
    ssh ${octo_name}@${i} sudo chown ${user}:${user} ~${user}/.ssh/id_rsa.pub
done
rm -fr id_rsa id_rsa.pub
grep "${octo_name}@ubuntu" /home/${octo_name}/.ssh/authorized_keys > ${temp_auth}
scp ${temp_auth} ${octo_name}@${firsthost}:${temp_auth}
for i in $*; do
    scp ./do_keygen.sh ${octo_name}@${i}:/tmp/do_keygen.sh
    ssh ${octo_name}@${i} sudo /tmp/do_keygen.sh
done
ssh ${octo_name}@${firsthost} sudo cat /root/.ssh/id_rsa.pub ~${user}/.ssh/id_rsa.pub ${temp_auth} > ${temp_authset}
for i in $*; do
    scp ${temp_authset} ${octo_name}@${i}:${temp_authset}
    ssh ${octo_name}@${i} sudo cp ${temp_authset} /root/.ssh/authorized_keys
    ssh ${octo_name}@${i} sudo cp ${temp_authset} ~${user}/.ssh/authorized_keys
    ssh ${octo_name}@${i} sudo chmod 0600 /root/.ssh/authorized_keys
    ssh ${octo_name}@${i} sudo chmod 0600 ~${user}/.ssh/authorized_keys
    ssh ${octo_name}@${i} sudo chown ${user}:${user} ~${user}/.ssh/authorized_keys
    ssh ${octo_name}@${i} sudo chown root:root /root/.ssh/authorized_keys
    ssh ${octo_name}@${i} rm -fr ${temp_authset}
done
rm -fr ${temp_authset} ${temp_auth} ${temp_id_rsa} ${temp_id_rsapub}
