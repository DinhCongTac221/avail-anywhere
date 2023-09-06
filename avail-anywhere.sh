#!/bin/bash

# Step 1: Install necessary packages
for pkg in proot-distro; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        pkg install $pkg -y
    fi
done

# Step 2: Install Ubuntu
if [ ! -d "/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu" ]; then
    proot-distro install ubuntu
fi

# Step 3: Login to the Ubuntu container and execute the commands
proot-distro login ubuntu -- bash -c '
    curl -LO https://github.com/availproject/avail-light/releases/download/v1.6.0-rc1/avail-light-linux-aarch64.tar.gz && 
    tar -xf avail-light-linux-aarch64.tar.gz && 
    curl -LO https://raw.githubusercontent.com/availproject/availproject.github.io/main/static/kate/avail-light-1.4.3/config.yaml && 
    ./avail-light-linux-aarch64 --config config.yaml'
