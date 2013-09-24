#!/bin/sh
mkdir -p $HOME/bin
mkdir -p $HOME/dist
mkdir -p $HOME/build

cat >$HOME/bin/mingw << EOF
#!/bin/sh
TOOLCHAIN=i686-w64-mingw32
export CC=$TOOLCHAIN-gcc
export CXX=$TOOLCHAIN-g++
export CPP=$TOOLCHAIN-cpp
export RANLIB=$TOOLCHAIN-ranlib
export PATH="/usr/$TOOLCHAIN/bin:$PATH"
export HOST_TARGET=i686-w64-mingw32
exec "$@"
EOF
chmod u+x $HOME/bin/mingw
export PATH="$HOME/bin:$PATH"

function build {
  PACKAGE=$PACKAGE_NAME-$PACKAGE_VERSION
  PACKAGE_DOWNLOAD=$PACKAGE_URL/$PACKAGE.tar.gz
  echo "Building $PACKAGE"
  cd $HOME/build && \
  curl --progress-bar $PACKAGE_DOWNLOAD | tar -zox
  cd $PACKAGE && \
  mingw ./configure --host=$HOST_TARGET && \
  mingw make
  DESTDIR=$HOME/dist mingw make install
  echo "Done Building $PACKAGE"
}
