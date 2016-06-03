#!/bin/bash

SRC_BASE=`pwd`
PACKAGE_LIST=$1
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`
[ -n "${PACKAGE_LIST}" ] || PACKAGE_LIST=`cat ${SRC_BASE}/package_list`

cd ${SRC_BASE}

for PACKAGE in ${PACKAGE_LIST}; do
	if [ -d "${PACKAGE}" ]; then
		if [ -x "${SRC_BASE}/mkps_${PACKAGE}.sh" ]; then
			${SRC_BASE}/mkps_${PACKAGE}.sh
		else
			PKG_ORIG_LIST=`find "${PACKAGE}/" -name "*.orig"`
			for PKG_ORIG in ${PKG_ORIG_LIST} ; do
				PKG_SRC=`echo ${PKG_ORIG} | sed -r 's/\.orig$//g'`
				PKG_PATCH="${PKG_SRC}.patch"
				diff -u "${PKG_ORIG}" "${PKG_SRC}" > "${PKG_PATCH}"
				PKG_PATCH_LIST="${PKG_PATCH_LIST} ${PKG_PATCH}"
			done
			if [ -n "${PKG_PATCH_LIST}" ]; then
				PKG_DATETIME=`date +%Y%m%d`
				PKG_PATCHSET_SEQ_NUM=1
				PKG_PATCHSET="${PACKAGE}-patchset_${PKG_DATETIME}-${PKG_PATCHSET_SEQ_NUM}.tar.bz2"
				while test -f "${PKG_PATCHSET}" ; do
					PKG_DATETIME=`date +%Y%m%d`
					PKG_PATCHSET="${PACKAGE}-patchset_${PKG_DATETIME}-$((PKG_PATCHSET_SEQ_NUM++)).tar.bz2"
				done
				echo -e "Creating patch set archive...\n"
				tar cvjf ${PKG_PATCHSET} ${PKG_PATCH_LIST}
				echo -e "\nInstalling new patch set...\n"
				[ -d "${PACKAGE}-patchset" ] || mkdir -p "${PACKAGE}-patchset"
				tar xvjf ${PKG_PATCHSET} -C ${PACKAGE}-patchset/ --strip-components 1
			fi
		fi
	fi
done
