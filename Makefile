ZZ ?= $(shell which zz)
CWD ?= $(shell pwd)

ZZFLAGS =

export ZZ_MODULE_PATHS += ":$(CWD)/.."

default: build

release: ZZFLAGS+="--release -0"
release: build

build:
	$(ZZ) build $(ZZFLAGS)

clean:
	$(ZZ) clean

check:
	$(ZZ) check

test:
	$(ZZ) test $(TEST)

bench:
	$(ZZ) bench

CWD ?= $(shell pwd)

.PHONY: libsodium

build: libsodium

libsodium: target/lib/libsodium.a

target/lib/libsodium.a:
	git submodule update --init
	mkdir -p target
	{ \
		cd libsodium && \
		autoconf && \
		sh ./autogen.sh -f && \
		CFLAGS=-fPIC ./configure --disable-shared --prefix=$(CWD)/target && \
		make && \
		make install && \
		cp -f $(CWD)/target/lib/pkgconfig/libsodium.pc $(CWD)/libsodium.pc && \
		find $(CWD)/target/include/sodium/**.h -type f | xargs sed 's/sodium\//.\//g' -i; \
	} >&2

distclean: clean
	$(MAKE) $@ -C libsodium
