#! /bin/bash -f
#
# make sure the ntp daemon is running on each site.
#
yum install ntp -y
systemctl enable ntpd
systemctl start ntpd
systemctl status ntpd
ntpq -p
