#! /bin/bash -f
#
# Set firewall ports.
#
ostype=`lsb_release -si`
if [ $ostype == 'Ubuntu' ]; then
    hsite=`hostname -i`
    iptables -I INPUT 1 -i eno1 -p tcp -s ${hsite}/21 --dport 6789 -j ACCEPT
    iptables -I INPUT 1 -i eno1 -p tcp -s ${hsite}/21 --dport 6800:7300 -j ACCEPT
    iptables -I INPUT 1 -i eno1 -p tcp -s ${hsite}/21 --dport 7480 -j ACCEPT
    iptables -I INPUT 1 -i eno1 -p tcp -s ${hsite}/21 --dport 80 -j ACCEPT
    iptables -I INPUT 1 -i eno1 -p tcp -s ${hsite}/21 --dport 8080 -j ACCEPT
    iptables -I INPUT 1 -i eno1 -p tcp -s ${hsite}/21 --dport 443 -j ACCEPT
    apt-get install iptables-persistent -y
else
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
fi
