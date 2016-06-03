[ -h asterisk ] && echo "Already exists" && exit
if [ ! -d asterisk-1.8.26.1 ]; then
	if [ ! -f asterisk-1.8.26.1.tar.gz ]; then
		wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-1.8.26.1.tar.gz || exit 1
	fi
	tar xvzf asterisk-1.8.26.1.tar.gz || exit 1
	rm -vf asterisk-1.8.26.1/configure || exit 1
fi
if [ -d asterisk-1.8.26.1 ]; then
	ln -svnf asterisk-1.8.26.1 asterisk
else
	exit 1
fi
