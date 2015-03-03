#!/bin/bash

# the following lines are specific for Digital Ocean configurations
# to avoid processes halt unexpectedly

ulimit -i 16382
ulimit -n 4096
ulimit -u unlimited

if grep -Fxq "root  soft    sigpending  16382" /etc/security/limits.conf
then
    # code present, do nothing
    echo "..."
else
    echo "*     soft    sigpending  16382" >> /etc/security/limits.conf
    echo "root  soft    sigpending  16382" >> /etc/security/limits.conf
fi

if grep -Fxq "root  hard    nofile      4096" /etc/security/limits.conf
then
    # code present, do nothing
    echo "..."
else
    echo "*     hard    nofile      4096" >> /etc/security/limits.conf
    echo "root  hard    nofile      4096" >> /etc/security/limits.conf
fi

if grep -Fxq "root  hard    nproc       7881" /etc/security/limits.conf
then
    # code present, do nothing
    echo "..."
else
    echo "*     hard    nproc       7881" >> /etc/security/limits.conf
    echo "root  hard    nproc       7881" >> /etc/security/limits.conf
fi

# swap file
if grep -Fxq "/swapfile   none    swap    sw    0   0" /etc/fstab
then
    # code present, do nothing
    echo "..."
else
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab
fi

# swap tweakings
if grep -Fxq "vm.swappiness" /etc/sysctl.conf
then
    # code present, do nothing
    echo "..."
else
    echo "vm.swappiness=65" >> /etc/sysctl.conf
fi

if grep -Fxq "vm.vfs_cache_pressure" /etc/sysctl.conf
then
    # code present, do nothing
    echo "..."
else
    echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
fi
