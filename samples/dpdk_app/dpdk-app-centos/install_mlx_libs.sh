#!/bin/bash
set -e

OFED_VERSION="4.7-1.0.0.1"
DIST="rhel8.0"
ARCH="x86_64"
WORKDIR="/usr/src"

if [ ${MLX_STACK} == "upstream" ]; then
	echo "Installing upstream libraries"
	yum install -y libnl3 rdma-core-devel
elif [ ${MLX_STACK} == "ofed" ]; then
	echo "installing ofed libraries"
	pushd ${WORKDIR}
	yum install -y wget perl tk libnl3 numactl-libs tcl python36
	wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-${OFED_VERSION}/MLNX_OFED_LINUX-${OFED_VERSION}-${DIST}-${ARCH}.tgz
	tar xf MLNX_OFED_LINUX-${OFED_VERSION}-${DIST}-${ARCH}.tgz
	pushd ${WORKDIR}/MLNX_OFED_LINUX-${OFED_VERSION}-${DIST}-${ARCH}
    	./mlnxofedinstall  --user-space-only \
	       		   --dpdk \
			   --upstream-libs \
			   --distro ${DIST} \
			   --without-fw-update \
			    -q

	cat /tmp/MLNX_OFED_LINUX.*.logs/general.log
	popd
	popd
else
	echo "Please, set MLX_STACK to a valid value: upstream | ofed"
	exit 1
fi
