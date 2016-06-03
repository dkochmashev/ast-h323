#!/bin/bash

SRC_BASE=`pwd`
PACKAGE_LIST=$1
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

cd "${SRC_BASE}/h323plus"
echo -e "\nInstalling new patch set...\n"
[ -d "${SRC_BASE}/h323plus-patchset" ] || mkdir -p "${SRC_BASE}/h323plus-patchset"
cvs diff -u > "${SRC_BASE}/h323plus-patchset/patchset.diff"
