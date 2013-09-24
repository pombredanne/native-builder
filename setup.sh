#!/bin/sh
HERE=`pwd`
mkdir -p $HERE/dist
mkdir -p $HERE/build

chmod u+x $HERE/bin/mingw
export PATH="$HERE/bin:$PATH"
chmod u+x *

function build {
  PACKAGE=$PACKAGE_NAME-$PACKAGE_VERSION
  PACKAGE_DOWNLOAD=$PACKAGE_URL/$PACKAGE.tar.gz
  echo "Building $PACKAGE"
  cd $HOME/build && \
  curl --progress-bar $PACKAGE_DOWNLOAD | tar -zox
  cd $PACKAGE && \
  mingw configure --host=$HOST_TARGET && \
  mingw make
  DESTDIR=$HERE/dist mingw make install
  echo "Done Building $PACKAGE"
  cd
}

