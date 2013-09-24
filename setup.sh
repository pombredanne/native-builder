#!/bin/sh
mkdir -p $HOME/dist
mkdir -p $HOME/build

chmod u+x $HOME/bin/mingw
export PATH="$HOME/bin:$PATH"
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
  DESTDIR=$HOME/dist mingw make install
  echo "Done Building $PACKAGE"
  cd
}

