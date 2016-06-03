#!/bin/bash

export BUILD_BASE=~/rpmbuild/BUILD
export SRC_BASE=`pwd`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

TOOLS=`cat ${SRC_BASE}/tools`

if [ -x "${SRC_BASE}/pre-build-tools.sh" ]; then
	${SRC_BASE}/pre-build-tools.sh debug || exit 1
fi

for TOOL in ${TOOLS}; do
	${SRC_BASE}/get.sh ${TOOL} || exit 1
	${SRC_BASE}/build-debug.sh ${TOOL} || exit 1
	${SRC_BASE}/install.sh ${TOOL} || exit 1
done

${SRC_BASE}/get.sh || exit 1

if [ -x "${SRC_BASE}/pre-build-packages.sh" ]; then
	${SRC_BASE}/pre-build-packages.sh debug || exit 1
fi

${SRC_BASE}/build-debug.sh || exit 1

if [ -x "${SRC_BASE}/pre-install-packages.sh" ]; then
	${SRC_BASE}/pre-install-packages.sh debug || exit 1
fi

${SRC_BASE}/install.sh
