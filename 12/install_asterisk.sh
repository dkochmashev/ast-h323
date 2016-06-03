#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

cd "${SRC_BASE}/asterisk"

cp -vf main/asterisk ${HOME}/bin || exit 1
if [ "`uname`" == "Linux" ]; then
	cp -vf --no-dereference main/libasteriskssl.so* ${HOME}/lib || exit 1
else
	cp -vfR main/libasteriskssl.so* ${HOME}/lib || exit 1
fi
mkdir -p ${HOME}/lib/asterisk/modules || exit 1
for MODNAME_PFX in app bridge cdr chan codec format func pbx res ; do
	find . -name "${MODNAME_PFX}_*.so" -exec cp -vf \{} ${HOME}/lib/asterisk/modules \;
done
