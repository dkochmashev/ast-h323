#!/bin/bash

export BUILD_BASE=~/rpmbuild/BUILD
export SRC_BASE=`pwd`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
PACKAGE_LIST=$1
[ -n "${PACKAGE_LIST}" ] || PACKAGE_LIST=`cat ${SRC_BASE}/package_list`

. "${SRC_BASE}/os_info.sh"

export PATH="${HOME}/bin:${PATH}"

for PACKAGE in ${PACKAGE_LIST}; do
	cd $SRC_BASE
	if [ -x "${SRC_BASE}/pre-build_${PACKAGE}.sh" ]; then
		echo -e "\nExecuting pre-build script for '${PACKAGE}'...\n"
		${SRC_BASE}/pre-build_${PACKAGE}.sh debug || exit 1
	fi
	if [ -x "${SRC_BASE}/build_${PACKAGE}.sh" ]; then
		echo -e "\nBuilding '${PACKAGE}'...\n"
		${SRC_BASE}/build_${PACKAGE}.sh debug || exit 1
	fi
done
