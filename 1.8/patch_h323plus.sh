#!/bin/bash

SRC_BASE=`pwd`
PACKAGE_LIST=$1
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

cd "${SRC_BASE}/h323plus"
echo -e "\nPatching 'h323plus'...\n"
patch -bENp0 < "${SRC_BASE}/h323plus-patchset/patchset.diff" || exit 1
