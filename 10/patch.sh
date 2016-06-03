#!/bin/bash

SRC_BASE=`pwd`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
PACKAGE_LIST=$1
if [ -z "${PACKAGE_LIST}" ]; then
	PACKAGE_LIST=`cat package_list`
fi

for PACKAGE in ${PACKAGE_LIST}; do
	[ -d "${SRC_BASE}/${PACKAGE}" ] || exit 1
	if [ -d "${SRC_BASE}/${PACKAGE}-patchset" -a ! -f "${SRC_BASE}/${PACKAGE}/.patchset_applied" ]; then
		if [ -x "${SRC_BASE}/patch_${PACKAGE}.sh" ]; then
			${SRC_BASE}/patch_${PACKAGE}.sh || exit 1
		else
			echo -e "\nCopying patch set for '${PACKAGE}'...\n"
			cd ${SRC_BASE}/${PACKAGE}-patchset
			tar cvf - `find . -type f -name "*.patch"` | tar xvf - -C ${SRC_BASE}/${PACKAGE}
			echo -e "\nPatching '${PACKAGE}'...\n"
			for PATCH in `find ${SRC_BASE}/${PACKAGE}/ -name "*.patch"`; do
				ORIGINAL=`echo ${PATCH} | sed -r 's/\.patch$//'`
				[ -f "${ORIGINAL}" ] || touch ${ORIGINAL}
				patch -bENp0 ${ORIGINAL} < ${PATCH} || exit 1
			done
		fi
		touch "${SRC_BASE}/${PACKAGE}/.patchset_applied"
	fi
done
