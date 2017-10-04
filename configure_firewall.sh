#! /bin/bash -f
#
# Set firewall ports.
#
systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld
firewall-cmd --zone=public --add-port=6789/tcp
firewall-cmd --zone=public --add-port=6789/tcp --permanent
firewall-cmd --zone=public --add-port=6800-7300/tcp
firewall-cmd --zone=public --add-port=6800-7300/tcp --permanent
firewall-cmd --zone=public --add-port=7480/tcp
firewall-cmd --zone=public --add-port=7480/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp
firewall-cmd --zone=public --add-port=443/tcp --permanent
