#! /bin/bash -f
#
# Create a user on each site.
#
useradd ${1}
passwd ${1} << EOF
${1}
${1}
EOF
cat << EOF >/etc/sudoers.d/${1}
${1} ALL = (root) NOPASSWD:ALL
EOF
chmod 0440 /etc/sudoers.d/${1}
