#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
[ -n "${2}" ] && INSTALL_PREFIX="--prefix=${2}"
                
cd "${SRC_BASE}/m4"

./configure \
        ${INSTALL_PREFIX} && \
${MAKE_CMD}
