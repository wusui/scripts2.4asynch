#! /bin/bash -f
# 
# Setup the files necessary to run ceph-ansible and bring
# up a ceph cluster with just mons and osds running.
#
source /tmp/globaldefs.sh
cd ~
mkdir ceph-ansible-keys
ln -s /usr/share/ceph-ansible/group_vars /etc/ansible/group_vars
cd /etc/ansible/group_vars
cp all.yml.sample all.yml
sed -i 's,^#fetch_directory:.*,fetch_directory: ~/ceph-ansible-keys,' all.yml
if [ -n ${usethisdistro} ]; then
    ed all.yml <<EOF
/^#ceph_stable:
i
ceph_stable: true
ceph_stable_rh_storage: true
ceph_origin: distro
.
w
q
EOF
else
sed -i 's/^#ceph_rhcs:.*/ceph_rhcs: true/' all.yml
sed -i 's/^#ceph_rhcs_cdn_install:.*/ceph_rhcs_cdn_install: true/' all.yml
fi
newfsid=`uuidgen`
monintf=`ifconfig | head -1 | sed -e 's/ .*//' | sed -e 's/://'`
sed -i 's/^#journal_size:/journal_size:/' all.yml
sed -i 's/# OSD journal size in MB//' all.yml
sed -i 's/^#cephx:/cephx:/' all.yml
sed -i 's,^#public_network:.*,public_network: 10.8.128.0/21,' all.yml
sed -i 's,^#cluster_network:.*,cluster_network: 10.8.128.0/21,' all.yml
sed -i 's,^#generate_fsid:.*,generate_fsid: true,' all.yml
sed -i "s,^#fsid:.*,fsid: ${newfsid}," all.yml
sed -i "s,^#monitor_interface:.*,monitor_interface: ${monintf}," all.yml
cp mons.yml.sample mons.yml
cp osds.yml.sample osds.yml
sed -i "s/^#journal_collocation:.*/journal_collocation: true/" osds.yml
cd /usr/share/ceph-ansible
ed ansible.cfg <<EOF
/log_path =
o
retry_files_save_path = ~/
.
w
q
EOF
cp site.yml.sample site.yml
ansible-playbook site.yml
