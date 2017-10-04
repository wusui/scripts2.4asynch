#!/bin/bash -f
#
# Adjust the kernel pid (the first step in the prerequsites section)
#
if grep -q "kernel.pid_max" /etc/sysctl.conf; then
    sed -i -e 's/kernel.pid_max.*/kernel.pid_max = 4194303/' /etc/sysctl.conf
else
    echo "kernel.pid_max = 4194303" >> /etc/sysctl.conf
fi 
sysctl -p
sysctl -a | grep kernel.pid_max
