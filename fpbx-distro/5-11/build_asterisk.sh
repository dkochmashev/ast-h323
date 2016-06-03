export PWLIBDIR="${SRC_BASE}/ptlib"
export PTLIBDIR=${PWLIBDIR}
export OPENH323DIR="${SRC_BASE}/h323plus"
export H323PLUSDIR=${OPENH323DIR}
export CPPFLAGS="-I${PWLIBDIR}/include -I${OPENHH323DIR}/include"
[ "`uname`" != "Linux" ] && export CPPFLAGS="${CPPFLAGS} ${LDFLAGS}"
export CFLAGS="${CPPFLAGS} -fexceptions"

FPBX_SRPM_SPECS="
	asterisk11.spec
	flite.spec
	res_digium_phone.spec
"
                        
cd ~/rpmbuild/SPECS
if [ "${1}" == "debug" ]; then
	rpmbuild -ba ${FPBX_SRPM_SPECS} --define 'asteriskversion 11.14.1' --define 'dist .shmz65' --define '_without_optimizations 1' --define '_without_misdn 1'
else
	rpmbuild -ba ${FPBX_SRPM_SPECS} --define 'asteriskversion 11.14.1' --define 'dist .shmz65' --define '_without_misdn 1'
fi
