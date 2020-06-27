CWD ?= $(shell pwd)

build: libsodium
libsodium: target/lib/libsodium.a
target/lib/libsodium.a:
	git submodule update --init
	mkdir -p target
	{ \
		cd libsodium && \
		autoconf -f; \
		sh ./autogen.sh -f && \
		CFLAGS=-fPIC ./configure --disable-shared --prefix=$(CWD)/target && \
		make && \
		make install && \
		find $(CWD)/target/include/sodium/**.h -type f | xargs sed 's/sodium\//.\//g' -i; \
	} >&2

distclean:
	$(MAKE) $@ -C libsodium
