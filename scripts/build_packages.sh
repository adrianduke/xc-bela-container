#!/bin/bash -e
grep 'docker\|lxc' /proc/1/cgroup > /dev/null 2>&1 || {
    echo This script should only be called in a container. Consult the README for instructions
    exit 1
}

apt-get update
apt-get install -y wget gpg apt-utils #apt-transport-https ca-certificates

echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" >> /etc/apt/sources.list.d/llvm.list
echo "deb http://http.us.debian.org/debian/ bullseye main contrib non-free" >> /etc/apt/sources.list.d/bullseye.list

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
apt-get update

apt-get install --no-install-recommends -y \
    clang \
	clangd \
	ninja-build \
	coreutils \
	linux-libc-dev-armhf-cross \
	g++-10-arm-linux-gnueabihf \
	gcc-10-arm-linux-gnueabihf \
	gcc-arm-linux-gnueabihf \
	g++-arm-linux-gnueabihf \
	binutils-arm-linux-gnueabihf \
	build-essential \
	rsync \
	ssh \
	cmake \
	git \
	gdb

rm -rf /var/lib/apt/lists/*

echo "Finishing up..."