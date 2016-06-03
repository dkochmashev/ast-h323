#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
if [ "${1}" == "debug" ]; then
	BUILD_TYPE=debug
else
	BUILD_TYPE=opt
fi

export ASTERISKDIR="${SRC_BASE}/asterisk"

[ -n "${2}" ] && INSTALL_PREFIX="--prefix=${2}"
        
cd "${SRC_BASE}/asterisk-sccp"

./configure \
	${INSTALL_PREFIX} \
	--with-asterisk=${ASTERISKDIR} && \
${MAKE_CMD}
