#!/bin/bash

BUILD_BASE=~/rpmbuild/BUILD
SRC_BASE=`pwd`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
PACKAGE_LIST=$1
[ -n "${PACKAGE_LIST}" ] || PACKAGE_LIST=`cat ${SRC_BASE}/package_list`

export BUILD_BASE SRC_BASE

. "${SRC_BASE}/os_info.sh"

for PACKAGE in ${PACKAGE_LIST}; do
	cd $SRC_BASE
	if [ -x "${SRC_BASE}/pre-install_${PACKAGE}.sh" ]; then
		echo -e "\nExecuting pre-installation script for  '${PACKAGE}'...\n"
		${SRC_BASE}/pre-install_${PACKAGE}.sh || exit 1
	fi
	echo -e "\nInstalling '${PACKAGE}'...\n"
	if [ -x "${SRC_BASE}/install_${PACKAGE}.sh" ]; then
		${SRC_BASE}/install_${PACKAGE}.sh || exit 1
	elif [ -h "${PACKAGE}" ]; then
		cd ${PACKAGE}
		${MAKE_CMD} install || exit 1
		cd ${SRC_BASE}
	fi
done
