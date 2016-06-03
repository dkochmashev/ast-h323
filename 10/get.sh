#!/bin/bash

SRC_BASE=`pwd`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

PACKAGE_LIST=$1
if [ -z "${PACKAGE_LIST}" ]; then
	PACKAGE_LIST=`cat package_list`
else
	[ -n "${2}" ] && GET_LATEST="_latest"
fi

export PATH=${HOME}/bin:${PATH}

for PACKAGE in ${PACKAGE_LIST}; do
	if [ -x "${SRC_BASE}/get_${PACKAGE}${GET_LATEST}.sh" ]; then
		echo -e "\nFetching '${PACKAGE}'...\n"
		${SRC_BASE}/get_${PACKAGE}${GET_LATEST}.sh
		if [ $? -ne 0 ]; then
			echo "Error fetching package ${PACKAGE}!"
			exit 1
		fi
		${SRC_BASE}/patch.sh ${PACKAGE}
	else
		echo "Unable to fetch package ${PACKAGE}! get_${PACKAGE}.sh script doesn't exist."
		exit 1
	fi
done
