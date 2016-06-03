if [ ! -d autoconf-2.69 ]; then
	if [ ! -f autoconf-2.69.tar.gz ]; then
		wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz || exit 1
	fi
	tar xvzf autoconf-2.69.tar.gz || exit 1
fi
if [ -d autoconf-2.69 ]; then
	ln -svnf autoconf-2.69 autoconf
else
	exit 1
fi
