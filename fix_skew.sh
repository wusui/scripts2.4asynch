#! /bin/bash -f
#
# Fix skew errors
#
ed /etc/ceph/ceph.conf <<EOF
/mon host =
a
mon clock drift allowed = 7
.
w
q
EOF
systemctl stop ceph-mon.target
systemctl start ceph-mon.target
