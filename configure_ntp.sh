#! /bin/bash -f
#
# make sure the ntp daemon is running on each site.
#
ostype=`lsb_release -si`
if [ $ostype == 'Ubuntu' ]; then
   lcmd='apt-get'
else
   lcmd='yum'
fi
${lcmd} install ntp -y
systemctl enable ntpd
systemctl start ntpd
systemctl status ntpd
ntpq -p
