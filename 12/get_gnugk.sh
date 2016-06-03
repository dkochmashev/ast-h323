[ -h gnugk ] && echo "Already exists" && exit
if [ ! -d gnugk-2.3.2e_20130305-1 ]; then
	if [ ! -f gnugk-2.3.2e_20130305-1.tar.bz2 ]; then
		wget http://files.tmc.enforta.net/mmsvc/v23/pkg/gnugk-2.3.2e_20130305-1.tar.bz2
	fi
	tar xvjf gnugk-2.3.2e_20130305-1.tar.bz2 || exit 1
fi
if [ -d gnugk-2.3.2e_20130305-1 ]; then
	ln -svnf gnugk-2.3.2e_20130305-1 gnugk
else
	exit 1
fi
