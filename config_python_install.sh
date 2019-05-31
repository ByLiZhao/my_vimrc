./configure --enable-shared --enable-optimizations --with-openssl=/usr/local \
            --prefix=/usr/local \
            LDFLAGS="-Wl,--rpath=/usr/local/lib"
