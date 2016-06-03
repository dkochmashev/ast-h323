#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
[ -n "${2}" ] && INSTALL_PREFIX="--prefix=${2}"

if [ "`uname`" == "FreeBSD" ]; then
	export CFLAGS="-I/usr/local/include"
	export LDFLAGS="-L/usr/local/lib"
fi

cd "${SRC_BASE}/spandsp"

./configure \
	${INSTALL_PREFIX} && \
${MAKE_CMD}
