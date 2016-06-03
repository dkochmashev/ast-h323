#!/bin/bash

SRC_BASE=`pwd`
PACKAGE_LIST=$1
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
[ -n "${PACKAGE_LIST}" ] || PACKAGE_LIST=`cat ${SRC_BASE}/package_list`

. "${SRC_BASE}/os_info.sh"

for PACKAGE in ${PACKAGE_LIST}; do
	if [ -h "${PACKAGE}" ]; then
		if [ -x "${SRC_BASE}/pre-install_${PACKAGE}.sh" ]; then
			echo -e "\nExecuting pre-installation script for  '${PACKAGE}'...\n"
			${SRC_BASE}/pre-install_${PACKAGE}.sh || exit 1
		fi
		echo -e "\nInstalling '${PACKAGE}'...\n"
		if [ -x "${SRC_BASE}/install_${PACKAGE}.sh" ]; then
			${SRC_BASE}/install_${PACKAGE}.sh || exit 1
		else
			cd ${PACKAGE}
			${MAKE_CMD} install || exit 1
			cd ${SRC_BASE}
		fi
	fi
done
