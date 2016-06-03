[ -h spandsp ] && echo "Already exists" && exit
if [ ! -d spandsp-0.0.6pre21 ]; then
	if [ ! -f spandsp-0.0.6pre21.tgz ]; then
		wget http://www.soft-switch.org/downloads/spandsp/spandsp-0.0.6pre21.tgz || exit 1
	fi
	tar xvzf spandsp-0.0.6pre21.tgz || exit 1
	mv -vf spandsp-0.0.6 spandsp-0.0.6pre21 || exit 1
fi
if [ -d spandsp-0.0.6pre21 ]; then
	ln -svnf spandsp-0.0.6pre21 spandsp
else
	exit 1
fi
