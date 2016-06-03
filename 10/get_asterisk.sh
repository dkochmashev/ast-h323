[ -h asterisk ] && echo "Already exists" && exit
if [ ! -d asterisk-10.12.4 ]; then
	if [ ! -f asterisk-10.12.4.tar.gz ]; then
		wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-10.12.4.tar.gz || exit 1
	fi
	tar xvzf asterisk-10.12.4.tar.gz || exit 1
	rm -vf asterisk-10.12.4/configure || exit 1
fi
if [ -d asterisk-10.12.4 ]; then
	ln -svnf asterisk-10.12.4 asterisk
else
	exit 1
fi
