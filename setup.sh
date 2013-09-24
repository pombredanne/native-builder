#!/bin/sh
HERE=`pwd`
mkdir -p $HERE/dist
mkdir -p $HERE/build

export CC=$HOST_TARGET-gcc
export CXX=$HOST_TARGET-g++
export CPP=$HOST_TARGET-cpp
export RANLIB=$HOST_TARGET-ranlib

function build {
  PACKAGE=$PACKAGE_NAME-$PACKAGE_VERSION
  PACKAGE_DOWNLOAD=$PACKAGE_URL/$PACKAGE.tar.gz
  echo "Building $PACKAGE"
  cd $HERE/build && \
  curl --progress-bar $PACKAGE_DOWNLOAD | tar -zox
  cd $PACKAGE && \
  ./configure --host=$HOST_TARGET && \
  make
  DESTDIR=$HERE/dist make install
  echo "Done Building $PACKAGE"
  cd $HERE
}

