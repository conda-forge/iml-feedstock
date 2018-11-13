#!/bin/bash

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
        --with-cblas="-lopenblas" \
        --with-cblas-include="$PREFIX/include"

make
make check
make install
