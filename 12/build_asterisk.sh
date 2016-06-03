#!/bin/bash

SRC_BASE=`pwd`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
if [ "${1}" == "debug" ]; then
	BUILD_TYPE=debug
else
	BUILD_TYPE=opt
fi
[ "${HOSTTYPE}" == "x86_64" ] && ARCH_SUFFIX="_64"

export CURLDIR="${SRC_BASE}/curl"
export SQLITEDIR="${SRC_BASE}/sqlite"
export SPANDSPDIR="${SRC_BASE}/spandsp"
export PWLIBDIR="${SRC_BASE}/ptlib"
export OPENH323DIR="${SRC_BASE}/h323plus"

export LDFLAGS="-L${CURLDIR}/lib/.libs -L${SQLITEDIR}/.libs -L${SPANDSPDIR}/src/.libs"
export CPPFLAGS="-I${CURLDIR}/include -I${SQLITEDIR} -I${SPANDSPDIR}/src -I${PWLIBDIR}/include -I${OPENHH323DIR}/include"
if [ "`uname`" != "Linux" ]; then
	export CPPFLAGS="${CPPFLAGS} ${LDFLAGS}"
fi
export CFLAGS="${CPPFLAGS} -fexceptions"

cd "${SRC_BASE}/asterisk"

if [ ! -f configure ]; then
	./bootstrap.sh || exit 1
fi

[ -n "${2}" ] && INSTALL_PREFIX="--prefix=${2}"

./configure \
	${INSTALL_PREFIX} \
	--with-spandsp \
	--with-h323=${BUILD_TYPE} && \
${MAKE_CMD}
