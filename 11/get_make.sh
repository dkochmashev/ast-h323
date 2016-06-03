if [ ! -d make-3.82 ]; then
	if [ ! -f make-3.82.tar.bz2 ]; then
		wget http://ftp.gnu.org/gnu/make/make-3.82.tar.bz2 || exit 1
	fi
	tar xvjf make-3.82.tar.bz2 || exit 1
fi
if [ -d make-3.82 ]; then
	ln -svnf make-3.82 make
else
	exit 1
fi
