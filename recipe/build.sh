#!/bin/bash

autoreconf -vfi

export CFLAGS="-g -O3 $CFLAGS"

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
