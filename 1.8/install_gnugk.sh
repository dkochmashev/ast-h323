#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

ARC=`uname -m`
[ "${ARC}" == "x86_64" ] || ARC=x86

cd "${SRC_BASE}/gnugk"

echo '#include <iostream>
#include "version.h"

int main(void) {
	std::cout << GNUGK_MAJOR_VERSION << "." << GNUGK_MINOR_VERSION << "." << GNUGK_BUILD_NUMBER << std::endl;
	return 0;
}
' > version-mmsvc.cxx && \
g++ -o version-mmsvc version-mmsvc.cxx && \
export GNUGK_VERSION=`./version-mmsvc` && \
rm -f version-mmsvc.cxx version-mmsvc
GK_DIR=obj_linux_${ARC}
cp -vfP "${GK_DIR}_d/gnugk" ${HOME}/bin/gnugk-${GNUGK_VERSION}-debug && \
ln -svnf gnugk-${GNUGK_VERSION}-debug ${HOME}/bin/gnugk
