FPBX_SRPM_URL=http://yum.freepbxdistro.org/pbx/SRPMS/asterisk/11/
FPBX_SRPM_FILES="
	asterisk11-11.14.1-1.shmz65.1.39.src.rpm
	asterisk11-flite-11.14.1-1.shmz65.1.10.src.rpm
	asterisk11-res_digium_phone-2.1.1-1.shmz65.1.13.src.rpm
"
for FPBX_SRPM_FILE in ${FPBX_SRPM_FILES}; do
	[ -f "${FPBX_SRPM_FILE}" ] || FPBX_SRPM_URLS="${FPBX_SRPM_URLS} -O ${FPBX_SRPM_URL}${FPBX_SRPM_FILE}"
	[ -n "${FPBX_SRPM_URLS}" ] && FPBX_SRPM_URLS="${FPBX_SRPM_URLS} "
done

[ -z "${FPBX_SRPM_URLS}" ] || curl ${FPBX_SRPM_URLS} || exit 1
                
FPBX_SRPM_SPECS="
	asterisk11.spec
	flite.spec
	res_digium_phone.spec
"

cd ~/rpmbuild/SPECS
rpmbuild -bp ${FPBX_SRPM_SPECS} --define '_without_misdn 1'
ln -svnf asterisk-11.14.1 asterisk
rm -vf asterisk/configure
