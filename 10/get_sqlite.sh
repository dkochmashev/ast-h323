if [ ! -d sqlite-autoconf-3071502 ]; then
	if [ ! -f sqlite-autoconf-3071502.tar.gz ]; then
		wget http://www.sqlite.org/sqlite-autoconf-3071502.tar.gz || exit 1
	fi
	tar xvzf sqlite-autoconf-3071502.tar.gz || exit 1
fi
if [ -d sqlite-autoconf-3071502 ]; then
	ln -svnf sqlite-autoconf-3071502 sqlite
else
	exit 1
fi
