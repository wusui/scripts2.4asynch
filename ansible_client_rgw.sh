#! /bin/bash -f
#
# Do the ansible installs of the client and rgw nodes.
#
source /tmp/globaldefs.sh
for i in $*; do
    ssh $i pip install boto
done
node_files=`mktemp`
touch $node_files
echo '[clients]' >> $node_files
for i in $*; do
    echo $i >> $node_files
done
echo >> $node_files
cat $node_files >> /etc/ansible/hosts
rm -rf ${node_files}
cd /usr/share/ceph-ansible/group_vars
cp clients.yml.sample clients.yml
cd ..
ansible-playbook site.yml
node_files=`mktemp`
touch $node_files
echo '[rgws]' >> $node_files
for i in $*; do
    echo $i >> $node_files
done
echo >> $node_files
cat $node_files >> /etc/ansible/hosts
rm -rf ${node_files}
cd /usr/share/ceph-ansible/group_vars
cp rgws.yml.sample rgws.yml
sed -i 's/^#copy_admin_key:.*/copy_admin_key: true/' rgws.yml
sed -i 's/^#ceph_rgw_civetweb_port:.*/ceph_rgw_civetweb_port: 80/' rgws.yml
cd ..
ansible-playbook site.yml
systemctl stop ceph-radosgw@rgw.`hostname -s`
systemctl start ceph-radosgw@rgw.`hostname -s`
