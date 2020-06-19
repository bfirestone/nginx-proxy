#!/usr/bin/env sh
#
#

CPU_ARCH=$(arch)

case ${CPU_ARCH} in
    x86_64)
        FOREGO_ARCH="amd64"
        ;;
    armv7l)
        FOREGO_ARCH="arm"
        ;;
    aarch64)
        FOREGO_ARCH="arm64"
        ;;
    *)
        echo "unknown cpu arch"
        exit 1
        ;;
esac

FOREGO_TGZ="forego-stable-linux-${FOREGO_ARCH}.tgz"
FOREGO_URL="https://bin.equinox.io/c/ekMN3bCZFUn/${FOREGO_TGZ}"

echo "installing forego arch=${FOREGO_ARCH} url=${FOREGO_URL}"

# Install Forego
wget --quiet  ${FOREGO_URL}
tar -C /usr/local/bin -zxvf ${FOREGO_TGZ}
chmod +x /usr/local/bin/forego

echo "cleaning up ${FOREGO_TGZ}"
rm ${FOREGO_TGZ}

