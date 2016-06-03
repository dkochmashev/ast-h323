if [ ! -d pkg-config-0.26 ]; then
	if [ ! -f pkg-config-0.26.tar.gz ]; then
		wget http://pkgconfig.freedesktop.org/releases/pkg-config-0.26.tar.gz || exit 1
	fi
	tar xvzf pkg-config-0.26.tar.gz || exit 1
fi
if [ -d pkg-config-0.26 ]; then
	ln -svnf pkg-config-0.26 pkg-config
else
	exit 1
fi
