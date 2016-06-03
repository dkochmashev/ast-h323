#!/bin/bash

SRC_BASE=`pwd`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

ln -svnf "${SRC_BASE}/package_list_extended" "${SRC_BASE}/package_list" || exit 1

${SRC_BASE}/get.sh $@
