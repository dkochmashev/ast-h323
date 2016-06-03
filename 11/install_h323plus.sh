#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

cd "${SRC_BASE}/h323plus"

if [ "`uname`" == "Linux" ]; then
	cp -vf --no-dereference lib/libh323_* ${HOME}/lib
else
	cp -vfR lib/libh323_* ${HOME}/lib
fi
