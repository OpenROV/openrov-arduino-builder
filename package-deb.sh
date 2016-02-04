#!/bin/bash
set -ex

#Install Pre-req
gem install fpm
export DIR=${PWD}
export PACKAGE="openrov-arduino-builder"


ARCH=`uname -m`
if [ ${ARCH} = "armv7l" ]
then
  ARCH="armhf"
fi

./build.sh

export PACKAGE_VERSION=1.0.0-1~${BUILD_NUMBER}

#package
cd $DIR

fpm -f -m info@openrov.com -s dir -t deb -a $ARCH \
	-n ${PACKAGE} \
	-v ${PACKAGE_VERSION} \
	--description "Command line build tool for Arduino sketches" \
	-C ${DIR}/output ./
