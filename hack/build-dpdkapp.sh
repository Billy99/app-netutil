# Run below cmd in the root dir of app-netutil repo
pushd ./samples/dpdk_app/dpdk-app-centos/
docker build --build-arg MLX_STACK="${MLX_STACK}" --rm -t dpdk-app-centos .
popd
