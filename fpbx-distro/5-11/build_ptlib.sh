if [ "${1}" == "debug" ]; then
	BUILD_TYPE=debug
else
	BUILD_TYPE=opt
fi

[ -n "${2}" ] && INSTALL_PREFIX="--prefix=${2}"
                        
cd "${SRC_BASE}/ptlib"

./configure \
	${INSTALL_PREFIX} && \
${MAKE_CMD} ${BUILD_TYPE}
