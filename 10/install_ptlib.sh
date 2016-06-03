#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

cd "${SRC_BASE}/ptlib"

OSTYPE=`make/ptlib-config --ostype`
MACHTYPE=`make/ptlib-config --machtype`

if [ "`uname`" == "Linux" ]; then
	cp -vf --no-dereference lib_${OSTYPE}_${MACHTYPE}/libpt* ${HOME}/lib
else
	cp -vfR lib_${OSTYPE}_${MACHTYPE}/libpt* ${HOME}/lib
fi
