function rpm_update_old_pkg() {
	local RPM_PKG_DESCR=$1
	local RPM_PKG_NAME=""
	local RPM_PKG_VER=""
	local RPM_PKG_URL=""

	if [[ ${RPM_PKG_DESCR} =~ ^([^\*]+)\|([^\*]+)\|([^\*]+)$ ]]; then
		RPM_PKG_NAME=${BASH_REMATCH[1]}
		RPM_PKG_VER=${BASH_REMATCH[2]}
		RPM_PKG_URL=${BASH_REMATCH[3]}
	fi
	RPM_PKG_VER_INST=`rpm -q --qf "%{version}" ${RPM_PKG_NAME} | perl -e '@v = split /[\.\-]/, <STDIN>; $s = scalar(@v); for (@v) { $ver += $_ * 100**(--$s); } print "$ver\n";' 2>/dev/null`
	if [ $? -ne 0 ] || [ ${RPM_PKG_VER_INST} -lt ${RPM_PKG_VER} ]; then
		rpmbuild --rebuild ${RPM_PKG_URL}
	fi
}

yum install -y rpm-build
rpm_update_old_pkg "make|382|http://vault.centos.org/7.0.1406/os/Source/SPackages/make-3.82-21.el7.src.rpm"

FPBX_BUILD_DEPS="
	bison
	bluez-libs-devel
	curl-devel
	cvs
	flex
	freetds-devel
	iksemel-devel
	jack-audio-connection-kit-devel
	libc-client-devel
	libical-devel
	libogg-devel
	libopenr2-devel
	libresample-devel
	libtool-ltdl-devel
	libuuid-devel
	libvorbis-devel
	libxml2-devel
	lm_sensors-devel
	lua-devel
	mysql-devel
	ncurses-devel
	neon-devel
	net-snmp-devel
	newt-devel
	openldap-devel
	postgresql-devel
	rpm-build
	speex-devel
	sqlite2-devel
	sqlite-devel
	unixODBC-devel
"

for FPBX_BUILD_DEP in ${FPBX_BUILD_DEPS}; do
	rpm -q --whatprovides ${FPBX_BUILD_DEP} || FPBX_BUILD_DEP_INST="${FPBX_BUILD_DEP_INST}${FPBX_BUILD_DEP}"
	[ -n "${FPBX_BUILD_DEP_INST}" ] && FPBX_BUILD_DEP_INST="${FPBX_BUILD_DEP_INST} "
done

[ -z "${FPBX_BUILD_DEP_INST}" ] || yum install -y ${FPBX_BUILD_DEP_INST}
