#!/bin/sh
HERE=`pwd`
mkdir -p $HERE/dist
mkdir -p $HERE/build

export CC=$HOST_TARGET-gcc
export CXX=$HOST_TARGET-g++
export CPP=$HOST_TARGET-cpp
export RANLIB=$HOST_TARGET-ranlib

# use a --host target
function build {
  PACKAGE=$PACKAGE_NAME-$PACKAGE_VERSION
  PACKAGE_DOWNLOAD=$PACKAGE_URL/$PACKAGE.tar.gz
  echo "Building $PACKAGE from $PACKAGE_DOWNLOAD"
  cd $HERE/build
  curl --progress-bar $PACKAGE_DOWNLOAD | tar -zox
  cd $PACKAGE
  ./configure --host=$HOST_TARGET
  make
  DESTDIR=$HERE/dist make install
  echo "Done Building $PACKAGE"
  cd $HERE
}

# do not use a --host target
function build2 {
  PACKAGE=$PACKAGE_NAME-$PACKAGE_VERSION
  PACKAGE_DOWNLOAD=$PACKAGE_URL/$PACKAGE.tar.gz
  echo "Building $PACKAGE from $PACKAGE_DOWNLOAD"
  cd $HERE/build
  curl --progress-bar $PACKAGE_DOWNLOAD | tar -zox
  cd $PACKAGE
  ./configure
  make
  DESTDIR=$HERE/dist make install
  echo "Done Building $PACKAGE"
  cd $HERE
}

function build3 {
  PACKAGE=$PACKAGE_NAME-$PACKAGE_VERSION
  PACKAGE_DOWNLOAD=$PACKAGE_URL/$PACKAGE.tar.gzch
  echo "Building $PACKAGE from $PACKAGE_DOWNLOAD"
  cd $HERE/build
  curl --progress-bar $PACKAGE_DOWNLOAD | tar -zox
  mkdir -p $PACKAGE-build
  cd $PACKAGE-build
  ./../$PACKAGE/configure
  make
  DESTDIR=$HERE/dist make install
  echo "Done Building $PACKAGE"
  cd $HERE
}


