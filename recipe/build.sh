#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./config
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .

export CPPFLAGS="-I$PREFIX/include $CPPFLAGS"
export CFLAGS="-g -O3 $CFLAGS"

if [ "$(uname)" == "Linux" ]
then
   export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

chmod +x configure
./configure \
        --prefix="$PREFIX" \
        --libdir="$PREFIX/lib" \
        --enable-shared \
        --with-default="$PREFIX" \
        --with-cblas="-lcblas" \
        --with-cblas-include="$PREFIX/include"

make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check
fi
make install
