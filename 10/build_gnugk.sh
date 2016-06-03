#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
if [ "${1}" == "debug" ]; then
	BUILD_TYPE=debug
else
	BUILD_TYPE=opt
fi

export PTLIBDIR="${SRC_BASE}/ptlib"
export H323PLUSDIR="${SRC_BASE}/h323plus"
export PWLIBDIR=${PTLIBDIR}
export OPENH323DIR=${H323PLUSDIR}
export CFLAGS="-I${SRC_BASE}/libssh/include -I${SRC_BASE}/net-snmp/include"
export LDFLAGS="-L${SRC_BASE}/libssh/build/src -L${SRC_BASE}/net-snmp/snmplib/.libs"

[ -n "${2}" ] && INSTALL_PREFIX="--prefix=${2}"
        
cd "${SRC_BASE}/gnugk"

./configure \
	${INSTALL_PREFIX} \
	--enable-radius \
	--disable-h46017 \
	--disable-h46018 \
	--disable-h46023 \
	--disable-mysql \
	--disable-pgsql \
	--disable-firebird \
	--disable-unixodbc \
	--disable-sqlite \
	--with-large-fdset=8192 && \
${MAKE_CMD} ${BUILD_TYPE}
