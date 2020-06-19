#!/usr/bin/env sh
#
#

DOCKER_GEN_VERSION=$1

CPU_ARCH=$(arch)

case ${CPU_ARCH} in
    x86_64)
        DOCKER_GEN_ARCH="amd64"
        ;;
    armv7l | aarch64)
        DOCKER_GEN_ARCH="arm"
        ;;
    *)
        echo "unknown cpu arch"
        exit 1
        ;;
esac

DOCKER_GEN_TGZ="docker-gen-linux-${DOCKER_GEN_ARCH}-${DOCKER_GEN_VERSION}.tar.gz"
DOCKER_GEN_URL="https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/${DOCKER_GEN_TGZ}"

echo "installing docker-gen arch=${DOCKER_GEN_ARCH} url=${DOCKER_GEN_URL}"

# Install docker-gen
wget --quiet ${DOCKER_GEN_URL}
tar -C /usr/local/bin -xvzf ${DOCKER_GEN_TGZ}
chmod +x /usr/local/bin/docker-gen

echo "cleaning up ${DOCKER_GEN_TGZ}"
rm ${DOCKER_GEN_TGZ}
