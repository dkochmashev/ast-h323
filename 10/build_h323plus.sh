#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
if [ "${1}" == "debug" ]; then
	BUILD_TYPE=debug
else
	BUILD_TYPE=opt
fi

export SPANDSPDIR="${SRC_BASE}/spandsp"
export PTLIBDIR="${SRC_BASE}/ptlib"

export CXXFLAGS="-I${SPANDSPDIR}/src"
export CFLAGS="${CXXFLAGS}"
export LDFLAGS="-L${SPANDSPDIR}/src/.libs"

K_DIR1=/usr/src/kernels/`uname -r`-`uname -m`/include
K_DIR2=/usr/src/kernels/`uname -r`/include

[ -d $K_DIR1 ] && export CXXFLAGS="${CXXFLAGS} -I$K_DIR1"
[ -d $K_DIR2 ] && export CXXFLAGS="${CXXFLAGS} -I$K_DIR2"
[ -n "${2}" ] && INSTALL_PREFIX="--prefix=${2}"

cd "${SRC_BASE}/h323plus"
		
./configure \
        ${INSTALL_PREFIX} \
        --disable-h224 \
	--enable-h4609 \
	--enable-h46017 \
	--enable-h46018 \
	--enable-h46019m \
	--enable-h46023 \
	--enable-h460p \
	--disable-gnugk \
	--enable-spandsp && \
${MAKE_CMD} ${BUILD_TYPE}
