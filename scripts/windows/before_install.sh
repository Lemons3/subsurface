#!/bin/bash

# prep things so we can cross-build for Windows using MXE
sudo apt-get update

echo "deb http://pkg.mxe.cc/repos/apt/debian wheezy main" \
    | sudo tee /etc/apt/sources.list.d/mxeapt.list
sudo apt-key adv --keyserver x-hkp://keys.gnupg.net \
    --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB

sudo apt-get update

sudo apt-get --yes install upx-ucl mxe-i686-w64-mingw32.shared-qt mxe-i686-w64-mingw32.shared-nsis

cd ${TRAVIS_BUILD_DIR}/..
ln -s /usr/lib/mxe .

# somehow we aren't finding the Qt configuration (which is outdated - 5.8.0)
find /usr/lib/mxe

exit 1

# now set up our other dependencies

CURRENT_LIBZIP="1.2.0"
CURRENT_HIDAPI="hidapi-0.7.0"
CURRENT_LIBCURL="curl-7_54_1"
CURRENT_LIBUSB="v1.0.21"
CURRENT_OPENSSL="OpenSSL_1_1_0f"
CURRENT_LIBSSH2="libssh2-1.8.0"
CURRENT_LIBGIT2="v0.26.0"


echo "Get libdivecomputer"
cd ${TRAVIS_BUILD_DIR}/..
git clone -b Subsurface-branch https://github.com/Subsurface-divelog/libdc.git libdivecomputer

echo "Get libcurl"
cd ${TRAVIS_BUILD_DIR}/..
git clone https://github.com/curl/curl libcurl
cd libcurl
if ! git checkout $CURRENT_LIBCURL ; then
	echo "Can't find the right tag in libcurl - giving up"
	exit 1
fi

echo "Get libusb"
cd ${TRAVIS_BUILD_DIR}/..
git clone https://github.com/libusb/libusb
cd libusb
if ! git checkout $CURRENT_LIBUSB ; then
	echo "Can't find the right tag in libusb - giving up"
	exit 1
fi

echo "Get openssl"
cd ${TRAVIS_BUILD_DIR}/..
git clone https://github.com/openssl/openssl
cd openssl
if ! git checkout $CURRENT_OPENSSL ; then
	echo "Can't find the right tag in openssl - giving up"
	exit 1
fi

echo "Get libgit2"
cd ${TRAVIS_BUILD_DIR}/..
git clone https://github.com/libgit2/libgit2.git
cd libgit2
if ! git checkout $CURRENT_LIBGIT2 ; then
	echo "Can't find the right tag in libgit2 - giving up"
	exit 1
fi

echo "Get googlemaps"
cd ${TRAVIS_BUILD_DIR}/..
git clone https://github.com/Subsurface-divelog/googlemaps.git

echo "Get Grantlee"
cd ${TRAVIS_BUILD_DIR}/..
git clone https://github.com/steveire/grantlee.git
cd grantlee
if ! git checkout v5.0.0 ; then
	echo "can't check out v5.0.0 of grantlee -- giving up"
	exit 1
fi

